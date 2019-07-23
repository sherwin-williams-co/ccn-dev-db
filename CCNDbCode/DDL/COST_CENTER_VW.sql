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
         : 02/28/2017 vxv336 GIT reversion to move TYPE_CODE  ahead of other code
         : 04/27/2017 gxg192 Adding PERP_INV_START_DATE columm from the store table.
         : 08/11/2017 gxg192 Added TYPE_CODE_DESCRIPTION columm.
         : 08/21/2017 gxg192 Added STORE_EMAIL columm.
         : 09/06/2017 axt754 Added BOOK_PLAN_PROFILE_CD
         : 09/28/2017 axt754 Put back POLLING_IND, which was removed
         : 11/22/2017 sxh487 Added RURAL_METRO_ZONE_CODE and SPRAY_EQP_RPR_IND
         : 01/17/2018 sxh487 Added CLASSIFICATION_CODE, CLASSIFICATION_CODE_DESC and SELLING_STORE_FLAG
         : 02/13/2018 sxg151 Added POP_KIT_CODE,POP_KIT_CODE_DESC,SALES_VOL_CLASS_CODE,SALES_VOL_CLASS_CODE_DESC columns
         : 03/20/2018 rxv940 Added LATITUDE and LONGITUDE columns to the view 
         : 03/27/2018 nxk927 Remove business rules Per ASP-926 to display PRIM_COST_IDENTIFIER and STD_COST_IDENTIFIER
                             as is without any transformation for Canadian selling stores
         : 04/30/2018 nxk927 Added polling start date and stop date
         : 07/10/2018 kxm302 Added square footage details from CCN_SWC_PN_SQFT_INT
         : 09/13/2018 kxm302 Added function CCN_DERIVED_VALUES.GET_CC_MANAGER_NAME  to get MGR_NAME ASP -1128.
         : 10/17/2018 pxa852 Removed CCN_SWC_PN_SQFT_INT and added square footage details from Marketing ASP -886.
         : 12/07/2018 kxm302 Changed column names from Leasing to Marketing for LEASING_SALES_SQ_FT and LEASING_TOTAL_SQ_FT ASP-1178.
         : 07/23/2019 akj899 CCNCC-4 CCN project Team.. 
                      Added column TERRITORY_TYP_OF_BUSN_SGMNT_CD and TERRITORY_TYP_OF_BUSN_SGMNT_CD_DESC
****************************************************************************************************************************************/  
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
(SELECT POLLING_IND
   FROM POLLING
  WHERE CURRENT_FLAG = 'Y'
    AND COST_CENTER_CODE = C.COST_CENTER_CODE) POLLING_IND,
(SELECT POLLING_START_DATE
   FROM POLLING
  WHERE CURRENT_FLAG = 'Y'
    AND COST_CENTER_CODE = C.COST_CENTER_CODE) POLLING_START_DATE,
(SELECT POLLING_STOP_DATE
   FROM POLLING
  WHERE CURRENT_FLAG = 'Y'
    AND COST_CENTER_CODE = C.COST_CENTER_CODE) POLLING_STOP_DATE,
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
T.TERRITORY_TYP_OF_BUSN_SGMNT_CD,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('TERRITORY_TYPE_BUSN_CODE','COD',T.TERRITORY_TYPE_BUSN_CODE),'N/A')TERRITORY_TYPE_BUSN_CODE_DESC,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('TERRITORY_TYP_OF_BUSN_SGMNT_CD','COD',T.TERRITORY_TYP_OF_BUSN_SGMNT_CD),'N/A')TERRITORY_TYP_OF_BUSN_SGMNT_CD_DESC,
STD_COST_IDENTIFIER,
PRIM_COST_IDENTIFIER,    
(SELECT ST.INVENTORY_INDICATOR  FROM STORE ST WHERE ST.COST_CENTER_CODE = C.COST_CENTER_CODE) AS INVENTORY_INDICATOR,
(SELECT S.PERP_INV_START_DATE   FROM STORE S  WHERE S.COST_CENTER_CODE = C.COST_CENTER_CODE) AS PERP_INV_START_DATE,
(SELECT STR.RURAL_METRO_ZONE_CODE  FROM STORE STR WHERE STR.COST_CENTER_CODE = C.COST_CENTER_CODE) AS RURAL_METRO_ZONE_CODE,
 NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('TYPE_CODE','COD',CCN_HIERARCHY.GET_TYPE_FNC(C.COST_CENTER_CODE)),'N/A') AS TYPE_CODE_DESCRIPTION,
 -- if the FACTS_DIVISION in (C522,C400) and COUNTRY_CODE in (USA,CAN) then
 -- added swp in front of STORE_NUMBER otherwise added sw in front of STORE_NUMBER
 (CASE
     WHEN
         C.COUNTRY_CODE IN ('USA','CAN') AND 
         C.COST_CENTER_CODE IN (SELECT COST_CENTER_CODE
                                  FROM FACTS_DIVISION_DETAIL_VIEW
                                 WHERE DIVISION IN ('C522','C400'))
         THEN
            ('swp'||SUBSTR(C.COST_CENTER_CODE,3)||'@sherwin.com')
     ELSE
         ('sw'||SUBSTR(C.COST_CENTER_CODE,3)||'@sherwin.com')
  END) AS STORE_EMAIL,
C.BOOK_PLN_PROFILE_CD,
C.SPRAY_EQP_RPR_IND,
(SELECT CLASSIFICATION_CODE  FROM STORE STR WHERE STR.COST_CENTER_CODE = C.COST_CENTER_CODE) AS CLASSIFICATION_CODE,
 NVL((SELECT CD.CODE_DETAIL_DESCRIPTION
        FROM CODE_DETAIL CD,
             STORE ST
       WHERE CD.CODE_DETAIL_VALUE=ST.CLASSIFICATION_CODE
        AND  CD.CODE_HEADER_NAME ='CLASSIFICATION_CODE'
        AND  ST.COST_CENTER_CODE=C.COST_CENTER_CODE),'N/A') CLASSIFICATION_CODE_DESC,
(SELECT SELLING_STORE_FLAG  FROM STORE STR WHERE STR.COST_CENTER_CODE = C.COST_CENTER_CODE) AS SELLING_STORE_FLAG,
C.POP_KIT_CODE,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('POP_KIT_CODE','COD',C.POP_KIT_CODE),'N/A') POP_KIT_CODE_DESC,
(SELECT SALES_VOL_CLASS_CODE  FROM STORE STR WHERE STR.COST_CENTER_CODE = C.COST_CENTER_CODE) AS SALES_VOL_CLASS_CODE,
 NVL((SELECT CD.CODE_DETAIL_DESCRIPTION
        FROM CODE_DETAIL CD,
             STORE ST
       WHERE CD.CODE_DETAIL_VALUE=ST.SALES_VOL_CLASS_CODE
        AND  CD.CODE_HEADER_NAME ='SALES_VOL_CLASS_CODE'
        AND  ST.COST_CENTER_CODE=C.COST_CENTER_CODE),'N/A') SALES_VOL_CLASS_CODE_DESC,
COMMON_TOOLS.GET_COST_CENTER_GEO_LATD_LNGTD(C.COST_CENTER_CODE, 'LON') LONGITUDE, 
COMMON_TOOLS.GET_COST_CENTER_GEO_LATD_LNGTD(C.COST_CENTER_CODE, 'LAT') LATITUDE, 
M.SALES_SQ_FT MKT_SALES_SQ_FT,
M.TOTAL_SQ_FT MKT_TOTAL_SQ_FT,
C.LEASE_OWN_CODE LEASE_OR_OWNED,
CCN_DERIVED_VALUES.GET_CC_MANAGER_NAME(C.COST_CENTER_CODE) CC_MGR_NAME
FROM COST_CENTER C LEFT JOIN
(SELECT COST_CENTER_CODE,CATEGORY,TERRITORY_TYPE_BUSN_CODE,TERRITORY_TYP_OF_BUSN_SGMNT_CD FROM TERRITORY ) T
ON (T.COST_CENTER_CODE=C.COST_CENTER_CODE AND  T.CATEGORY='T')
LEFT JOIN
(SELECT SALES_SQ_FT,TOTAL_SQ_FT,COST_CENTER_CODE, EXPIRATION_DATE FROM MARKETING) M
ON (M.COST_CENTER_CODE=C.COST_CENTER_CODE AND M.EXPIRATION_DATE IS NULL )
;
