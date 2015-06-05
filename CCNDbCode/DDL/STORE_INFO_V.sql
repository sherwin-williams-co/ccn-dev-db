
CREATE OR REPLACE FORCE VIEW "COSTCNTR"."STORE_INFO_V" ("SALES_REP_NAME", "SALES_REP_NUMBER", "STORE_NUMBER", "STORE_NAME", "ADDRESS1", "ADDRESS2", "CITY", "STATE", "ZIP", "COUNTY_NAME", "COUNTRY", "PHONE_NUMBER", "FAX_NUMBER", "MANAGER_NAME", "OPEN_DATE", "CLOSE_DATE", "STORE_EMAIL", "REAL_ESTATE_TYPE", "MISSION_CODE", "STORE_TYPE", "DAD", "DIVISION", "AREA", "DISTRICT", "DIVISION_NAME", "AREA_NAME", "DISTRICT_NAME", "CITY_MANAGER_NAME", "DISTRICT_MANAGER_NAME", "ACTIVE_CD") AS 
  SELECT
	/*******************************************************************************
	This View will give all the details linked to the cost centre

	Created  : 06/05/2015 pxc828 CCN Project
	Modified : 
	*******************************************************************************/
    (SELECT HRCHY_DTL_CURR_ROW_VAL
           FROM HIERARCHY_DETAIL
           WHERE C.CATEGORY = 'T'
            AND HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                             FROM HIERARCHY_DESCRIPTION
                                                                            WHERE HRCHY_HDR_LVL_NBR <= 6
                                                                              AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
            AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
            AND HRCHY_DTL_LEVEL = 6
            AND ROWNUM < 2) AS SALES_REP_NAME,
      (SELECT EXTRACT(UPPER_LVL_VER_VALUE,'/attributes/upper_lvl_ver_desc[2]/Value/text()').getStringVal() 
           FROM HIERARCHY_DETAIL
           WHERE C.CATEGORY = 'T'
            AND HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                             FROM HIERARCHY_DESCRIPTION
                                                                            WHERE HRCHY_HDR_LVL_NBR <= 6
                                                                              AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
            AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
            AND HRCHY_DTL_LEVEL = 6
            AND ROWNUM < 2) AS SALES_REP_NUM ,
			C.COST_CENTER_CODE AS STORE_NUMBER, 
			C.COST_CENTER_NAME AS STORE_NAME, 
			ADDRESS.ADDRESS_LINE_1 AS ADDRESS_1,  
			ADDRESS.ADDRESS_LINE_2 ADDRESS_2,
			ADDRESS.CITY, 
			ADDRESS.STATE_CODE AS STATE, 
			ADDRESS.ZIP_CODE AS ZIP, 
			ADDRESS.COUNTY AS COUNTY_NAME, 
			C.COUNTRY_CODE,
			(SELECT (P.PHONE_AREA_CODE||P.PHONE_NUMBER) 
				FROM PHONE P 
				WHERE P.COST_CENTER_CODE = C.COST_CENTER_CODE 
					AND PHONE_NUMBER_TYPE = 'PRI') AS PHONE_NUMBER,
			(SELECT (P.PHONE_AREA_CODE||P.PHONE_NUMBER) 
				FROM PHONE P 
				WHERE P.COST_CENTER_CODE = C.COST_CENTER_CODE 
					AND PHONE_NUMBER_TYPE = 'FAX') AS FAX,
			(SELECT EMPLOYEE_NAME 
				FROM EMPLOYEE_DETAILS E1 
				WHERE  UPPER(E1.COST_CENTER_CODE) = UPPER(C.COST_CENTER_CODE)
                    AND E1.HIRE_DATE = (SELECT MIN(HIRE_DATE) 
											FROM EMPLOYEE_DETAILS E2 
											WHERE UPPER(E2.COST_CENTER_CODE) = UPPER(C.COST_CENTER_CODE)
                                                  AND E2.EMP_PAYROLL_STATUS = 'Active' 
                                                  AND UPPER(E2.JOB_TITLE) ='MGR')                                         
                    AND UPPER(E1.JOB_TITLE) ='MGR') AS MANAGER_NAME,
			C.OPEN_DATE, 
			C.CLOSE_DATE,
			(SUBSTR(C.COST_CENTER_CODE,3,6)||'@sherwin.com') AS STORE_EMAIL,
			(SELECT REAL_ESTATE_CATEGORY 
				FROM COST_CENTER_REAL_ESTATE R  
				WHERE R.COST_CENTER_CODE = C.COST_CENTER_CODE) AS REAL_ESTATE_TYPE,
			C.MISSION_TYPE_CODE, 
			(SELECT S.CATEGORY 
				FROM STORE S 
				WHERE S.COST_CENTER_CODE = C.COST_CENTER_CODE) AS STORE_TYPE,
			H.DIVISION||H.AREA||DISTRICT AS DAD,
			H.DIVISION,
			H.AREA,
			H.DISTRICT,
		   (SELECT HRCHY_DTL_DESC
			   FROM HIERARCHY_DETAIL
			   WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
																				 FROM HIERARCHY_DESCRIPTION
																				WHERE HRCHY_HDR_LVL_NBR <= 3
																				  AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
				AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
				AND HRCHY_DTL_LEVEL = 3
				AND ROWNUM < 2) DIVISION_NAME,
			NVL2(H.AREA,
             (SELECT HRCHY_DTL_DESC
                FROM HIERARCHY_DETAIL
               WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                                   FROM HIERARCHY_DESCRIPTION
                                                                                  WHERE HRCHY_HDR_LVL_NBR <= 4
                                                                                    AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
                 AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
                 AND HRCHY_DTL_LEVEL = 4
                 AND ROWNUM < 2),
                 NULL) AREA_NAME,
			(SELECT HRCHY_DTL_DESC
				FROM HIERARCHY_DETAIL
				WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
																					FROM HIERARCHY_DESCRIPTION
																					WHERE HRCHY_HDR_LVL_NBR <= 5
																						AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
				AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
				AND HRCHY_DTL_LEVEL = 5
				AND ROWNUM < 2) DISTRICT_NAME,
			(SELECT HRCHY_DTL_DESC
				FROM HIERARCHY_DETAIL
				WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                             FROM HIERARCHY_DESCRIPTION
                                                                            WHERE HRCHY_HDR_LVL_NBR <= 6
                                                                              AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
				AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
				AND HRCHY_DTL_LEVEL = 6
				AND ROWNUM < 2) CITY_MANAGER_NAME,  
        (SELECT EXTRACT(UPPER_LVL_VER_VALUE,'/attributes/upper_lvl_ver_desc[2]/Value/text()').getStringVal() 
          FROM HIERARCHY_DETAIL 				
          WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(H.HRCHY_DTL_CURR_LVL_VAL,1,(SELECT SUM(LVL_VALUE_SIZE)
                                                                             FROM HIERARCHY_DESCRIPTION
                                                                            WHERE HRCHY_HDR_LVL_NBR <= 5
                                                                              AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME))
          AND HRCHY_HDR_NAME = H.HRCHY_HDR_NAME
          AND HRCHY_DTL_LEVEL = 5
          AND ROWNUM < 2) DISTRICT_MANAGER_NAME ,                                                                     
       (SELECT 'A' 
				FROM POLLING PO 
				WHERE PO.COST_CENTER_CODE = C.COST_CENTER_CODE 
				  AND PO.CURRENT_FLAG ='Y'
				  AND POLLING_STATUS_CODE = 'P') AS ACTIVE_CD
	FROM COST_CENTER C,
		(SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, CITY, STATE_CODE, ZIP_CODE,COUNTY, COST_CENTER_CODE FROM ADDRESS_USA WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
		UNION ALL
		SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3, CITY, PROVINCE_CODE AS STATE_CODE,POSTAL_CODE AS ZIP_CODE, NULL,  COST_CENTER_CODE FROM ADDRESS_CAN WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
		UNION ALL
		SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3,  CITY, PROVINCE_CODE AS STATE_CODE, POSTAL_CODE AS ZIP_CODE, NULL,COST_CENTER_CODE FROM ADDRESS_MEX WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
		UNION ALL
		SELECT ADDRESS_LINE_1, ADDRESS_LINE_2, ADDRESS_LINE_3,  CITY, PROVINCE_CODE AS STATE_CODE, POSTAL_CODE AS ZIP_CODE, NULL,COST_CENTER_CODE FROM ADDRESS_OTHER WHERE ADDRESS_TYPE = 'M' AND EXPIRATION_DATE IS NULL
		) ADDRESS,
        (WITH T AS (SELECT HDESC.HRCHY_HDR_LVL_DESC DESCRIPTION,
                          HD.HRCHY_DTL_CURR_ROW_VAL COST_CENTER_CODE,
                          HD.HRCHY_HDR_NAME,
                          HD.HRCHY_DTL_EFF_DATE,
                          HD.HRCHY_DTL_EXP_DATE,
                          HD.HRCHY_DTL_CURR_LVL_VAL,
                          SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1 + (SELECT NVL(SUM(LVL_VALUE_SIZE), 0)
                                                                   FROM HIERARCHY_DESCRIPTION
                                                                  WHERE HRCHY_HDR_LVL_NBR < HDESC.HRCHY_HDR_LVL_NBR
                                                                   AND HRCHY_HDR_NAME = HD.HRCHY_HDR_NAME), HDESC.LVL_VALUE_SIZE) VAL
                     FROM HIERARCHY_DETAIL HD,
                          HIERARCHY_HEADER HH,
                          HIERARCHY_DESCRIPTION HDESC
                    WHERE HD.HRCHY_HDR_NAME  = HDESC.HRCHY_HDR_NAME
                      AND HD.HRCHY_HDR_NAME  = HH.HRCHY_HDR_NAME
                      AND HD.HRCHY_DTL_LEVEL = HH.HRCHY_HDR_LEVELS
                      AND NVL(HD.HRCHY_DTL_NEXT_LVL_VAL, '~~~') = '~~~'
                    ORDER BY HD.HRCHY_DTL_CURR_ROW_VAL, HDESC.HRCHY_HDR_LVL_NBR)
                   SELECT *
                     FROM T
                          PIVOT 
                          (MAX(VAL) FOR (DESCRIPTION) IN ('Division' AS DIVISION,
                                                          'Area' AS AREA,
                                                          'District' AS DISTRICT,
                                                          'City/Sales Manager' AS CITY_SALES_MANAGER
                                                          ))) H
	WHERE C.COST_CENTER_CODE = ADDRESS.COST_CENTER_CODE(+)
		AND C.COST_CENTER_CODE = H.COST_CENTER_CODE(+)
		AND H.HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
	ORDER BY C.COST_CENTER_CODE;