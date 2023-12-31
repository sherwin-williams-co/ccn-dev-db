/*****************************************************************************
 Created: 05/25/2012 sxh487 CCN Project.... 
 This table is used to store all the error records for PRICE_DISTRICT
 hierarchy
**************************************************************************/
CREATE TABLE HIERARCHY_ERROR_LOG 
   (	HIER_ERROR_ID NUMBER NOT NULL ENABLE, 
	HIERARCHY_NAME VARCHAR2(100), 
	COST_CENTER VARCHAR2(6) NOT NULL ENABLE, 
	HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000), 
	ERROR_CODE VARCHAR2(9), 
	ERROR_DATE DATE NOT NULL ENABLE, 
	MODULE VARCHAR2(65) NOT NULL ENABLE, 
	ERROR_TEXT VARCHAR2(500), 
	EXCEPTION_FLAG VARCHAR2(1), 
	CONSTRAINT HIER_ERROR_LOG_PK PRIMARY KEY (HIER_ERROR_ID, COST_CENTER, HIERARCHY_NAME, ERROR_DATE, MODULE)
   );

