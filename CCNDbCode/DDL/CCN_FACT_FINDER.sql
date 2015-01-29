CREATE OR REPLACE VIEW CCN_FACT_FINDER
AS 
SELECT 
/*******************************************************************************
This View holds all the required data for a cost center, its name, category, domain,
group, roles, sales_volume_class  it is associated with it.

Created  : 01/28/2015 axk326 CCN Project  
Modified : 01/29/2015 axk326 CCN Project added few more columns to existing view 
*******************************************************************************/  
	   COST_CENTER,
       COST_CENTER_NAME,
       FACTS_DIVISION,
       CLOSE_DATE,
       COST_CENTER_CATEGORY,
       STATEMENT_TYPE,
       MAX(DECODE(HRCHY_HDR_LVL_NBR, 1, VAL)) AS "DOMAIN",
       MAX(DECODE(HRCHY_HDR_LVL_NBR, 2, VAL)) AS "GROUP",
       MAX(DECODE(HRCHY_HDR_LVL_NBR, CASE HRCHY_HDR_NAME
                                     WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 8
                                     WHEN 'ALTERNATE_DAD' THEN 8
                                     WHEN 'GLOBAL_HIERARCHY' THEN 8
                                     ELSE NULL
                                     END, VAL)) AS "SPECIAL_ROLES",
	   MAX(DECODE(HRCHY_HDR_LVL_NBR, CASE HRCHY_HDR_NAME
								     WHEN 'ADMIN_TO_SALES_DISTRICT' THEN 7
								     WHEN 'ALTERNATE_DAD' THEN 7
								     WHEN 'GLOBAL_HIERARCHY' THEN 7
								     ELSE NULL
								     END,val)) AS "ZONE",
       ACQUISITION_CODE,
       DIVISION,
       AREA,
       DISTRICT,
       CITY_SALES_NUM,
       STATUS,
       TYPE,
       SALES_VOLUME_CLASS,
       MANAGER_FIRST_NAME,
       MANAGER_LAST_NAME,
       TERR_HOME_STORE,
       ALT_DIVISION,
       ALT_AREA,
       ALT_DISTRICT,
       DIST_NAME
FROM   (SELECT C.COST_CENTER_CODE
               COST_CENTER,
               C.COST_CENTER_NAME,
               (SELECT SUBSTR(HRCHY_DTL_PREV_LVL_VAL, 5)
                FROM   HIERARCHY_DETAIL
                WHERE  HRCHY_DTL_CURR_ROW_VAL = C.COST_CENTER_CODE
                       AND HRCHY_HDR_NAME = 'FACTS_DIVISION')FACTS_DIVISION,
               C.CLOSE_DATE,
               C.CATEGORY COST_CENTER_CATEGORY,
               C.STATEMENT_TYPE,
               HDESC.HRCHY_HDR_LVL_NBR,
               HD.HRCHY_HDR_NAME,                                   
               SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1 + (SELECT NVL(SUM(LVL_VALUE_SIZE), 0)
                                                      FROM   HIERARCHY_DESCRIPTION
                                                      WHERE  HRCHY_HDR_LVL_NBR < HDESC.HRCHY_HDR_LVL_NBR
                                                      AND HRCHY_HDR_NAME = HD.HRCHY_HDR_NAME), HDESC.LVL_VALUE_SIZE)  VAL,
               C.ACQUISITION_CODE,
               SUBSTR(HD.HRCHY_DTL_PREV_LVL_VAL, 5, 2) DIVISION,
               SUBSTR(HD.HRCHY_DTL_PREV_LVL_VAL, 7, 2) AREA,
               SUBSTR(HD.HRCHY_DTL_PREV_LVL_VAL, 9, 2) DISTRICT,
               SUBSTR(HD.HRCHY_DTL_PREV_LVL_VAL, 11, 2)CITY_SALES_NUM,
               STATUS_CODE STATUS,
               TYPE_CODE   TYPE,
               (SELECT SALES_VOL_CLASS_CODE
                FROM   STORE
                WHERE  COST_CENTER_CODE = C.COST_CENTER_CODE) SALES_VOLUME_CLASS,
               UPPER(ED.FIRST_NAME) MANAGER_FIRST_NAME,
               UPPER(ED.LAST_NAME) MANAGER_LAST_NAME,
               (SELECT HOME_STORE
                FROM   TERRITORY
                WHERE  COST_CENTER_CODE = C.COST_CENTER_CODE) TERR_HOME_STORE,
               (SELECT SUBSTR(HD.HRCHY_DTL_PREV_LVL_VAL, 5, 2)
                FROM   HIERARCHY_DETAIL
                WHERE  HRCHY_HDR_NAME = 'ALTERNATE_DAD'
                   AND HRCHY_DTL_LEVEL = '9'
                   AND HRCHY_DTL_CURR_ROW_VAL = C.COST_CENTER_CODE) ALT_DIVISION,
               (SELECT SUBSTR(HD.HRCHY_DTL_PREV_LVL_VAL, 7, 2)
                FROM   HIERARCHY_DETAIL
                WHERE  HRCHY_HDR_NAME = 'ALTERNATE_DAD'
                   AND HRCHY_DTL_LEVEL = '9'
                   AND HRCHY_DTL_CURR_ROW_VAL = C.COST_CENTER_CODE) ALT_AREA,
               (SELECT SUBSTR(HD.HRCHY_DTL_PREV_LVL_VAL, 9, 2)
                FROM   HIERARCHY_DETAIL
                WHERE  HRCHY_HDR_NAME = 'ALTERNATE_DAD'
                   AND HRCHY_DTL_LEVEL = '9'
                   AND HRCHY_DTL_CURR_ROW_VAL = C.COST_CENTER_CODE) ALT_DISTRICT,
               (SELECT RTRIM(HRCHY_DTL_DESC, 'DST')
                FROM   HIERARCHY_DETAIL
                WHERE  HRCHY_HDR_NAME = 'ADMIN_TO_SALES_DISTRICT'
                   AND HRCHY_DTL_LEVEL = '5'
                   AND HRCHY_DTL_CURR_LVL_VAL = SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1, 10)) DIST_NAME
        FROM   HIERARCHY_DETAIL HD,
               HIERARCHY_DESCRIPTION HDESC,
               COST_CENTER C,
               STATUS S,
               TYPE T,
               EMPLOYEE_DETAILS ED
        WHERE  HD.HRCHY_DTL_CURR_ROW_VAL = C.COST_CENTER_CODE
               AND HD.HRCHY_HDR_NAME = HDESC.HRCHY_HDR_NAME
               AND NVL(HD.HRCHY_DTL_NEXT_LVL_VAL, '~~~') = '~~~'
               AND HD.HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
               AND C.COST_CENTER_CODE = S.COST_CENTER_CODE
               AND S.COST_CENTER_CODE = T.COST_CENTER_CODE
               AND C.COST_CENTER_CODE = T.COST_CENTER_CODE
               AND ED.COST_CENTER_CODE = C.COST_CENTER_CODE
               AND UPPER(ED.EMP_PAYROLL_STATUS) = 'ACTIVE'
               AND UPPER(ED.JOB_TITLE) = 'STORE MGR'
               AND ED.TERM_DATE IS NULL
               AND S.EXPIRATION_DATE IS NULL
               AND T.EXPIRATION_DATE IS NULL)
GROUP  BY COST_CENTER,
          COST_CENTER_NAME,
          FACTS_DIVISION,
          CLOSE_DATE,
          COST_CENTER_CATEGORY,
          STATEMENT_TYPE,
          ACQUISITION_CODE,
          DIVISION,
          AREA,
          DISTRICT,
          CITY_SALES_NUM,
          STATUS,
          TYPE,
          SALES_VOLUME_CLASS,
          MANAGER_FIRST_NAME,
          MANAGER_LAST_NAME,
          TERR_HOME_STORE,
          ALT_DIVISION,
          ALT_AREA,
          ALT_DISTRICT,
          DIST_NAME;
