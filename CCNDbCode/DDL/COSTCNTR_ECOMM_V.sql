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
        ,ADDRESS.ZIP_CODE AS ZIP
        ,ADDRESS.ZIP_CODE_4 AS ZIP_CODE_4
        ,ADDRESS.COUNTY AS COUNTY_NAME
        ,C.COUNTRY_CODE AS COUNTRY
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
                 ('swp'||SUBSTR(c.COST_CENTER_CODE,3,6)||'@sherwin.com')
             ELSE
                 ('sw'||SUBSTR(c.COST_CENTER_CODE,3,6)||'@sherwin.com')
          END) AS STORE_EMAIL
        ,DECODE(CATEGORY,'R',CATEGORY,NULL) REAL_ESTATE_TYPE
        ,C.MISSION_TYPE_CODE AS MISSION_CODE 
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
    FROM COST_CENTER C,
        (SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, CITY, STATE_CODE, ZIP_CODE, ZIP_CODE_4, COUNTY, COST_CENTER_CODE, COUNTRY_CODE FROM ADDRESS_USA WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
        UNION ALL
        SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, CITY, PROVINCE_CODE AS STATE_CODE,POSTAL_CODE AS ZIP_CODE,NULL AS ZIP_CODE_4 , NULL,  COST_CENTER_CODE, COUNTRY_CODE  FROM ADDRESS_CAN WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
        UNION ALL
        SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3,  CITY, PROVINCE_CODE AS STATE_CODE, POSTAL_CODE AS ZIP_CODE, NULL AS ZIP_CODE_4, NULL,COST_CENTER_CODE,COUNTRY_CODE FROM ADDRESS_MEX WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
        UNION ALL
        SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3,  CITY, PROVINCE_CODE AS STATE_CODE, POSTAL_CODE AS ZIP_CODE, NULL AS ZIP_CODE_4, NULL,COST_CENTER_CODE,COUNTRY_CODE FROM ADDRESS_OTHER WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
        ) ADDRESS,
        (SELECT 'A' ACTIVE_CD, COST_CENTER_CODE, POLLING_STATUS_CODE
           FROM POLLING
          WHERE  POLLING_STATUS_CODE = 'P'
            AND CURRENT_FLAG ='Y')PO,
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
    WHERE C.CATEGORY in ('S', 'T')
      AND C.COST_CENTER_CODE = ADDRESS.COST_CENTER_CODE(+)
      AND C.COST_CENTER_CODE = H.COST_CENTER_CODE(+)
      AND C.COST_CENTER_CODE = PO.COST_CENTER_CODE(+)
      AND C.COST_CENTER_CODE = P.COST_CENTER_CODE(+)
      AND C.COST_CENTER_CODE = E.COST_CENTER_CODE(+)
      ORDER BY C.COST_CENTER_CODE;