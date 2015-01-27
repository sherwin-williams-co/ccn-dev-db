CREATE OR REPLACE VIEW COST_POS_VIEW
AS 
SELECT
/*******************************************************************************
This View holds all the required data for a cost center, its address, 
polling status and the hierarchy it is associated with it.

Created  : 03/31/2014 NXK927 CCN Project
Modified : 01/22/2015 SXT410 Added Columns OPEN_DATE and CLOSE_DATE.
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
       ZIP_CODE,
       PO.POLLING_STATUS_CODE,
       (SELECT HRCHY_DTL_CURR_LVL_VAL
          FROM HIERARCHY_DETAIL
         WHERE HRCHY_DTL_CURR_ROW_VAL = CC.COST_CENTER_CODE
           AND HRCHY_HDR_NAME         = 'GLOBAL_HIERARCHY'
           AND ROWNUM < 2) AS GLOBAL_HIERARCHY,
       (SELECT PHONE_AREA_CODE || '-' || PHONE_NUMBER
          FROM PHONE
         WHERE COST_CENTER_CODE = CC.COST_CENTER_CODE
           AND PHONE_NUMBER_TYPE = 'PRI') AS PRIMARY_PHONE_NUMBER,
       (SELECT PHONE_AREA_CODE || '-' || PHONE_NUMBER
          FROM PHONE
         WHERE COST_CENTER_CODE = CC.COST_CENTER_CODE
           AND PHONE_NUMBER_TYPE = 'SCD') AS SECONDARY_PHONE_NUMBER, 
       (SELECT PHONE_AREA_CODE || '-' || PHONE_NUMBER
          FROM PHONE
         WHERE COST_CENTER_CODE = CC.COST_CENTER_CODE
           AND PHONE_NUMBER_TYPE = 'FAX') AS FAX_PHONE_NUMBER,
       CC.STATEMENT_TYPE, 
       (SELECT TYPE_CODE
          FROM TYPE
         WHERE COST_CENTER_CODE = CC.COST_CENTER_CODE
           AND EXPIRATION_DATE IS NULL) AS TYPE_CODE,
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
       AND CC.COST_CENTER_CODE = PO.COST_CENTER_CODE;
