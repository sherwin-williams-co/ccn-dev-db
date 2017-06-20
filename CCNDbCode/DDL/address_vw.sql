CREATE OR REPLACE VIEW ADDRESS_VW AS 
/***********************************************************************
This view will have all the address information for all teh cost centers
created  : 09/14/2015
modified : 09/14/2015 nxk927
         added the active flag
       : 09/17/2015 jxc527
         query changed to handle Territory store's address.
       : 11/24/2015 nxk927
         corrected the active spelling
       : 11/24/2015 nxk927
         added ADMIN_COST_CNTR_TYPE column
       : 07/13/2016 nxk927/axk326
         added ADDRESS_BRB to the view
       : 06/13/2017 rxa457 CCN Project Team...
             Performance Tuning Changes...ASP-804
************************************************************************/
 SELECT COST_CENTER_CD AS COST_CENTER_CODE
        ,ADMIN_COST_CNTR_TYPE AS COST_CNTR_TYPE
        ,ADDRESS_TYPE
        ,DECODE(EXPIRATION_DATE, NULL, 'Y', 'N') ACTIVE_FLAG
        ,NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('ADDRESS_TYPE','COD',M.ADDRESS_TYPE),'N/A') ADDRESS_TYPE_DESCRIPTION
        ,EFFECTIVE_DATE
        ,EXPIRATION_DATE
        ,ADDRESS_LINE_1
        ,ADDRESS_LINE_2
        ,ADDRESS_LINE_3
        ,CITY
        ,PROVINCE_CODE
        ,PROVINCE_CODE_DESCRIPTION
        ,STATE_CODE
        ,STATE_CODE_DESCRIPTION
        ,PREMISES
        ,AVENUE_LANE
        ,DISTRICT
        ,PARISH
        ,POSTAL_CODE
        ,ZIP_CODE
        ,ZIP_CODE_4
        ,COUNTY
        ,FIPS_CODE
        ,DESTINATION_POINT
        ,CHECK_DIGIT
        ,VALID_ADDRESS
        ,COUNTRY_CODE
        ,NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('COUNTRY_CODE','COD',M.COUNTRY_CODE),'N/A') COUNTRY_CODE_DESCRIPTION
   FROM (
            SELECT  ADDRESS_TYPE
                    ,COST_CENTER_CODE
                    ,EFFECTIVE_DATE
                    ,EXPIRATION_DATE
                    ,ADDRESS_LINE_1
                    ,ADDRESS_LINE_2
                    ,ADDRESS_LINE_3
                    ,CITY
                    ,PROVINCE_CODE
                    ,NULL AS PROVINCE_CODE_DESCRIPTION
                    ,STATE_CODE
                    ,NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATE_CODE','COD',STATE_CODE),'N/A') STATE_CODE_DESCRIPTION
                    ,NULL AS PREMISES
                    ,NULL AS AVENUE_LANE
                    ,NULL AS DISTRICT
                    ,NULL AS PARISH
                    ,POSTAL_CODE
                    ,NULL AS ZIP_CODE
                    ,NULL AS ZIP_CODE_4
                    ,NULL AS COUNTY
                    ,NULL AS FIPS_CODE
                    ,NULL AS DESTINATION_POINT
                    ,NULL AS CHECK_DIGIT
                    ,VALID_ADDRESS
                    ,COUNTRY_CODE
               FROM ADDRESS_OTHER
            UNION ALL
            SELECT  ADDRESS_TYPE
                    ,COST_CENTER_CODE    
                    ,EFFECTIVE_DATE
                    ,EXPIRATION_DATE
                    ,ADDRESS_LINE_1
                    ,ADDRESS_LINE_2
                    ,ADDRESS_LINE_3
                    ,CITY
                    ,NULL AS PROVINCE_CODE
                    ,NULL AS PROVINCE_CODE_DESCRIPTION
                    ,STATE_CODE
                    ,NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATE_CODE','COD',STATE_CODE),'N/A') STATE_CODE_DESCRIPTION
                    ,NULL AS PREMISES
                    ,NULL AS AVENUE_LANE
                    ,NULL AS DISTRICT
                    ,NULL AS PARISH
                    ,NULL AS POSTAL_CODE
                    ,ZIP_CODE
                    ,ZIP_CODE_4
                    ,COUNTY
                    ,FIPS_CODE
                    ,DESTINATION_POINT
                    ,CHECK_DIGIT
                    ,VALID_ADDRESS
                    ,COUNTRY_CODE
               FROM ADDRESS_USA
            UNION ALL
            SELECT  ADDRESS_TYPE
                    ,COST_CENTER_CODE    
                    ,EFFECTIVE_DATE
                    ,EXPIRATION_DATE
                    ,ADDRESS_LINE_1
                    ,ADDRESS_LINE_2
                    ,ADDRESS_LINE_3
                    ,CITY
                    ,PROVINCE_CODE
                    ,NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('PROVINCE_CODE_CAN','COD',PROVINCE_CODE),'N/A') PROVINCE_CODE_DESCRIPTION
                    ,NULL AS STATE_CODE
                    ,NULL AS STATE_CODE_DESCRIPTION
                    ,NULL AS PREMISES
                    ,NULL AS AVENUE_LANE
                    ,NULL AS DISTRICT
                    ,NULL AS PARISH
                    ,POSTAL_CODE
                    ,NULL AS ZIP_CODE
                    ,NULL AS ZIP_CODE_4
                    ,NULL AS COUNTY
                    ,NULL AS FIPS_CODE
                    ,NULL AS DESTINATION_POINT
                    ,NULL AS CHECK_DIGIT
                    ,VALID_ADDRESS
                    ,COUNTRY_CODE
               FROM ADDRESS_CAN
            UNION ALL 
            SELECT  ADDRESS_TYPE
                    ,COST_CENTER_CODE    
                    ,EFFECTIVE_DATE
                    ,EXPIRATION_DATE
                    ,ADDRESS_LINE_1
                    ,ADDRESS_LINE_2
                    ,ADDRESS_LINE_3
                    ,CITY
                    ,PROVINCE_CODE
                    ,NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('PROVINCE_CODE_MEX','COD',PROVINCE_CODE),'N/A') PROVINCE_CODE_DESCRIPTION
                    ,NULL AS STATE_CODE
                    ,NULL AS STATE_CODE_DESCRIPTION
                    ,NULL AS PREMISES
                    ,NULL AS AVENUE_LANE
                    ,NULL AS DISTRICT
                    ,NULL AS PARISH
                    ,POSTAL_CODE
                    ,NULL AS ZIP_CODE
                    ,NULL AS ZIP_CODE_4
                    ,NULL AS COUNTY
                    ,NULL AS FIPS_CODE
                    ,NULL AS DESTINATION_POINT
                    ,NULL AS CHECK_DIGIT
                    ,VALID_ADDRESS
                    ,COUNTRY_CODE
               FROM ADDRESS_MEX
            UNION ALL
            SELECT  ADDRESS_TYPE
                    ,COST_CENTER_CODE    
                    ,EFFECTIVE_DATE
                    ,EXPIRATION_DATE
                    ,NULL AS ADDRESS_LINE_1
                    ,NULL AS ADDRESS_LINE_2
                    ,NULL AS ADDRESS_LINE_3
                    ,NULL AS CITY
                    ,NULL AS PROVINCE_CODE
                    ,NULL AS PROVINCE_CODE_DESCRIPTION
                    ,NULL AS STATE_CODE
                    ,NULL AS STATE_CODE_DESCRIPTION
                    ,PREMISES
                    ,AVENUE_LANE
                    ,DISTRICT
                    ,PARISH
                    ,POSTAL_CODE
                    ,NULL AS ZIP_CODE
                    ,NULL AS ZIP_CODE_4
                    ,NULL AS COUNTY
                    ,NULL AS FIPS_CODE
                    ,NULL AS DESTINATION_POINT
                    ,NULL AS CHECK_DIGIT
                    ,VALID_ADDRESS
                    ,COUNTRY_CODE
               FROM ADDRESS_BRB
        )M,
        (
            SELECT A.ADMIN_COST_CNTR_TYPE,
                   C.COST_CENTER_CODE AS COST_CENTER_CD,
                   CASE
                     WHEN C.CATEGORY = 'T' THEN 
                       NVL ( T.HOME_STORE, C.COST_CENTER_CODE )
                     ELSE 
                       C.COST_CENTER_CODE
                     END AS CC_CODE
              FROM COST_CENTER C,
                   TERRITORY T,
                   ADMINISTRATION A
             WHERE C.COST_CENTER_CODE = T.COST_CENTER_CODE(+)
               AND C.COST_CENTER_CODE = A.COST_CENTER_CODE(+)
        )C
  WHERE C.CC_CODE = M.COST_CENTER_CODE;
