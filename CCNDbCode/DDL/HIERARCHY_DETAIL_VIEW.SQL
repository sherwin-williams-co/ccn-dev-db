--index to improve the persormance of hierarchy_detail query used in the below view
CREATE INDEX INDEX4 ON HIERARCHY_DETAIL (HRCHY_HDR_NAME, HRCHY_DTL_LEVEL, HRCHY_DTL_CURR_LVL_VAL);

  CREATE OR REPLACE VIEW HIERARCHY_DETAIL_VIEW  AS 
  SELECT
/*******************************************************************************
This View will give all the details of the hierarchies linked to the cost center
This has been modified to improve the performance when returning the whole result set

Created  : 04/16/2015 jxc517 CCN Project....
Modified : 06/04/2015 jxc517 CCN Project....
           To improve performance, eliminated all redundant queries
         : 05/30/2017 gxg192 Changes to remove COST_CENTER field as it containing
                      the same data as it is in COST_CENTER_CODE field.
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
       ,H.LEGACY_DIVISION_VAL LEGACY_DIVISION
       ,H.AREA_VAL AREA
       ,H.DISTRICT_VAL DISTRICT
       ,H.CITY_SALES_MANAGER_VAL CITY_SALES_MANAGER
       ,H.ZONE_VAL "ZONE"
       ,H.SPECIAL_ROLES_VAL SPECIAL_ROLES
       ,H.DOMAIN_VAL_NAME DOMAIN_NAME
       ,H.GROUP_VAL_NAME GROUP_NAME
       ,H.DIVISION_VAL_NAME DIVISION_NAME
       ,NVL2(H.LEGACY_DIVISION_VAL,H.LEGACY_DIVISION_VAL_NAME,NULL) LEGACY_DIVISION_NAME
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
 ORDER BY COST_CENTER_CODE, HRCHY_HDR_NAME;


  GRANT SELECT ON HIERARCHY_DETAIL_VIEW TO SWFF_CP2D11E_DBLU;
  GRANT SELECT ON HIERARCHY_DETAIL_VIEW TO ICM_CPDB4;
  GRANT SELECT ON HIERARCHY_DETAIL_VIEW TO STORDRFT;
  GRANT SELECT ON HIERARCHY_DETAIL_VIEW TO CCNUSER;
  