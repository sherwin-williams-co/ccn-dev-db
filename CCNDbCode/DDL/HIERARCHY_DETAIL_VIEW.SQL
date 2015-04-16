--index to improve the persormance of hierarchy_detail query used in the below view
CREATE INDEX INDEX4 ON HIERARCHY_DETAIL (HRCHY_HDR_NAME, HRCHY_DTL_LEVEL, HRCHY_DTL_CURR_LVL_VAL);

  CREATE OR REPLACE VIEW HIERARCHY_DETAIL_VIEW AS 
  SELECT
/*******************************************************************************
This View will give all the details of the hierarchies linked to the cost center
This has been modified to improve the performance when returning the whole result set

Created  : 04/16/2015 jxc517 CCN Project....
Modified : 
*******************************************************************************/ 
       DISTINCT
       CC.STATEMENT_TYPE
       ,H.HRCHY_HDR_NAME
       ,H.COST_CENTER_CODE
       ,H.HRCHY_DTL_EFF_DATE
       ,H.HRCHY_DTL_EXP_DATE
       ,H.DOMAIN
       ,H."GROUP"
       ,H.DIVISION
       ,H.LEGACY_DIVISION
       ,H.AREA
       ,H.DISTRICT
       ,H.CITY_SALES_MANAGER
       ,H."ZONE"
       ,H.SPECIAL_ROLES
       ,H.COST_CENTER_CODE AS COST_CENTER
       ,(SELECT HRCHY_DTL_DESC
           FROM HIERARCHY_DETAIL
          WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                             FROM HIERARCHY_DESCRIPTION
                                                                            WHERE HRCHY_HDR_LVL_NBR <= 1
                                                                              AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
            AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
            AND HRCHY_DTL_LEVEL = 1
            AND ROWNUM < 2) DOMAIN_NAME
       ,(SELECT HRCHY_DTL_DESC
           FROM HIERARCHY_DETAIL
          WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                             FROM HIERARCHY_DESCRIPTION
                                                                            WHERE HRCHY_HDR_LVL_NBR <= 2
                                                                              AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
            AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
            AND HRCHY_DTL_LEVEL = 2
            AND ROWNUM < 2) GROUP_NAME
       ,(SELECT HRCHY_DTL_DESC
           FROM HIERARCHY_DETAIL
          WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                             FROM HIERARCHY_DESCRIPTION
                                                                            WHERE HRCHY_HDR_LVL_NBR <= 3
                                                                              AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
            AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
            AND HRCHY_DTL_LEVEL = 3
            AND ROWNUM < 2) DIVISION_NAME
       ,NVL2(H.LEGACY_DIVISION,
             (SELECT HRCHY_DTL_DESC
                FROM HIERARCHY_DETAIL
               WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                                   FROM HIERARCHY_DESCRIPTION
                                                                                  WHERE HRCHY_HDR_LVL_NBR <= 4
                                                                                    AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
                 AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
                 AND HRCHY_DTL_LEVEL = 4
                 AND ROWNUM < 2),
                 NULL) LEGACY_DIVISION_NAME
       ,NVL2(H.AREA,
             (SELECT HRCHY_DTL_DESC
                FROM HIERARCHY_DETAIL
               WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                                   FROM HIERARCHY_DESCRIPTION
                                                                                  WHERE HRCHY_HDR_LVL_NBR <= 4
                                                                                    AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
                 AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
                 AND HRCHY_DTL_LEVEL = 4
                 AND ROWNUM < 2),
                 NULL) AREA_NAME
       ,(SELECT HRCHY_DTL_DESC
           FROM HIERARCHY_DETAIL
          WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                             FROM HIERARCHY_DESCRIPTION
                                                                            WHERE HRCHY_HDR_LVL_NBR <= 5
                                                                              AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
            AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
            AND HRCHY_DTL_LEVEL = 5
            AND ROWNUM < 2) DISTRICT_NAME
       ,(SELECT HRCHY_DTL_DESC
           FROM HIERARCHY_DETAIL
          WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                             FROM HIERARCHY_DESCRIPTION
                                                                            WHERE HRCHY_HDR_LVL_NBR <= 6
                                                                              AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
            AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
            AND HRCHY_DTL_LEVEL = 6
            AND ROWNUM < 2) CITY_SALES_MANAGER_NAME
       ,(SELECT HRCHY_DTL_DESC
           FROM HIERARCHY_DETAIL
          WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                             FROM HIERARCHY_DESCRIPTION
                                                                            WHERE HRCHY_HDR_LVL_NBR <= 7
                                                                              AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
            AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
            AND HRCHY_DTL_LEVEL = 7
            AND ROWNUM < 2) ZONE_NAME
       ,(SELECT HRCHY_DTL_DESC
           FROM HIERARCHY_DETAIL
          WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                             FROM HIERARCHY_DESCRIPTION
                                                                            WHERE HRCHY_HDR_LVL_NBR <= 8
                                                                              AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
            AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
            AND HRCHY_DTL_LEVEL = 8
            AND ROWNUM < 2) SPECIAL_ROLES_NAME
       ,CC.COST_CENTER_NAME
  FROM COST_CENTER CC,
       (WITH T AS (SELECT HDESC.HRCHY_HDR_LVL_DESC DESCRIPTION,
                          HD.HRCHY_DTL_CURR_ROW_VAL COST_CENTER_CODE,
                          HD.HRCHY_HDR_NAME,
                          HD.HRCHY_DTL_EFF_DATE,
                          HD.HRCHY_DTL_EXP_DATE,
                          HD.HRCHY_DTL_CURR_LVL_VAL,
                          SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1 + (SELECT NVL(SUM(LVL_VALUE_SIZE), 0)
                                                                   FROM HIERARCHY_DESCRIPTION
                                                                  WHERE HRCHY_HDR_LVL_NBR < HDESC.HRCHY_HDR_LVL_NBR
                                                                   AND HRCHY_HDR_NAME = HD.HRCHY_HDR_NAME), HDESC.LVL_VALUE_SIZE) VAL
                     FROM HIERARCHY_DETAIL HD,
                          HIERARCHY_HEADER HH,
                          HIERARCHY_DESCRIPTION HDESC
                    WHERE HD.HRCHY_HDR_NAME  = HDESC.HRCHY_HDR_NAME
                      AND HD.HRCHY_HDR_NAME  = HH.HRCHY_HDR_NAME
                      AND HD.HRCHY_DTL_LEVEL = HH.HRCHY_HDR_LEVELS
                      AND NVL(HD.HRCHY_DTL_NEXT_LVL_VAL, '~~~') = '~~~'
                    ORDER BY HD.HRCHY_DTL_CURR_ROW_VAL, HDESC.HRCHY_HDR_LVL_NBR)
             SELECT *
               FROM T
                    PIVOT 
                    (MAX(VAL) FOR (DESCRIPTION) IN ('Domain' AS DOMAIN,
                                                    'Group' AS "GROUP",
                                                    'Division' AS DIVISION,
                                                    'Area' AS AREA,
                                                    'Legacy Division' AS LEGACY_DIVISION,
                                                    'District' AS DISTRICT,
                                                    'City/Sales Manager' AS CITY_SALES_MANAGER,
                                                    'Zone' AS "ZONE",
                                                    'Special Roles' AS SPECIAL_ROLES
                                                           ))) H
 WHERE CC.COST_CENTER_CODE = H.COST_CENTER_CODE(+)
 ORDER BY COST_CENTER_CODE, HRCHY_HDR_NAME;


  GRANT SELECT ON HIERARCHY_DETAIL_VIEW TO SWFF_CP2D11E_DBLU;
  GRANT SELECT ON HIERARCHY_DETAIL_VIEW TO ICM_CPDB4;
  GRANT SELECT ON HIERARCHY_DETAIL_VIEW TO STORDRFT;
  GRANT SELECT ON HIERARCHY_DETAIL_VIEW TO CCNUSER;
