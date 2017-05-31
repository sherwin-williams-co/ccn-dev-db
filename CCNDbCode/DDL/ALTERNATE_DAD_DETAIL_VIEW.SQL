CREATE OR REPLACE VIEW ALTERNATE_DAD_DETAIL_VIEW AS 
SELECT 
/*******************************************************************************
This View will give all the details of alternate dad hierarchy linked to the cost center

Created  : 02/16/2017 jxc517 CCN Project....
Modified : 05/30/2017 gxg192 Changes to remove COST_CENTER field as it containing
                      the same data as it is in COST_CENTER_CODE field.
*******************************************************************************/
       STATEMENT_TYPE,
       HRCHY_HDR_NAME,
       COST_CENTER_CODE,
       HRCHY_DTL_EFF_DATE,
       HRCHY_DTL_EXP_DATE,
       DOMAIN,
       "GROUP",
       DIVISION,
       AREA,
       DISTRICT,
       CITY_SALES_MANAGER,
       ZONE,
       SPECIAL_ROLES,
       DOMAIN_NAME,
       GROUP_NAME,
       DIVISION_NAME,
       AREA_NAME,
       DISTRICT_NAME,
       CITY_SALES_MANAGER_NAME,
       ZONE_NAME,
       SPECIAL_ROLES_NAME,
       COST_CENTER_NAME
  FROM HIERARCHY_DETAIL_VIEW
 WHERE HRCHY_HDR_NAME = 'ALTERNATE_DAD';
