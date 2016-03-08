CREATE OR REPLACE VIEW CCN_FACT_FINDER  AS 
  SELECT
     /*******************************************************************************
     This View holds all the required data for a cost center, its name, category, domain,
     group, roles, sales_volume_class  it is associated with it.
   
     Created  : 01/28/2015 nxk927 CCN Project  
     Modified : 01/29/2015 axk326 CCN Project added few more columns to existing view 
                         eliminated join conditions as well
              : 02/03/2015 nxk927 / axk326 CCN Project optimized the select query 
                that creates the view
              : 03/02/2016 MXR916 CCN Project
                Added CATEGORY_DESCRIPTION,STATEMENT_TYPE_DESCRIPTION,STATUS_CODE_DESCRIPTION,TYPE_DESCRIPTION,SALES_VOLUME_CLAS_DESCRIPTION
     *******************************************************************************/ 
            COST_CENTER_CODE,
            COST_CENTER_NAME,
            CLOSE_DATE,
            CATEGORY COST_CENTER_CATEGORY,
            NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('CATEGORY','COD',CATEGORY),'N/A') CATEGORY_DESCRIPTION,
            STATEMENT_TYPE,
            NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATEMENT_TYPE','COD',STATEMENT_TYPE),'N/A') STATEMENT_TYPE_DESCRIPTION,
            ACQUISITION_CODE,
            COMMON_TOOLS.GET_CURR_LEV_VAL('FACTS_DIVISION', 'DIVISION',C.COST_CENTER_CODE ) FACTS_DIVISION,
            COMMON_TOOLS.GET_CURR_LEV_VAL('GLOBAL_HIERARCHY', 'DOMAIN',C.COST_CENTER_CODE ) "DOMAIN",
            COMMON_TOOLS.GET_CURR_LEV_VAL('GLOBAL_HIERARCHY', 'GROUP',C.COST_CENTER_CODE ) "GROUP ",
            COMMON_TOOLS.GET_CURR_LEV_VAL('GLOBAL_HIERARCHY', 'DIVISION',C.COST_CENTER_CODE ) DIVISION,
            COMMON_TOOLS.GET_CURR_LEV_VAL('GLOBAL_HIERARCHY', 'AREA',C.COST_CENTER_CODE ) AREA,
            COMMON_TOOLS.GET_CURR_LEV_VAL('GLOBAL_HIERARCHY', 'DISTRICT',C.COST_CENTER_CODE ) DISTRICT,
            COMMON_TOOLS.GET_CURR_LEV_VAL('GLOBAL_HIERARCHY', 'CITY/SALES MANAGER', C.COST_CENTER_CODE ) CITY_SALES_NUM,
            COMMON_TOOLS.GET_CURR_LEV_VAL('GLOBAL_HIERARCHY', 'ZONE',C.COST_CENTER_CODE ) "ZONE",
            COMMON_TOOLS.GET_CURR_LEV_VAL('GLOBAL_HIERARCHY', 'SPECIAL ROLES',C.COST_CENTER_CODE ) SPECIAL_ROLES,
            COMMON_TOOLS.GET_CURR_LEV_VAL('ALTERNATE_DAD', 'DIVISION', C.COST_CENTER_CODE ) ALT_DIVISION,
            COMMON_TOOLS.GET_CURR_LEV_VAL('ALTERNATE_DAD', 'AREA',C.COST_CENTER_CODE ) ALT_AREA,
            COMMON_TOOLS.GET_CURR_LEV_VAL('ALTERNATE_DAD', 'DISTRICT',C.COST_CENTER_CODE ) ALT_DISTRICT,
            COMMON_TOOLS.GET_CURR_LEV_VAL('ADMIN_TO_SALES_DISTRICT', 'DISTRICT',C.COST_CENTER_CODE ) ADMIN_DISTRICT,
            (SELECT RTRIM(HRCHY_DTL_DESC, 'DST')
               FROM HIERARCHY_DETAIL
              WHERE HRCHY_HDR_NAME = 'ADMIN_TO_SALES_DISTRICT'
                AND HRCHY_DTL_LEVEL = '9'
                AND HRCHY_DTL_CURR_ROW_VAL = COST_CENTER_CODE) AS DIST_NAME,
            (SELECT STATUS_CODE
               FROM STATUS
              WHERE COST_CENTER_CODE = C.COST_CENTER_CODE
                AND EXPIRATION_DATE IS NULL) STATUS_CODE,
             NVL((SELECT CD.CODE_DETAIL_DESCRIPTION 
                    FROM CODE_DETAIL CD, 
                         STATUS S
                   WHERE CD.CODE_DETAIL_VALUE=S.STATUS_CODE
                     AND CD.CODE_HEADER_NAME ='STATUS_CODE'
                     AND S.COST_CENTER_CODE = C.COST_CENTER_CODE
                     AND S.EXPIRATION_DATE IS NULL),'N/A') STATUS_CODE_DESCRIPTION,
            (SELECT TYPE_CODE
               FROM TYPE
              WHERE COST_CENTER_CODE = C.COST_CENTER_CODE
                AND EXPIRATION_DATE IS NULL) TYPE,
             NVL((SELECT CD.CODE_DETAIL_DESCRIPTION 
                    FROM CODE_DETAIL CD, 
                         TYPE T
                   WHERE CD.CODE_DETAIL_VALUE=T.TYPE_CODE
                     AND CD.CODE_HEADER_NAME='TYPE_CODE'
                     AND T.COST_CENTER_CODE = C.COST_CENTER_CODE
                     AND T.EXPIRATION_DATE IS NULL),'N/A') TYPE_DESCRIPTION,
            (SELECT SALES_VOL_CLASS_CODE
                FROM STORE
              WHERE COST_CENTER_CODE = C.COST_CENTER_CODE) SALES_VOLUME_CLASS,
             NVL((SELECT CD.CODE_DETAIL_DESCRIPTION 
                    FROM CODE_DETAIL CD, 
                         STORE S
                   WHERE CD.CODE_DETAIL_VALUE=S.SALES_VOL_CLASS_CODE
                     AND CD.CODE_HEADER_NAME='SALES_VOL_CLASS_CODE'
                     AND S.COST_CENTER_CODE=C.COST_CENTER_CODE),'N/A') SALES_VOLUME_CLAS_DESCRIPTION,
            (SELECT UPPER(FIRST_NAME)
               FROM EMPLOYEE_DETAILS
              WHERE COST_CENTER_CODE = C.COST_CENTER_CODE
                AND UPPER(EMP_PAYROLL_STATUS) = 'ACTIVE'
                AND UPPER(JOB_TITLE) IN (SELECT UPPER(JOB_TITLE )
                                           FROM JOB_TITLE_GROUP 
                                          WHERE NONMGR_IND = 'Y')
                AND ROWNUM < 2) MANAGER_FIRST_NAME,
            (SELECT UPPER(LAST_NAME)
               FROM EMPLOYEE_DETAILS
              WHERE COST_CENTER_CODE = C.COST_CENTER_CODE
                AND UPPER(EMP_PAYROLL_STATUS) = 'ACTIVE'
                AND UPPER(JOB_TITLE) IN (SELECT UPPER(JOB_TITLE ) 
                                           FROM JOB_TITLE_GROUP 
                                          WHERE NONMGR_IND = 'Y')
                AND ROWNUM < 2) MANAGER_LAST_NAME,
            (SELECT HOME_STORE
               FROM TERRITORY
              WHERE COST_CENTER_CODE = C.COST_CENTER_CODE) TERR_HOME_STORE
          FROM COST_CENTER C;


  GRANT SELECT ON "CCN_FACT_FINDER" TO "SWFF_CP2D11E_DBLU";
