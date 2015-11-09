CREATE OR REPLACE  VIEW GLBL_FACTS_LEGACY_VIEW  AS 
  SELECT 
/*******************************************************************************
This View will give all the details of Global_hierarchy, Facts_division 
and Legacy division  hierarchies to the cost center in single row..

Created  : 10/29/2015 dxv848 

*******************************************************************************/  
    DISTINCT CC.COST_CENTER_CODE
       ,CC.COST_CENTER_NAME
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.DOMAIN_VAL)) AS GLOBAL_DOMAIN
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.GROUP_VAL)) AS GLOBAL_GROUP
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.DIVISION_VAL)) AS GLOBAL_DIVISION
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.AREA_VAL)) AS GLOBAL_AREA
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.DISTRICT_VAL)) AS GLOBAL_DISTRICT     
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.CITY_SALES_MANAGER_VAL)) AS GLOBAL_CITY_SALES_MGR
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.ZONE_VAL )) AS GLOBAL_ZONE
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.SPECIAL_ROLES_VAL)) AS GLOBAL_SPECIAL_ROLES
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.DOMAIN_VAL_NAME)) AS GLOBAL_DOMAIN_NAME
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.GROUP_VAL_NAME)) AS GLOBAL_GROUP_NAME
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.DIVISION_VAL_NAME)) AS GLOBAL_DIVISION_NAME
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY',NVL2(H.AREA_VAL,H.AREA_VAL_NAME,NULL))) AS GLOBAL_AREA_NAME
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.DISTRICT_VAL_NAME)) AS GLOBAL_DISTRICT_NAME
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.CITY_SALES_MANAGER_VAL_NAME)) AS GLOBAL_CITY_SALES_MGR_NAME
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.ZONE_VAL_NAME)) AS GLOBAL_ZONE_NAME
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'GLOBAL_HIERARCHY', H.SPECIAL_ROLES_VAL_NAME)) AS GLOBAL_SPECIAL_ROLES_NAME
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'LEGACY_GL_DIVISION', H.DOMAIN_VAL)) AS LEGACY_DOMAIN
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'LEGACY_GL_DIVISION', H.GROUP_VAL)) AS LEGACY_GROUP
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'LEGACY_GL_DIVISION', H.DIVISION_VAL)) AS LEGACY_DIVISION
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'LEGACY_GL_DIVISION',H.LEGACY_DIVISION_VAL)) AS LEGACY_GL_DIVISION
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'LEGACY_GL_DIVISION', H.DOMAIN_VAL_NAME)) AS  LEGACY_DOMAIN_NAME 
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'LEGACY_GL_DIVISION', H.GROUP_VAL_NAME)) AS  LEGACY_GROUP_NAME 
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'LEGACY_GL_DIVISION', H.DIVISION_VAL_NAME)) AS  LEGACY_DIVISION_NAME 
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'LEGACY_GL_DIVISION', NVL2(H.LEGACY_DIVISION_VAL,H.LEGACY_DIVISION_VAL_NAME,NULL))) AS  LEGACY_GL_DIVISION_NAME 
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'FACTS_DIVISION', H.DOMAIN_VAL)) AS COA_DOMAIN
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'FACTS_DIVISION', H.GROUP_VAL)) AS COA_GROUP
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'FACTS_DIVISION', H.DIVISION_VAL)) AS COA_DIVISION
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'FACTS_DIVISION', H.DOMAIN_VAL_NAME)) AS  COA_DOMAIN_NAME 
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'FACTS_DIVISION', H.GROUP_VAL_NAME)) AS  COA_GROUP_NAME 
       ,MAX(DECODE(H.HRCHY_HDR_NAME, 'FACTS_DIVISION', H.DIVISION_VAL_NAME)) AS  COA_DIVISION_NAME 
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
                                                                     'Legacy Division' AS LEGACY_DIVISION,
                                                                     'District' AS DISTRICT,
                                                                     'City/Sales Manager' AS CITY_SALES_MANAGER,
                                                                     'Zone' AS "ZONE",
                                                                     'Special Roles' AS SPECIAL_ROLES))) H
--Finally result of the above two steps(WITH T and PIVOT) will be a new result set "H" which can be used as any other
--table in a join condition
 WHERE CC.COST_CENTER_CODE = H.COST_CENTER_CODE(+)
 GROUP BY CC.COST_CENTER_CODE,CC.COST_CENTER_NAME
  ORDER BY COST_CENTER_CODE,CC.COST_CENTER_NAME;