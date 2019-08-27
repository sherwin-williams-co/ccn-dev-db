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
         : 07/07/2016 jxc517 CCN Project Team....
           Added STORE MGR also as part of the cost center manager job title codes
         : 03/01/2016 mxr916 CCN Project.
           Added STATE_DESCRIPTION,COUNTRY_DESCRIPTION,MISSION_CODE_DESCRIPTION,POLLING_STATUS_CODE_DESCRIPTON columns.
         : 08/09/2016 axd783 CCN Project Team....
           Modified the filter condition on POLLING_STATUS_CODE to view Status codes 'Q'
           Added 'Branch MGR' as part of the cost center manger Job Titles
         : 09/06/2016 mxk766 CCN Project Team....
           Added 2 new fields INVENTORY_INDICATOR and PERP_INV_START_DATE from the STORE table.
         : 06/20/2017 jxc517 CCN Project Team....
           Added ADDRESS_BRB table to the view
         : 12/18/2017 axt754 CCN Project Team....
           Added 'COUNTRY_CODE' Field, that holds two digit Country code for Cost center
         : 02/20/2018 sxg151 CCN Project Team...
           Added 'PRIMARY_DSC','ALTERNATE_DSC' Fields -ASP-976
         : 04/03/2018 sxg151 CCN Project Team...
           Added PCC Color(PCC_STORE/PCL_STORE) Fields  ASP-869
		 : 08/26/2019 axm868 CCN Project Team....
     	   Added CC_TEMP_CLOSED_CODE AND CC_TEMP_CLOSED_CODE_DSCRPTN Fields  CCNCC-171
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
        ,STORE.INVENTORY_INDICATOR AS INVENTORY_INDICATOR
        ,STORE.PERP_INV_START_DATE AS PERP_INV_START_DATE
        ,NVL(CCN_COMMON_TOOLS.GET_TRANSLATED_CODE_DETAIL_VAL('COUNTRY_CODE',C.COUNTRY_CODE),'US') COUNTRY_CODE_TWO_DIGIT
        ,CCN_COMMON_TOOLS.GET_COST_CENTER_DSC_CODES(c.COST_CENTER_CODE,'PRIMARY_DSC')   AS PRIMARY_DSC
        ,CCN_COMMON_TOOLS.GET_COST_CENTER_DSC_CODES(c.COST_CENTER_CODE,'SECONDARY_DSC') AS ALTERNATE_DSC
        ,EXTRACTVALUE(PCC_PCL_STORE, '/PCC_PCL_STR/PCC/CC') PCC_STORE
        ,EXTRACTVALUE(PCC_PCL_STORE, '/PCC_PCL_STR/PCL/CC') PCL_STORE
        ,C.CC_TEMP_CLOSED_CD CC_TEMP_CLOSED_CODE
        ,CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('CC_TEMP_CLOSED_CD','COD',C.CC_TEMP_CLOSED_CD) CC_TEMP_CLOSED_CODE_DSCRPTN
    FROM COST_CENTER C,
    ---  FIPS_CODE only avaliable in address_USA, so in other tables(ADDRESS_CAN,ADDRESS_MEX,ADDRESS_OTHER) added NULL as FIPS_CODE for the UNION ALL.
        (SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, CITY, STATE_CODE, ZIP_CODE, ZIP_CODE_4, COUNTY, COST_CENTER_CODE, COUNTRY_CODE,FIPS_CODE  FROM ADDRESS_USA WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
        UNION ALL
        SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, CITY, PROVINCE_CODE AS STATE_CODE,POSTAL_CODE AS ZIP_CODE,NULL AS ZIP_CODE_4 , NULL,  COST_CENTER_CODE, COUNTRY_CODE,NULL AS FIPS_CODE  FROM ADDRESS_CAN WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
        UNION ALL
        SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3,  CITY, PROVINCE_CODE AS STATE_CODE, POSTAL_CODE AS ZIP_CODE, NULL AS ZIP_CODE_4, NULL,COST_CENTER_CODE,COUNTRY_CODE,NULL AS FIPS_CODE  FROM ADDRESS_MEX WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
        UNION ALL
        SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3,  CITY, PROVINCE_CODE AS STATE_CODE, POSTAL_CODE AS ZIP_CODE, NULL AS ZIP_CODE_4, NULL,COST_CENTER_CODE,COUNTRY_CODE,NULL AS FIPS_CODE  FROM ADDRESS_OTHER WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
        UNION ALL
        SELECT PREMISES || ' ' || AVENUE_LANE AS ADDRESS_LINE_1, DISTRICT AS ADDRESS_LINE_2, NULL AS ADDRESS_LINE_3, PARISH AS CITY, SUBSTR(POSTAL_CODE, 1, 2) AS STATE_CODE, SUBSTR(POSTAL_CODE, 3) AS ZIP_CODE, '9999' AS ZIP_CODE_4, NULL, COST_CENTER_CODE, COUNTRY_CODE, NULL AS FIPS_CODE FROM ADDRESS_BRB WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
        ) ADDRESS,
        (SELECT 'A' ACTIVE_CD, COST_CENTER_CODE, POLLING_STATUS_CODE
           FROM POLLING
          WHERE  UPPER(POLLING_STATUS_CODE) IN ('P','Q')
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
           WHERE UPPER(E1.JOB_TITLE) IN ('MGR', 'STORE MGR','BRANCH MGR')
             AND E1.EMP_PAYROLL_STATUS = 'Active'
             AND E1.HIRE_DATE = (SELECT MIN(HIRE_DATE)
                                   FROM EMPLOYEE_DETAILS E2
                                  WHERE UPPER(E2.COST_CENTER_CODE) = UPPER(E1.COST_CENTER_CODE)
                                    AND UPPER(E2.JOB_TITLE) IN ('MGR', 'STORE MGR','BRANCH MGR')
                                    AND E2.EMP_PAYROLL_STATUS = 'Active')) E
        ,TAXWARE TAX
        ,(SELECT *
            FROM TYPE
           WHERE EXPIRATION_DATE IS NULL) TYPE
        ,(SELECT COST_CENTER_CODE,INVENTORY_INDICATOR,PERP_INV_START_DATE FROM STORE) STORE
    WHERE C.CATEGORY IN ('S', 'T')
      AND C.COST_CENTER_CODE = ADDRESS.COST_CENTER_CODE(+)
      AND C.COST_CENTER_CODE = H.COST_CENTER_CODE(+)
      AND C.COST_CENTER_CODE = PO.COST_CENTER_CODE(+)
      AND C.COST_CENTER_CODE = P.COST_CENTER_CODE(+)
      AND C.COST_CENTER_CODE = E.COST_CENTER_CODE(+)
      AND C.COST_CENTER_CODE = TAX.COST_CENTER_CODE(+)
      AND C.COST_CENTER_CODE = TYPE.COST_CENTER_CODE(+)
      AND C.COST_CENTER_CODE = STORE.COST_CENTER_CODE(+)
      ORDER BY C.COST_CENTER_CODE;