CREATE OR REPLACE VIEW COST_POS_VIEW AS
  SELECT DISTINCT CC.COST_CENTER_CODE,
                CC.CATEGORY,
                NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('CATEGORY','COD',CC.CATEGORY),'N/A') CATEGORY_DESCRIPTION,
                CC.COST_CENTER_NAME, 
                ADDRESS.ADDRESS_LINE_1,
                ADDRESS.ADDRESS_LINE_2, 
                ADDRESS.ADDRESS_LINE_3,
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
                    AND EXPIRATION_DATE IS NULL) AS TYPE_CODE 
                FROM COST_CENTER CC,
                    (SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, COST_CENTER_CODE FROM ADDRESS_USA WHERE ADDRESS_TYPE = 'M'
                      UNION ALL
                     SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, COST_CENTER_CODE FROM ADDRESS_CAN WHERE ADDRESS_TYPE = 'M'
                      UNION ALL
                     SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, COST_CENTER_CODE FROM ADDRESS_MEX WHERE ADDRESS_TYPE = 'M'
                      UNION ALL
                     SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, COST_CENTER_CODE FROM ADDRESS_OTHER WHERE ADDRESS_TYPE = 'M') ADDRESS
                WHERE CC.COST_CENTER_CODE = ADDRESS.COST_CENTER_CODE(+);
