CREATE OR REPLACE  VIEW ADDRESS_FLDPRRPT_V  AS
  SELECT 
 /*******************************************************************************
    
     Modified : 03/02/2016 MXR916 Added PROVINCE_CODE_DESCRIPTION,STATE_CODE_DESCRIPTION,COUNTRY_CODE_DESCRIPTION columns.
     *******************************************************************************/  
          COST_CENTER_CODE,
          ADDRESS_TYPE,
          EFFECTIVE_DATE,
          EXPIRATION_DATE,
          ADDRESS_LINE_1,
          ADDRESS_LINE_2,
          ADDRESS_LINE_3,
          CITY,
          PROVINCE_CODE,
          PROVINCE_CODE_DESCRIPTION,
          STATE_CODE,
          STATE_CODE_DESCRIPTION,
          POSTAL_CODE,
          ZIP_CODE,
          ZIP_CODE_4,
          COUNTY,
          FIPS_CODE,
          DESTINATION_POINT,
          CHECK_DIGIT,
          VALID_ADDRESS,
          COUNTRY_CODE,
          COUNTRY_CODE_DESCRIPTION
     FROM ADDRESS_VW;


CREATE OR REPLACE VIEW ADMIN_TO_SALES_HIERARCHY_VW  AS 
       SELECT
     /*******************************************************************************
     This View will give all the details of Admin_to_sales_division, Admin_to_sales_area
     and Admin_to_sales_district hierarchies for linked to the cost center
     
     Created  : 10/28/2015 SXT410 CCN Project....
     Modified : 03/01/2016 MXR916 Added STATEMENT_TYPE_DESCRIPTION column.
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


CREATE OR REPLACE  VIEW CCN_FACT_FINDER  AS 
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
                Added CATEGORY_DESCRIPTION,STATEMENT_TYPE_DESCRIPTION,STATUS_CODE_DESCRIPTION,TYPE_CODE_DESCRIPTION,SALES_VOLUME_CLAS_DESCRIPTION
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
            (SELECT CD.CODE_DETAIL_DESCRIPTION FROM 
                CODE_DETAIL CD, STATUS S
                WHERE CD.CODE_DETAIL_VALUE=S.STATUS_CODE
                AND CODE_HEADER_NAME = 'STATUS_CODE'
                AND S.COST_CENTER_CODE = C.COST_CENTER_CODE
                AND S.EXPIRATION_DATE IS NULL) STATUS_CODE_DESCRIPTION,
            (SELECT TYPE_CODE
               FROM TYPE
              WHERE COST_CENTER_CODE = C.COST_CENTER_CODE
                AND EXPIRATION_DATE IS NULL) TYPE,
             (SELECT CD.CODE_DETAIL_DESCRIPTION FROM
                 CODE_DETAIL CD, TYPE T
                 WHERE CD.CODE_DETAIL_VALUE=T.TYPE_CODE
                 AND CD.CODE_HEADER_NAME='TYPE_CODE'
                 AND T.COST_CENTER_CODE = C.COST_CENTER_CODE
                 AND EXPIRATION_DATE IS NULL) TYPE_CODE_DESCRIPTION,
            (SELECT SALES_VOL_CLASS_CODE
               FROM STORE
              WHERE COST_CENTER_CODE = C.COST_CENTER_CODE) SALES_VOLUME_CLASS,
            (SELECT CD.CODE_DETAIL_DESCRIPTION FROM
               CODE_DETAIL CD, STORE S
               WHERE CD.CODE_DETAIL_VALUE=S.SALES_VOL_CLASS_CODE
               AND S.COST_CENTER_CODE=C.COST_CENTER_CODE) SALES_VOLUME_CLAS_DESCRIPTION,
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
              WHERE COST_CENTER_CODE = C.COST_CENTER_CODE) TERR_HOME_STORE,
            (SELECT CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(UPPER_LVL_VER_VALUE,'GEMS_ID')
               FROM HIERARCHY_DETAIL
              WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
                AND HRCHY_DTL_LEVEL = '6'
                AND (HRCHY_DTL_PREV_LVL_VAL, HRCHY_DTL_CURR_LVL_VAL, HRCHY_DTL_NEXT_LVL_VAL) IN (
                                  SELECT SUBSTR(HRCHY_DTL_CURR_LVL_VAL,1,10),
                                         SUBSTR(HRCHY_DTL_CURR_LVL_VAL,1,12),
                                         SUBSTR(HRCHY_DTL_CURR_LVL_VAL,1,14)
                                    FROM HIERARCHY_DETAIL
                                   WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
                                     AND HRCHY_DTL_LEVEL = '9'
                                     AND HRCHY_DTL_CURR_ROW_VAL = C.COST_CENTER_CODE)
                AND ROWNUM < 2) MANAGER_ID
      FROM COST_CENTER C;

CREATE OR REPLACE VIEW COST_CENTER_VW  AS 
        SELECT
      /*******************************************************************************
      This View holds all the required data for a cost_center its country_code, Mission_type_code along with their descriptions
      and also Acquisition_code from COST_CENTER table.
      
      created  : 03/18/2014 for CCN project and 
      Modified : 07/18/14 Added ACQUISITION_CODE column.
      Modified : 02/17/2015 SXT410 Added FAX_PHONE_NUMBER, POLLING_STATUS_CODE and
                 Manager/Asst Manager/Sales rep Name broken out with first, initial, last.
                 10/06/2015 nxk927 Added PRI_LOGO_GROUP_IND,SCD_LOGO_GROUP_IND columns.
      		     : 10/26/2015 dxv848 Added COLOR_CONSULTANT_TYPE column.
               : 11/25/2015 axk326 CCN Project Team....
                 Added columns PCC_STORE, PCL_STORE to determine the color consultant and color lead 
               : 12/07/2015 jxc527 Modified query for performance to use function based index by adding UPPER() around COST_CENTER_CODE 
                 in EMPLOYEE_DETAILS table query
               : 01/06/2015 axk326 CCN Project Team....
                 Removed columns PCC_STORE, PCL_STORE and added the column PCC_PCL_STORE from cost_center table
               : 03/01/2016 mxr916 ccn Project Team....
                 Added columns PRI_LOGO_GROUP_IND_DESCRIPTION,SCD_LOGO_GROUP_IND_DESCRIPTION,POLLING_STATUS_COD_DESC
      ********************************************************************************/ 
      COST_CENTER_CODE,
      COST_CENTER_NAME,
      CATEGORY,
      NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('CATEGORY','COD',CATEGORY),'N/A') CATEGORY_DESCRIPTION,
      STATEMENT_TYPE,
      NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATEMENT_TYPE','COD',STATEMENT_TYPE),'N/A') STATEMENT_TYPE_DESCRIPTION,
      COUNTRY_CODE,
      NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('COUNTRY_CODE','COD',COUNTRY_CODE),'N/A') COUNTRY_CODE_DESCRIPTION,
      BEGIN_DATE,
      OPEN_DATE,
      MOVE_DATE,
      CLOSE_DATE,
      MISSION_TYPE_CODE,
      NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('MISSION_TYPE_CODE','COD',MISSION_TYPE_CODE),'N/A') MISSION_TYPE_CODE_DESCRIPTION,
      DUNS_NUMBER,
      ACQUISITION_CODE,
      PRI_LOGO_GROUP_IND,
      NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('PRI_LOGO_GROUP_IND','COD',PRI_LOGO_GROUP_IND),'N/A') PRI_LOGO_GROUP_IND_DESCRIPTION,
      SCD_LOGO_GROUP_IND,
      NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('SCD_LOGO_GROUP_IND','COD',SCD_LOGO_GROUP_IND),'N/A') SCD_LOGO_GROUP_IND_DESCRIPTION,
      COLOR_CONSULTANT_TYPE,
      PCC_PCL_STORE,
      COMMON_TOOLS.GET_PHONE_NUMBER (C.COST_CENTER_CODE, 'FAX') FAX_PHONE_NUMBER,
      (SELECT POLLING_STATUS_CODE
         FROM POLLING
        WHERE CURRENT_FLAG = 'Y'
          AND COST_CENTER_CODE = C.COST_CENTER_CODE) POLLING_STATUS_CODE,
       (SELECT CD.CODE_DETAIL_DESCRIPTION
          FROM CODE_DETAIL CD,POLLING P
         WHERE CD.CODE_DETAIL_VALUE=P.POLLING_STATUS_CODE
          AND  CD.CODE_HEADER_NAME='POLLING_STATUS_CODE'
          AND  P.CURRENT_FLAG='Y'
          AND  P.COST_CENTER_CODE=C.COST_CENTER_CODE) POLLING_STATUS_COD_DESC,
      (SELECT HOME_STORE 
         FROM TERRITORY
        WHERE CATEGORY = 'T'
          AND COST_CENTER_CODE = C.COST_CENTER_CODE) TERR_HOME_STORE_NO,
      (SELECT FIRST_NAME FROM EMPLOYEE_DETAILS
        WHERE UPPER(JOB_TITLE) IN ('MGR', 'ASST MGR', 'SALES REP')
          AND UPPER(COST_CENTER_CODE) = C.COST_CENTER_CODE
          AND UPPER(EMP_PAYROLL_STATUS) = 'ACTIVE'
          AND ROWNUM < 2) FIRST_NAME,
      (SELECT MIDDLE_INITIAL FROM EMPLOYEE_DETAILS
        WHERE UPPER(JOB_TITLE) IN ('MGR', 'ASST MGR', 'SALES REP')
          AND UPPER(COST_CENTER_CODE) = C.COST_CENTER_CODE
          AND UPPER(EMP_PAYROLL_STATUS) = 'ACTIVE'
          AND ROWNUM < 2) MIDDLE_INITIAL,   
      (SELECT LAST_NAME FROM EMPLOYEE_DETAILS 
        WHERE UPPER(JOB_TITLE) IN ('MGR', 'ASST MGR', 'SALES REP')
          AND UPPER(COST_CENTER_CODE) = C.COST_CENTER_CODE
          AND UPPER(EMP_PAYROLL_STATUS) = 'ACTIVE'
          AND ROWNUM < 2) LAST_NAME
FROM COST_CENTER C;



CREATE OR REPLACE VIEW COST_CENTER_FLDPRRPT_V AS 
          SELECT
       /*******************************************************************************
    
     Modified : 03/02/2016 MXR916 Added CATEGORY_DESCRIPTION,STATEMENT_TYPE_DESCRIPTION,COUNTRY_CODE_DESCRIPTION,
                                        MISSION_TYPE_CODE_DESCRIPTION columns.
     *******************************************************************************/     
                  COST_CENTER_CODE,
                  COST_CENTER_NAME,
                  CATEGORY,
                  CATEGORY_DESCRIPTION,
                  STATEMENT_TYPE,
                  STATEMENT_TYPE_DESCRIPTION,
                  COUNTRY_CODE,
                  COUNTRY_CODE_DESCRIPTION,
                  BEGIN_DATE,
                  OPEN_DATE,
                  MOVE_DATE,
                  CLOSE_DATE,
                  MISSION_TYPE_CODE,
                  MISSION_TYPE_CODE_DESCRIPTION,
                  DUNS_NUMBER
     FROM COST_CENTER_VW;



CREATE OR REPLACE  VIEW COST_POS_VIEW AS 
       SELECT
     /*******************************************************************************
     This View holds all the required data for a cost center, its address, 
     polling status and the hierarchy it is associated with it.
     
     Created  : 03/31/2014 NXK927 CCN Project
     Modified : 01/22/2015 SXT410 Added Columns OPEN_DATE and CLOSE_DATE.
              : 01/29/2015 SXT410 Added Effective_date Column from Polling table.
              : 08/14/2015 NXK927 Only including current polling status
              : 03/01/2016 MXR916 Added STATE_CODE_DESCRIPTION,POLLING_STATUS_COD_DESCRIPTION,STATEMENT_TYPE_DESCRIPTION,TYPE_CODE_DESCRIPTION Columns.
     *******************************************************************************/ 
            CC.COST_CENTER_CODE,
            CC.CATEGORY,
            NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('CATEGORY','COD',CC.CATEGORY),'N/A') CATEGORY_DESCRIPTION,
            CC.COST_CENTER_NAME, 
            ADDRESS.ADDRESS_LINE_1,
            ADDRESS.ADDRESS_LINE_2, 
            ADDRESS.ADDRESS_LINE_3,
            CITY, 
            STATE_CODE,
            NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATE_CODE','COD',STATE_CODE),'N/A') STATE_CODE_DESCRIPTION,
            ZIP_CODE,
            PO.POLLING_STATUS_CODE,
            NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('POLLING_STATUS_CODE','COD',PO.POLLING_STATUS_CODE),'N/A') POLLING_STATUS_COD_DESCRIPTION,
            PO.EFFECTIVE_DATE,
            (SELECT HRCHY_DTL_CURR_LVL_VAL
               FROM HIERARCHY_DETAIL
              WHERE HRCHY_DTL_CURR_ROW_VAL = CC.COST_CENTER_CODE
                AND HRCHY_HDR_NAME         = 'GLOBAL_HIERARCHY'
                AND ROWNUM < 2) AS GLOBAL_HIERARCHY,                 
            COMMON_TOOLS.GET_PHONE_NUMBER ( CC.COST_CENTER_CODE, 'PRI') PRIMARY_PHONE_NUMBER,
            COMMON_TOOLS.GET_PHONE_NUMBER ( CC.COST_CENTER_CODE, 'SCD') SECONDARY_PHONE_NUMBER,
            COMMON_TOOLS.GET_PHONE_NUMBER ( CC.COST_CENTER_CODE, 'FAX') FAX_PHONE_NUMBER,  
            CC.STATEMENT_TYPE,
            NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATEMENT_TYPE','COD',CC.STATEMENT_TYPE),'N/A') STATEMENT_TYPE_DESCRIPTION,
            CCN_HIERARCHY.GET_TYPE_FNC ( CC.COST_CENTER_CODE ) TYPE_CODE,
            (SELECT CD.CODE_DETAIL_DESCRIPTION
               FROM CODE_DETAIL CD, TYPE T
               WHERE CD.CODE_DETAIL_VALUE=T.TYPE_CODE
               AND   CD.CODE_HEADER_NAME='TYPE_CODE'
               AND   T.COST_CENTER_CODE=CC.COST_CENTER_CODE
               AND   T.EXPIRATION_DATE IS NULL) TYPE_CODE_DESCRIPTION,
            CC.OPEN_DATE,
            CC.CLOSE_DATE
            FROM COST_CENTER CC,
             (SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, CITY, STATE_CODE, ZIP_CODE, COST_CENTER_CODE FROM ADDRESS_USA WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
                  UNION ALL
                 SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, CITY, PROVINCE_CODE AS STATE_CODE,POSTAL_CODE AS ZIP_CODE,  COST_CENTER_CODE FROM ADDRESS_CAN WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
                  UNION ALL
                 SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3,  CITY, PROVINCE_CODE AS STATE_CODE, POSTAL_CODE AS ZIP_CODE, COST_CENTER_CODE FROM ADDRESS_MEX WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
                  UNION ALL
                 SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3,  CITY, PROVINCE_CODE AS STATE_CODE, POSTAL_CODE AS ZIP_CODE, COST_CENTER_CODE FROM ADDRESS_OTHER WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
                ) ADDRESS,
                 POLLING PO                     
            WHERE CC.COST_CENTER_CODE = ADDRESS.COST_CENTER_CODE(+)
            AND CC.COST_CENTER_CODE = PO.COST_CENTER_CODE(+)
       and PO.EXPIRATION_DATE IS NULL;



CREATE OR REPLACE VIEW COSTCNTR_ECOMM_V AS 
          SELECT
        /*******************************************************************************
        This view will provide details required for the e-commerce related to cost center tables
        
        Created  : 06/05/2015 pxc828 CCN Project
        Modified : 08/18/2015 nxk927 CCN Project...
                   added statement_type, statement type description, polling status, changed
                   employee name to be in seperate fields, only including stores and territory, added zip 4
                 : 11/03/2015 dxv848 Added For STORE_EMAIL if it is Product Finish stores then the store email
             	    is like swpxxxx@sherwin.com  for other stores swxxxx@sherwin.com
                 : 11/13/2015 dxv848 CCN Project...
                   Added TAXWare information and FIPS_codes.
                 : 1222/2015 jxc517 CCN Project...
                   Added new fields to pass active TYPE_CODE and description
                 : 03/01/2016 mxr916 CCN Project...
                   Added STATE_DESCRIPTION,COUNTRY_DESCRIPTION,MISSION_CODE_DESCRIPTION,POLLING_STATUS_CODE_DESCRIPTON columns.
        *******************************************************************************/
                (CASE C.CATEGORY
                    WHEN 'T' THEN (SELECT CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(UPPER_LVL_VER_VALUE,'ManagerName')
                                     FROM HIERARCHY_DETAIL
                                    WHERE HRCHY_DTL_CURR_LVL_VAL = H.DOMAIN||H."GROUP"||H.DIVISION||H.AREA||H.DISTRICT||H.CITY_SALES_MANAGER
                                      AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
                                      AND HRCHY_DTL_LEVEL = '6'
                                      AND ROWNUM < 2)
                    ELSE NULL
                  END )SALES_REP_NAME 
                ,(CASE C.CATEGORY
                    WHEN 'T' THEN (SELECT CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(UPPER_LVL_VER_VALUE,'GEMS_ID')
                                     FROM HIERARCHY_DETAIL
                                    WHERE HRCHY_DTL_CURR_LVL_VAL = H.DOMAIN||H."GROUP"||H.DIVISION||H.AREA||H.DISTRICT||H.CITY_SALES_MANAGER
                                      AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
                                      AND HRCHY_DTL_LEVEL = '6'
                                      AND ROWNUM < 2)
                    ELSE NULL
                  END) SALES_REP_NUMBER
                ,C.COST_CENTER_CODE AS STORE_NUMBER
                ,C.COST_CENTER_NAME AS STORE_NAME
                ,C.STATEMENT_TYPE
                ,(SELECT CODE_DETAIL_DESCRIPTION FROM CODE_DETAIL WHERE CODE_HEADER_NAME = 'STATEMENT_TYPE' AND CODE_DETAIL_VALUE = C.STATEMENT_TYPE) STATEMENT_TYPE_DESCRIPTION
                ,ADDRESS.ADDRESS_LINE_1 AS ADDRESS1
                ,ADDRESS.ADDRESS_LINE_2 ADDRESS2
                ,ADDRESS.CITY
                ,ADDRESS.STATE_CODE AS STATE
                ,NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATE_CODE','COD',ADDRESS.STATE_CODE),'N/A') STATE_DESCRIPTION
                ,ADDRESS.ZIP_CODE AS ZIP
                ,ADDRESS.ZIP_CODE_4 AS ZIP_CODE_4
                ,ADDRESS.COUNTY AS COUNTY_NAME
                ,C.COUNTRY_CODE AS COUNTRY
                ,NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('COUNTRY_CODE','COD',C.COUNTRY_CODE),'N/A') COUNTRY_DESCRIPTION
                ,P.PHONE_NUMBER
                ,P.FAX_NUMBER
                ,E.FIRST_NAME
                ,E.MIDDLE_INITIAL
                ,E.LAST_NAME
                ,C.OPEN_DATE
                ,C.CLOSE_DATE
            -- if the FACTS_DIVISION in (C522,C400) and COUNTRY_CODE in (USA,CAN)and active polling_status_code ='P'(then it is Product Finish Stores) then
            -- added swp in front of STORE_EMAIL otherwise add sw in front of STORE_EMAIL
                ,(CASE
                     WHEN
                          PO.COST_CENTER_CODE IN (SELECT COST_CENTER_CODE
                                                     FROM HIERARCHY_DETAIL_VIEW
                                                    WHERE HRCHY_HDR_NAME ='FACTS_DIVISION'
                                                      AND DIVISION IN ('C522','C400'))
                          AND  C.COUNTRY_CODE IN  ('USA','CAN') THEN
                         ('swp'||SUBSTR(c.COST_CENTER_CODE,3)||'@sherwin.com')
                     ELSE
                         ('sw'||SUBSTR(c.COST_CENTER_CODE,3)||'@sherwin.com')
                  END) AS STORE_EMAIL
                ,DECODE(CATEGORY,'R',CATEGORY,NULL) REAL_ESTATE_TYPE
                ,C.MISSION_TYPE_CODE AS MISSION_CODE
                ,NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('MISSION_TYPE_CODE','COD',C.MISSION_TYPE_CODE),'N/A') MISSION_CODE_DESCRIPTION
                ,DECODE(CATEGORY,'S',CATEGORY,NULL) STORE_TYPE
                ,H.DIVISION||H.AREA||DISTRICT AS DAD
                ,H.DIVISION
                ,H.AREA
                ,H.DISTRICT
                ,H.DIVISION_NAME
                ,H.AREA_NAME
                ,H.DISTRICT_NAME
                ,H.CITY_SALES_MANAGER_NAME CITY_MANAGER_NAME
                ,(SELECT CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(UPPER_LVL_VER_VALUE,'ManagerName')
                    FROM HIERARCHY_DETAIL
                   WHERE HRCHY_DTL_CURR_LVL_VAL = H.DOMAIN||H."GROUP"||H.DIVISION||H.AREA||H.DISTRICT
                     AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
                     AND HRCHY_DTL_LEVEL = '5'
                     AND ROWNUM < 2) DISTRICT_MANAGER_NAME
                ,PO.ACTIVE_CD
                ,PO.POLLING_STATUS_CODE
                ,NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('POLLING_STATUS_CODE','COD',PO.POLLING_STATUS_CODE),'N/A') POLLING_STATUS_CODE_DESCRIPTON
                ,TAX.TWJ_STATE AS TW_STATE_CODE
                ,TAX.TWJ_ZIP AS TW_ZIPCODE
                ,TAX.TWJ_GEO AS TW_GEO_CODE
                ,TAX.TWJ_COUNTRY AS TW_COUNTRY
                ,TAX.TWJ_COMPANY AS TW_COMPANY
                ,(SUBSTR(ADDRESS.FIPS_CODE,1,2)) AS FIPS_ST
                ,(SUBSTR(ADDRESS.FIPS_CODE,3,3)) AS FIPS_COUNTY
                ,(SUBSTR(ADDRESS.FIPS_CODE,6,5)) AS FIPS_CITY
                ,TYPE.TYPE_CODE
                ,(SELECT CODE_DETAIL_DESCRIPTION FROM CODE_DETAIL WHERE CODE_HEADER_NAME = 'TYPE_CODE' AND CODE_DETAIL_VALUE = TYPE.TYPE_CODE) TYPE_CODE_DESCRIPTION
            FROM COST_CENTER C,
            ---  FIPS_CODE only avaliable in address_USA, so in other tables(ADDRESS_CAN,ADDRESS_MEX,ADDRESS_OTHER) added NULL as FIPS_CODE for the UNION ALL.
                (SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, CITY, STATE_CODE, ZIP_CODE, ZIP_CODE_4, COUNTY, COST_CENTER_CODE, COUNTRY_CODE,FIPS_CODE  FROM ADDRESS_USA WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
                UNION ALL
                SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, CITY, PROVINCE_CODE AS STATE_CODE,POSTAL_CODE AS ZIP_CODE,NULL AS ZIP_CODE_4 , NULL,  COST_CENTER_CODE, COUNTRY_CODE,NULL AS FIPS_CODE  FROM ADDRESS_CAN WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
                UNION ALL
                SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3,  CITY, PROVINCE_CODE AS STATE_CODE, POSTAL_CODE AS ZIP_CODE, NULL AS ZIP_CODE_4, NULL,COST_CENTER_CODE,COUNTRY_CODE,NULL AS FIPS_CODE  FROM ADDRESS_MEX WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
                UNION ALL
                SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3,  CITY, PROVINCE_CODE AS STATE_CODE, POSTAL_CODE AS ZIP_CODE, NULL AS ZIP_CODE_4, NULL,COST_CENTER_CODE,COUNTRY_CODE,NULL AS FIPS_CODE  FROM ADDRESS_OTHER WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
                ) ADDRESS,
                (SELECT 'A' ACTIVE_CD, COST_CENTER_CODE, POLLING_STATUS_CODE
                   FROM POLLING
                  WHERE  POLLING_STATUS_CODE = 'P'
                    AND CURRENT_FLAG ='Y') PO,
                (WITH T AS (SELECT COST_CENTER_CODE,(PHONE_AREA_CODE||PHONE_NUMBER) VAL,PHONE_NUMBER_TYPE
                              FROM PHONE P)
                      SELECT *
                        FROM T
                             PIVOT 
                             (MIN(VAL) FOR (PHONE_NUMBER_TYPE)IN ('PRI' AS PHONE_NUMBER,
                                                                  'FAX' AS FAX_NUMBER))) P,
                (SELECT * FROM HIERARCHY_DETAIL_VIEW WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY') H
                ,(SELECT E1.FIRST_NAME,E1.MIDDLE_INITIAL,E1.LAST_NAME, E1.COST_CENTER_CODE
                    FROM EMPLOYEE_DETAILS E1
                   WHERE UPPER(E1.JOB_TITLE) ='MGR'
                     AND E1.EMP_PAYROLL_STATUS = 'Active'
                     AND E1.HIRE_DATE = (SELECT MIN(HIRE_DATE)
                                           FROM EMPLOYEE_DETAILS E2
                                          WHERE UPPER(E2.COST_CENTER_CODE) = UPPER(E1.COST_CENTER_CODE)
                                            AND UPPER(E2.JOB_TITLE) ='MGR'
                                            AND E2.EMP_PAYROLL_STATUS = 'Active')) E
                ,TAXWARE TAX
                ,(SELECT *
                    FROM TYPE
                   WHERE EXPIRATION_DATE IS NULL) TYPE
            WHERE C.CATEGORY IN ('S', 'T')
              AND C.COST_CENTER_CODE = ADDRESS.COST_CENTER_CODE(+)
              AND C.COST_CENTER_CODE = H.COST_CENTER_CODE(+)
              AND C.COST_CENTER_CODE = PO.COST_CENTER_CODE(+)
              AND C.COST_CENTER_CODE = P.COST_CENTER_CODE(+)
              AND C.COST_CENTER_CODE = E.COST_CENTER_CODE(+)
              AND C.COST_CENTER_CODE = TAX.COST_CENTER_CODE(+)
              AND C.COST_CENTER_CODE = TYPE.COST_CENTER_CODE(+)
      ORDER BY C.COST_CENTER_CODE;


CREATE OR REPLACE VIEW STORE_MAIN_VW AS
   SELECT
   /**********************************************************
   This view holds required information about STORE
   such as Store number, Zone code, Statement type, Store name,Store open/close date, 
   Status, Status description, Cost center Type, Cost center and Mission code.
   
   Created : 12/11/2014 SXT410 CCN project
   Modified: 01/23/2014 jxc517 CCN Project....
             03/02/2016 mxr916 CCN Project
             Added STATEMENT_TYPE_DESCRIPTION,STATUS_DESCRIPTION,TYPE_DESCRIPTION,MISSION_TYPE_CODE_DESCRIPTION,RURAL_METRO_ZONE_CODE_DESC Columns.
   **********************************************************/
          SUBSTR(CC.COST_CENTER_CODE,3) STORE_NUMBER,
          CC.COST_CENTER_CODE,
          CC.COST_CENTER_NAME,
          CC.STATEMENT_TYPE,
          NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATEMENT_TYPE','COD',CC.STATEMENT_TYPE),'N/A') STATEMENT_TYPE_DESCRIPTION,
          CC.OPEN_DATE,
          CC.CLOSE_DATE,
          S.STATUS_CODE,
          CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATUS_CODE','COD',S.STATUS_CODE) STATUS_DESCRIPTION,
          CCN_HIERARCHY.GET_TYPE_FNC(CC.COST_CENTER_CODE) TYPE,
          (SELECT CD.CODE_DETAIL_DESCRIPTION
             FROM CODE_DETAIL CD, TYPE T
             WHERE CD.CODE_DETAIL_VALUE=T.TYPE_CODE
             AND   CD.CODE_HEADER_NAME='TYPE_CODE'
             AND   T.COST_CENTER_CODE=CC.COST_CENTER_CODE
             AND   T.EXPIRATION_DATE IS NULL) TYPE_DESCRIPTION,
          CC.MISSION_TYPE_CODE,
          NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('MISSION_TYPE_CODE','COD',CC.MISSION_TYPE_CODE),'N/A') MISSION_TYPE_CODE_DESCRIPTION,
          (SELECT RURAL_METRO_ZONE_CODE 
             FROM STORE 
            WHERE COST_CENTER_CODE = CC.COST_CENTER_CODE) RURAL_METRO_ZONE_CODE,
          (SELECT CD.CODE_DETAIL_DESCRIPTION
             FROM CODE_DETAIL CD,STORE S
             WHERE CD.CODE_DETAIL_VALUE=S.RURAL_METRO_ZONE_CODE
             AND   CD.CODE_HEADER_NAME='RURAL_METRO_ZONE_CODE'
             AND   S.COST_CENTER_CODE=CC.COST_CENTER_CODE) RURAL_METRO_ZONE_CODE_DESC
     FROM COST_CENTER CC,
          STATUS S
    WHERE CC.COST_CENTER_CODE = S.COST_CENTER_CODE
   AND S.EXPIRATION_DATE IS NULL;

