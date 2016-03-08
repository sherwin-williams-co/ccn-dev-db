CREATE OR REPLACE VIEW ADMIN_TO_SALES_HIERARCHY_VW
AS SELECT
/*******************************************************************************
This View will give all the details of Admin_to_sales_division, Admin_to_sales_area
and Admin_to_sales_district hierarchies for linked to the cost center

Created  : 10/28/2015 SXT410 CCN Project....
Modified : Modified : 03/01/2016 MXR916 Added STATEMENT_TYPE_DESCRIPTION column.
*******************************************************************************/ 
       DISTINCT
       CC.STATEMENT_TYPE
       ,NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATEMENT_TYPE','COD',CC.STATEMENT_TYPE),'N/A') STATEMENT_TYPE_DESCRIPTION
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
       ,H.SPECIAL_ROLES_VAL SPECIAL_ROLES
       ,H.COST_CENTER_CODE AS COST_CENTER
       ,H.DOMAIN_VAL_NAME DOMAIN_NAME
       ,H.GROUP_VAL_NAME GROUP_NAME
       ,H.DIVISION_VAL_NAME DIVISION_NAME
       ,NVL2(H.AREA_VAL,H.AREA_VAL_NAME,NULL) AREA_NAME
       ,H.DISTRICT_VAL_NAME DISTRICT_NAME
       ,H.CITY_SALES_MANAGER_VAL_NAME CITY_SALES_MANAGER_NAME
       ,H.ZONE_VAL_NAME ZONE_NAME
       ,H.SPECIAL_ROLES_VAL_NAME SPECIAL_ROLES_NAME
       ,CC.COST_CENTER_NAME
  FROM COST_CENTER CC,
        --inner sub query "T" gives all the hierarchy details with all the levels
        --present in the CCN system by joining the header, description and detail tables
       (WITH T AS (SELECT HDESC.HRCHY_HDR_LVL_DESC DESCRIPTION,
                          HD.HRCHY_DTL_CURR_ROW_VAL COST_CENTER_CODE,
                          HD.HRCHY_HDR_NAME,
                          HD.HRCHY_DTL_EFF_DATE,
                          HD.HRCHY_DTL_EXP_DATE,
                          HD.HRCHY_DTL_CURR_LVL_VAL,
                          --1 + sum of level values till that level - level value for that level = starting point for this level
                          SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1 + HDESC.SUM_VAL - HDESC.LVL_VALUE_SIZE, HDESC.LVL_VALUE_SIZE) VAL,
                          (SELECT HRCHY_DTL_DESC
                             FROM HIERARCHY_DETAIL
                            WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1, HDESC.SUM_VAL)
                              AND HRCHY_HDR_NAME  = HDESC.HRCHY_HDR_NAME
                              AND HRCHY_DTL_LEVEL = HDESC.HRCHY_HDR_LVL_NBR
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
                      AND HD.HRCHY_DTL_LEVEL = HH.HRCHY_HDR_LEVELS
                      AND NVL(HD.HRCHY_DTL_NEXT_LVL_VAL, '~~~') = '~~~'
                       --filtering only to get Admin_to_sales_division, Admin_to_sales_area And Admin_to_sales_district information.
                      AND HD.HRCHY_HDR_NAME in ('ADMIN_TO_SALES_DIVISION','ADMIN_TO_SALES_AREA','ADMIN_TO_SALES_DISTRICT'))
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
                                                                     'Zone' AS "ZONE",
                                                                     'Special Roles' AS SPECIAL_ROLES))) H
 --Finally result of the above two steps(WITH T and PIVOT) will be a new result set "H" which can be used as any other
 --table in a join condition
 WHERE CC.COST_CENTER_CODE = H.COST_CENTER_CODE
 ORDER BY COST_CENTER_CODE, HRCHY_HDR_NAME;