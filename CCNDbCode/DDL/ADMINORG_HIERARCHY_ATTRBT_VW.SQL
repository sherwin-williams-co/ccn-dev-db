CREATE OR REPLACE VIEW ADMINORG_HIERARCHY_ATTRBT_VW
AS 
SELECT  
/*******************************************************************************
This View will give all the Admin Org Hierarchy details for the cost center passed

Created  : 01/09/2017 vxv336 CCN Project
Modified : 12/13/2017 mxv711 CCN Project
           02/13/2017 mxv711 CCN project
           fixed the view to consider the hierachy values upto cost center level only
           fixed getting the Employee names cosidering cost center code if last level
           is NULL .
*******************************************************************************/
       DISTINCT
        CC.STATEMENT_TYPE
       ,H.HRCHY_HDR_NAME
       ,CC.COST_CENTER_CODE
       ,H.HRCHY_DTL_EFF_DATE
       ,H.HRCHY_DTL_EXP_DATE
       ,H.DOMAIN_VAL DOMAIN
       ,H.GROUP_VAL "GROUP"
       ,H.DIVISION_VAL DIVISION
       ,H.AREA_VAL AREA
       ,H.DISTRICT_VAL DISTRICT
       ,H.CITY_SALES_MANAGER_VAL CITY_SALES_MANAGER
       ,H.ZONE_VAL "ZONE"
       ,H.COST_CENTER_CODE AS COST_CENTER
       ,H.DOMAIN_VAL_NAME DOMAIN_NAME
       ,H.GROUP_VAL_NAME GROUP_NAME
       ,H.DIVISION_VAL_NAME DIVISION_NAME
       ,H.AREA_VAL_NAME AREA_NAME
       ,H.DISTRICT_VAL_NAME DISTRICT_NAME
       ,H.CITY_SALES_MANAGER_VAL_NAME CITY_MGR_NAME
       ,H.ZONE_VAL_NAME ZONE_NAME
       ,CC.COST_CENTER_NAME
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL,
                                                                                     H.DOMAIN_VAL||NVL(H.GROUP_VAL,H.COST_CENTER_CODE),
                                                                                     '~~~'),
                                                'EmployeeName') DOMAIN_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||NVL(H.DIVISION_VAL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN_VAL),
                                                'GEMS_ID') GROUP_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||NVL(H.DIVISION_VAL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN_VAL),
                                                'EmployeeName') GROUP_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||NVL(H.AREA_VAL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL),
                                                'GEMS_ID') DIVISION_VAL_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||NVL(H.AREA_VAL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL),
                                                'EmployeeName') DIVISION_VAL_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||NVL(H.DISTRICT_VAL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL),
                                                'GEMS_ID') AREA_VAL_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||NVL(H.DISTRICT_VAL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL),
                                                'EmployeeName') AREA_VAL_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||NVL(H.CITY_SALES_MANAGER_VAL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL),
                                                'GEMS_ID') DISTRICT_VAL_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||NVL(H.CITY_SALES_MANAGER_VAL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL),
                                                'EmployeeName') DISTRICT_VAL_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||H.CITY_SALES_MANAGER_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||H.CITY_SALES_MANAGER_VAL|| NVL(H.ZONE_VAL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL),
                                                'GEMS_ID') CITY_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||H.CITY_SALES_MANAGER_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||H.CITY_SALES_MANAGER_VAL||NVL(H.ZONE_VAL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL),
                                                'EmployeeName') CITY_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||H.CITY_SALES_MANAGER_VAL||H.ZONE_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||H.CITY_SALES_MANAGER_VAL||H.ZONE_VAL||H.COST_CENTER_CODE,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||H.CITY_SALES_MANAGER_VAL),
                                                'GEMS_ID') ZONE_VAL_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||H.CITY_SALES_MANAGER_VAL||H.ZONE_VAL,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||H.CITY_SALES_MANAGER_VAL||H.ZONE_VAL||H.COST_CENTER_CODE,
                                                                                     H.DOMAIN_VAL||H.GROUP_VAL||H.DIVISION_VAL||H.AREA_VAL||H.DISTRICT_VAL||H.CITY_SALES_MANAGER_VAL),
                                                'EmployeeName') ZONE_VAL_EMP_NAME
FROM COST_CENTER CC,
        --inner sub query "T" gives all the hierarchy details with all the levels
        --present in the CCN system by joining the header, description and detail tables
       (WITH T AS (SELECT HDESC.HRCHY_HDR_LVL_DESC DESCRIPTION,
                          HD.HRCHY_DTL_CURR_ROW_VAL COST_CENTER_CODE,
                          HD.HRCHY_HDR_NAME,
                          HD.HRCHY_DTL_EFF_DATE,
                          HD.HRCHY_DTL_EXP_DATE,
                          HD.HRCHY_DTL_CURR_LVL_VAL,
                          -- 1 + sum of level values till that level - level value for that level = starting point for this level
                          -- Curr level value length - Already substringed = Remaining length
                          -- get the hierachy values upto cost center level skip the non existent values.
                          SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1 + HDESC.SUM_VAL - HDESC.LVL_VALUE_SIZE, CASE WHEN floor(LENGTH(HD.HRCHY_DTL_CURR_LVL_VAL)/4) < HRCHY_HDR_LVL_NBR+1  THEN 0 ELSE HDESC.LVL_VALUE_SIZE END) VAL,
                          --Get the description upto the existing levels only.
                          (SELECT HRCHY_DTL_DESC
                             FROM HIERARCHY_DETAIL
                            WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1, HDESC.SUM_VAL)
                              AND HRCHY_DTL_LEVEL <  floor(LENGTH(HD.HRCHY_DTL_CURR_LVL_VAL)/4)
                              AND HRCHY_HDR_NAME  = HDESC.HRCHY_HDR_NAME
                              AND ROWNUM < 2)  VAL_NAME
                     FROM HIERARCHY_DETAIL HD,
                          HIERARCHY_HEADER HH,
                          (SELECT HRCHY_HDR_NAME,
                                  HRCHY_HDR_LVL_NBR,
                                  HRCHY_HDR_LVL_DESC,
                                  LVL_VALUE_SIZE,
                                  SUM(LVL_VALUE_SIZE) OVER (PARTITION BY HRCHY_HDR_NAME ORDER BY HRCHY_HDR_LVL_NBR) SUM_VAL
                             FROM HIERARCHY_DESCRIPTION) HDESC
                    WHERE HD.HRCHY_HDR_NAME  = HDESC.HRCHY_HDR_NAME
                      AND HD.HRCHY_HDR_NAME  = HH.HRCHY_HDR_NAME
                      AND HD.HRCHY_HDR_NAME  = 'ADMINORG_HIERARCHY'
                      AND NVL(HD.HRCHY_DTL_NEXT_LVL_VAL, '~~~') = '~~~')
             SELECT *
               FROM T
                    --PIVOT function convers this entire result set into a transpose (level of rows to level of columns)
                    --so that we get one record for each hierarchy with all level values as its columns
                    PIVOT 
                    (MAX(VAL) AS VAL,
                     MAX(VAL_NAME) AS VAL_NAME FOR (DESCRIPTION) IN ('Domain' AS DOMAIN,
                                                                     'Group' AS "GROUP",
                                                                     'Division' AS DIVISION,
                                                                     'Area' AS AREA,
                                                                     'District' AS DISTRICT,

                                                                     'City/Sales Manager' AS CITY_SALES_MANAGER,
                                                                     'Zone' AS "ZONE"))) H
--Finally result of the above two steps(WITH T and PIVOT) will be a new result set "H" which can be used as any other
--table in a join condition
WHERE CC.COST_CENTER_CODE = H.COST_CENTER_CODE
ORDER BY COST_CENTER_CODE, HRCHY_HDR_NAME;