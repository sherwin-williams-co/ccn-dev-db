--------------------------------------------------------
--  File created - 02/18/2015 
--  Modified     - 11/02/2015 dxv848 Added PRI_LOGO_GROUP_IND,SCD_LOGO_GROUP_IND columns.
--               - 11/25/2015 axk326 CCN Project Team....
--                 Added columns PCC_STORE, PCL_STORE to determine the color consultant and color lead
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View COST_CENTER_VW
--------------------------------------------------------

  CREATE OR REPLACE VIEW COST_CENTER_VW
  AS
  SELECT
/*******************************************************************************
This View holds all the required data for a cost_center its country_code, Mission_type_code along with their descriptions
and also Acquisition_code from COST_CENTER table.

created  : 03/18/2014 for CCN project and
Modified : 07/18/14 Added ACQUISITION_CODE column.
Modified : 02/17/2015 SXT410 Added FAX_PHONE_NUMBER, POLLING_STATUS_CODE and
           Manager/Asst Manager/Sales rep Name broken out with first, initial, last.
           10/06/2015 nxk927 Added PRI_LOGO_GROUP_IND,SCD_LOGO_GROUP_IND columns.
		       10/26/2015 dxv848 Added COLOR_CONSULTANT_TYPE column.
         : 11/25/2015 axk326 CCN Project Team....
           Added columns PCC_STORE, PCL_STORE to determine the color consultant and color lead 
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
SCD_LOGO_GROUP_IND,
COLOR_CONSULTANT_TYPE,
DECODE(EXTRACT(PCC_PCL_STORE,'/PCC_PCL_STR/PCC/CC/text()').getStringVal(),
       NULL, 
       NULL,
       EXTRACT(PCC_PCL_STORE,'/PCC_PCL_STR/PCC/CC/text()').getStringVal() || '~ Personnel Color Consultant')PCC_STORE,
DECODE(EXTRACT(PCC_PCL_STORE,'/PCC_PCL_STR/PCL/CC/text()').getStringVal(),
       NULL, 
       NULL,
       EXTRACT(PCC_PCL_STORE,'/PCC_PCL_STR/PCL/CC/text()').getStringVal() || '~ Personnel Color Lead')PCL_STORE,
COMMON_TOOLS.GET_PHONE_NUMBER (C.COST_CENTER_CODE, 'FAX') FAX_PHONE_NUMBER,
(SELECT POLLING_STATUS_CODE
   FROM POLLING
  WHERE CURRENT_FLAG = 'Y'
    AND COST_CENTER_CODE = C.COST_CENTER_CODE) POLLING_STATUS_CODE,
(SELECT HOME_STORE
   FROM TERRITORY
  WHERE CATEGORY = 'T'
    AND COST_CENTER_CODE = C.COST_CENTER_CODE) TERR_HOME_STORE_NO,
(SELECT FIRST_NAME FROM EMPLOYEE_DETAILS
  WHERE UPPER(JOB_TITLE) IN ('MGR', 'ASST MGR', 'SALES REP')
    AND COST_CENTER_CODE = C.COST_CENTER_CODE
    AND UPPER(EMP_PAYROLL_STATUS) = 'ACTIVE'
    AND ROWNUM < 2) FIRST_NAME,
(SELECT MIDDLE_INITIAL FROM EMPLOYEE_DETAILS
  WHERE UPPER(JOB_TITLE) IN ('MGR', 'ASST MGR', 'SALES REP')
    AND COST_CENTER_CODE = C.COST_CENTER_CODE
    AND UPPER(EMP_PAYROLL_STATUS) = 'ACTIVE'
    AND ROWNUM < 2) MIDDLE_INITIAL,
(SELECT LAST_NAME FROM EMPLOYEE_DETAILS
  WHERE UPPER(JOB_TITLE) IN ('MGR', 'ASST MGR', 'SALES REP')
    AND COST_CENTER_CODE = C.COST_CENTER_CODE
    AND UPPER(EMP_PAYROLL_STATUS) = 'ACTIVE'
    AND ROWNUM < 2) LAST_NAME
FROM COST_CENTER C;