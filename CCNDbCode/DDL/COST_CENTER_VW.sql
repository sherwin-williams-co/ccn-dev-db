CREATE OR REPLACE VIEW COST_CENTER_VW AS 
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
             NVL((SELECT CD.CODE_DETAIL_DESCRIPTION
                    FROM CODE_DETAIL CD,
                         POLLING P
                   WHERE CD.CODE_DETAIL_VALUE=P.POLLING_STATUS_CODE
                     AND CD.CODE_HEADER_NAME='POLLING_STATUS_CODE'
                     AND P.CURRENT_FLAG='Y'
                     AND P.COST_CENTER_CODE=C.COST_CENTER_CODE),'N/A') POLLING_STATUS_COD_DESC,
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