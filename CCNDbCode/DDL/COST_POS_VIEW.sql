
  CREATE OR REPLACE FORCE EDITIONABLE VIEW "COSTCNTR"."COST_POS_VIEW" ("COST_CENTER_CODE", "CATEGORY", "CATEGORY_DESCRIPTION", "COST_CENTER_NAME", "ADDRESS_LINE_1", "ADDRESS_LINE_2", "ADDRESS_LINE_3", "CITY", "STATE_CODE", "STATE_CODE_DESCRIPTION", "ZIP_CODE", "POLLING_STATUS_CODE", "POLLING_STATUS_COD_DESCRIPTION", "POLL_STATUS_EFF_DT", "GLOBAL_HIERARCHY", "PRIMARY_PHONE_NUMBER", "SECONDARY_PHONE_NUMBER", "FAX_PHONE_NUMBER", "STATEMENT_TYPE", "STATEMENT_TYPE_DESCRIPTION", "TYPE_CODE", "TYPE_CODE_DESCRIPTION", "OPEN_DATE", "CLOSE_DATE", "CURRENCY_CODE", "CURRENCY_CODE_DESCRIPTION", "POLLING_START_DATE", "POLLING_STOP_DATE") AS 
  SELECT
/*******************************************************************************
This View holds all the required data for a cost center, its address, 
polling status and the hierarchy it is associated with it.

Created  : 03/31/2014 NXK927 CCN Project
Modified : 01/22/2015 SXT410 Added Columns OPEN_DATE and CLOSE_DATE.
         : 01/29/2015 SXT410 Added Effective_date Column from Polling table.
         : 08/14/2015 NXK927 Only including current polling status
         : 03/01/2016 MXR916 Added STATE_CODE_DESCRIPTION,POLLING_STATUS_COD_DESCRIPTION,STATEMENT_TYPE_DESCRIPTION,TYPE_CODE_DESCRIPTION Columns.
         : 11/30/2016 vxv336 Added CURRENCY_CODE and CURRENCY_CODE_DESCRIPTION fields
         : 03/13/2018 nxk927 Added Polling start date and polling stop date fields
         : 06/12/2018 pxa852 CCN Project Team....
           EFFECTIVE_DATE column name changed to POLL_STATUS_EFF_DT and
           EXPIRATION_DATE column name changed to POLL_STATUS_EXP_DT
         : 04/09/2019 jxc517 CCN Project Team....
                             Added condition to exclude archived cost centers from this view
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
       PO.POLL_STATUS_EFF_DT,
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
       NVL((SELECT CD.CODE_DETAIL_DESCRIPTION
              FROM CODE_DETAIL CD,
                   TYPE T
             WHERE CD.CODE_DETAIL_VALUE=T.TYPE_CODE
              AND  CD.CODE_HEADER_NAME='TYPE_CODE'
              AND  T.COST_CENTER_CODE=CC.COST_CENTER_CODE
              AND  T.EXPIRATION_DATE IS NULL),'N/A') TYPE_CODE_DESCRIPTION,
       CC.OPEN_DATE,
       CC.CLOSE_DATE,
       CC.CURRENCY_CODE,
       NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('CURRENCY_CODE','COD',CC.CURRENCY_CODE),'N/A') CURRENCY_CODE_DESCRIPTION,
       PO.POLLING_START_DATE,
       PO.POLLING_STOP_DATE
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
       AND PO.POLL_STATUS_EXP_DT IS NULL
       AND COMMON_TOOLS.IS_ARCHIVE_CC_FNC(CC.COST_CENTER_CODE) = 'N';