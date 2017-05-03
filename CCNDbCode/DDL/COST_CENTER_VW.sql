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
         : 10/26/2015 dxv848 Added COLOR_CONSULTANT_TYPE column.
         : 11/25/2015 axk326 CCN Project Team....
           Added columns PCC_STORE, PCL_STORE to determine the color consultant and color lead 
         : 12/07/2015 jxc527 Modified query for performance to use function based index by adding UPPER() around COST_CENTER_CODE 
           in EMPLOYEE_DETAILS table query
         : 01/06/2015 axk326 CCN Project Team....
           Removed columns PCC_STORE, PCL_STORE and added the column PCC_PCL_STORE from cost_center table
         : 03/01/2016 mxr916 CCN Project Team..
           Added Columns PRI_LOGO_GROUP_IND_DESCRIPTION,SCD_LOGO_GROUP_IND_DESCRIPTION,POLLING_STATUS_COD_DESC
         : 08/04/2016 vxv336 CCN Project Team..
           Added CURRENCY_CODE field
         : 08/25/2016 SXH487 Added ADMIN_COST_CNTR_TYPE
         : 09/27/2016 MXR916 Added TERRITORY_TYPE_BUSN_CODE,TERRITORY_TYPE_BUSN_CODE_DESC columns.
         : 08/17/2016 mxk766 CCN Project Team..
           Added STD_COST_IDENTIFIER and PRIM_COST_IDENTIFIER field
         : 10/12/2016 nxk927 CCN Project Team..
           Added type code and status code
         : 10/28/2016 nxk927 CCN Project Team..
           Git reversion just to move the STD_COST_IDENTIFIER and PRIM_COST_IDENTIFIER field
           ahead of other code
         : 10/28/2016 nxk927 CCN Project Team..
           GIT reversion after moving the STD_COST_IDENTIFIER and PRIM_COST_IDENTIFIER field
         : 11/03/2016 axk326 CCN Project Team..
           Git reversion just to move the TERRITORY_TYPE_BUSN_CODE and TERRITORY_TYPE_BUSN_CODE_DESC fields
           ahead of other code
         : 11/04/2016 MXK766 CCN Project Team..
           Adding INVENTORY_INDICATOR columm from the store table.
         : 11/22/2016 rxs349 CCN Project Team..
           Adding CASE expressions to STD_COST_IDENTIFIER and PRIM_COST_IDENTIFIER columns.
         : 02/28/2017 vxv336 GIT reversion to move TYPE_CODE & STATUS_CODE ahead of other code
********************************************************************************/  
C.COST_CENTER_CODE,
COST_CENTER_NAME,
C.CATEGORY,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('CATEGORY','COD',C.CATEGORY),'N/A') CATEGORY_DESCRIPTION,
STATEMENT_TYPE,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATEMENT_TYPE','COD',STATEMENT_TYPE),'N/A') STATEMENT_TYPE_DESCRIPTION,
COUNTRY_CODE,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('COUNTRY_CODE','COD',COUNTRY_CODE),'N/A') COUNTRY_CODE_DESCRIPTION,
BEGIN_DATE,
OPEN_DATE,
MOVE_DATE,
CLOSE_DATE,
CURRENCY_CODE,
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
CCN_HIERARCHY.GET_TYPE_FNC(C.COST_CENTER_CODE) TYPE_CODE,
(SELECT STATUS_CODE
   FROM STATUS
  WHERE COST_CENTER_CODE = C.COST_CENTER_CODE
    AND EXPIRATION_DATE IS NULL) STATUS_CODE,
(SELECT POLLING_STATUS_CODE
   FROM POLLING
  WHERE CURRENT_FLAG = 'Y'
    AND COST_CENTER_CODE = C.COST_CENTER_CODE) POLLING_STATUS_CODE,
 NVL((SELECT CD.CODE_DETAIL_DESCRIPTION
        FROM CODE_DETAIL CD,
             POLLING P
       WHERE CD.CODE_DETAIL_VALUE=P.POLLING_STATUS_CODE
        AND  CD.CODE_HEADER_NAME ='POLLING_STATUS_CODE'
        AND  P.CURRENT_FLAG='Y'
        AND  P.COST_CENTER_CODE=C.COST_CENTER_CODE),'N/A') POLLING_STATUS_COD_DESC,
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
    AND ROWNUM < 2) LAST_NAME,
(SELECT ADMIN_COST_CNTR_TYPE FROM ADMINISTRATION WHERE COST_CENTER_CODE = C.COST_CENTER_CODE) ADMIN_COST_CNTR_TYPE,
T.TERRITORY_TYPE_BUSN_CODE,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('TERRITORY_TYPE_BUSN_CODE','COD',T.TERRITORY_TYPE_BUSN_CODE),'N/A')TERRITORY_TYPE_BUSN_CODE_DESC,
CASE WHEN C.STD_COST_IDENTIFIER IS NULL AND C.STATEMENT_TYPE IN ('CN','AC') AND NVL(COMMON_TOOLS.IS_CC_SELLING_STORE(C.COST_CENTER_CODE), 'N')= 'Y' THEN
         '08'
     ELSE C.STD_COST_IDENTIFIER END AS STD_COST_IDENTIFIER,
CASE WHEN C.PRIM_COST_IDENTIFIER IS NULL AND C.STATEMENT_TYPE IN ('CN','AC') AND NVL(COMMON_TOOLS.IS_CC_SELLING_STORE(C.COST_CENTER_CODE), 'N') = 'Y' THEN
         '08'
     ELSE C.PRIM_COST_IDENTIFIER END AS PRIM_COST_IDENTIFIER,    
(SELECT ST.INVENTORY_INDICATOR  FROM STORE ST WHERE ST.COST_CENTER_CODE = C.COST_CENTER_CODE) AS INVENTORY_INDICATOR
FROM COST_CENTER C LEFT JOIN
(SELECT COST_CENTER_CODE,CATEGORY,TERRITORY_TYPE_BUSN_CODE FROM TERRITORY ) T
ON (T.COST_CENTER_CODE=C.COST_CENTER_CODE AND  T.CATEGORY='T');