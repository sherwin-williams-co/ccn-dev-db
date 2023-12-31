CREATE OR REPLACE VIEW GLOBAL_HIERARCHY_ATTRBT_VW AS  
SELECT 
/*******************************************************************************
This View holds all the details of global hierarchy linked to the cost center i.e. this view will 
have all the details of each and every level of the global hierarchy for a particular cost center.
It will also have all the upper level value attributes in separate columns for each level (1-9).

Created  : 10/14/2015 nxk927 CCN Project....
Modified : 11/12/2015 sxt410 CCN Project...
           Getting the Attributes using function to optimize the query.
         : 11/25/2015 AXK326 CCN Project Team....
           Modified *_UPPER_LVL_VER_VALUE to *_MGR_NAME to determine the manager names associated to it
         : 01/18/2015 nxk927 CCN Project Team....
           adding back the upper level value for each level
         : 07/08/2016 axd783 CCN Project Team....
           Modified CC_MGR_NAME to call new GET_STORE_MANAGER_NAME_FNC function instaed GET_EMPLOYEE_NAME function
         : 08/01/2016 jxc517 CCN Project Team....
           Added District Manager Gems Id field, modified the code to give proper Manager Names, 
           modified code to avoid multiple calls to get the same value
		 : 04/04/2017 pxb712 CCN Project Team....
           Added new columns CITY_MGR_GEMS_ID,DIV_MGR_GEMS_ID and AREA_MGR_GEMS_ID in the view.
         : 05/30/2017 gxg192 Changes to remove COST_CENTER field as it containing
           the same data as it is in COST_CENTER_CODE field.
         : 03/08/2018 jxc517 CCN Project Team....
           Adding new attribute "CITY/SLS MGR FLAG" to the view and its description
         : 03/28/2018 sxg151 CCN Project Team...
           Calling COMMON_TOOLS.GET_CC_MANAGER_NAME function to get the Mgr Name
         : 09/13/2018 kxm302 CCN Project Team...
		   Replaced the function(COMMON_TOOLS.GET_CC_MANAGER_NAME to CCN_DERIVED_VALUES.GET_CC_MANAGER_NAME)  to get CC_MGR_NAME ASP-1128.
*******************************************************************************/
       A.STATEMENT_TYPE,
       A.HRCHY_HDR_NAME,
       A.COST_CENTER_CODE,
       A.HRCHY_DTL_EFF_DATE,
       A.HRCHY_DTL_EXP_DATE,
       A.DOMAIN,
       A."GROUP",
       A.DIVISION,
       A.AREA,
       A.DISTRICT,
       A.CITY_SALES_MANAGER,
       A."ZONE",
       A.SPECIAL_ROLES,
       A.DOMAIN_NAME,
       A.GROUP_NAME,
       A.DIVISION_NAME,
       A.AREA_NAME,
       A.DISTRICT_NAME,
       A.CITY_SALES_MANAGER_NAME,
       A.ZONE_NAME,
       A.SPECIAL_ROLES_NAME,
       A.COST_CENTER_NAME,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.DOMAIN_UPPER_VALUE, 'ManagerName') DOMAIN_MGR_NAME,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.GROUP_UPPER_VALUE, 'ManagerName') GROUP_MGR_NAME,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.DIV_UPPER_VALUE, 'ManagerName') DIV_MGR_NAME,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.DIV_UPPER_VALUE, 'GEMS_ID') DIV_MGR_GEMS_ID,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.AREA_UPPER_VALUE, 'ManagerName') AREA_MGR_NAME,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.AREA_UPPER_VALUE, 'GEMS_ID') AREA_MGR_GEMS_ID,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.DISTRICT_UPPER_VALUE, 'ManagerName') DISTRICT_MGR_NAME,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.DISTRICT_UPPER_VALUE, 'GEMS_ID') DISTRICT_MGR_GEMS_ID,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.CITY_UPPER_VALUE, 'ManagerName') CITY_MGR_NAME,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.CITY_UPPER_VALUE, 'GEMS_ID') CITY_MGR_GEMS_ID,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.CITY_UPPER_VALUE, 'CITY/SLS MGR FLAG') CITY_SALES_MGR_FLAG,
       CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('CITY/SLS MGR FLAG','COD',CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.CITY_UPPER_VALUE, 'CITY/SLS MGR FLAG')) CITY_SALES_MGR_FLAG_DESC,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.ZONE_UPPER_VALUE, 'ManagerName') ZONE_MGR_NAME,
       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.SPECIAL_ROLES_UPPER_VALUE, 'ManagerName') SPECIAL_ROLES_MGR_NAME,
       A.CC_MGR_NAME,
       A.DOMAIN_UPPER_VALUE,
       A.GROUP_UPPER_VALUE,
       A.DIV_UPPER_VALUE,
       A.AREA_UPPER_VALUE,
       A.DISTRICT_UPPER_VALUE,
       A.CITY_UPPER_VALUE,
       A.ZONE_UPPER_VALUE,
       A.SPECIAL_ROLES_UPPER_VALUE,
       A.CC_UPPER_LVL_VALUE
  FROM (SELECT GV.*,
               CCN_DERIVED_VALUES.GET_CC_MANAGER_NAME(GV.COST_CENTER_CODE) CC_MGR_NAME,
               COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(GV.HRCHY_HDR_NAME, GV.DOMAIN, GV.DOMAIN||GV."GROUP", '~~~') DOMAIN_UPPER_VALUE,
               COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(GV.HRCHY_HDR_NAME, GV.DOMAIN||GV."GROUP", GV.DOMAIN||GV."GROUP"||GV.DIVISION, GV.DOMAIN) GROUP_UPPER_VALUE,
               COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(GV.HRCHY_HDR_NAME, GV.DOMAIN||GV."GROUP"||GV.DIVISION, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA, GV.DOMAIN||GV."GROUP") DIV_UPPER_VALUE,
               COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(GV.HRCHY_HDR_NAME, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT, GV.DOMAIN||GV."GROUP"||GV.DIVISION) AREA_UPPER_VALUE,
               COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(GV.HRCHY_HDR_NAME, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT||GV.CITY_SALES_MANAGER, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA) DISTRICT_UPPER_VALUE,
               COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(GV.HRCHY_HDR_NAME, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT||GV.CITY_SALES_MANAGER, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT||GV.CITY_SALES_MANAGER||GV."ZONE", GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT) CITY_UPPER_VALUE,
               COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(GV.HRCHY_HDR_NAME, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT||GV.CITY_SALES_MANAGER||GV."ZONE", GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT||GV.CITY_SALES_MANAGER||GV."ZONE"||GV.SPECIAL_ROLES, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT||GV.CITY_SALES_MANAGER) ZONE_UPPER_VALUE,
               COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(GV.HRCHY_HDR_NAME, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT||GV.CITY_SALES_MANAGER||GV."ZONE"||GV.SPECIAL_ROLES, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT||GV.CITY_SALES_MANAGER||GV."ZONE"||GV.SPECIAL_ROLES||GV.COST_CENTER_CODE, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT||GV.CITY_SALES_MANAGER||GV."ZONE") SPECIAL_ROLES_UPPER_VALUE,
               COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(GV.HRCHY_HDR_NAME, GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT||GV.CITY_SALES_MANAGER||GV."ZONE"||GV.SPECIAL_ROLES||GV.COST_CENTER_CODE, '~~~', GV.DOMAIN||GV."GROUP"||GV.DIVISION||GV.AREA||GV.DISTRICT||GV.CITY_SALES_MANAGER||GV."ZONE"||GV.SPECIAL_ROLES) CC_UPPER_LVL_VALUE
          FROM HIERARCHY_DETAIL_VIEW GV
         WHERE GV.HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY') A;
