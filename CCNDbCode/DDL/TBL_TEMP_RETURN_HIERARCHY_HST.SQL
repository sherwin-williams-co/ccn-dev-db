
  CREATE TABLE TEMP_RETURN_HIERARCHY_HST 
   (	ID NUMBER, 
	LEV VARCHAR2(100 BYTE), 
	HRCHY_HDR_NAME VARCHAR2(100 BYTE), 
	HRCHY_DTL_LEVEL VARCHAR2(2 BYTE), 
	HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000 BYTE), 
	HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000 BYTE), 
	HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000 BYTE), 
	HRCHY_DTL_EFF_DATE DATE, 
	HRCHY_DTL_EXP_DATE DATE, 
	HRCHY_DTL_DESC VARCHAR2(100 BYTE), 
	HRCHY_DTL_CURR_ROW_VAL VARCHAR2(100 BYTE), 
	UPPER_LVL_VER_VALUE CLOB
   );
