/***************************************************************
Description : Table CUST_DEP_CCN_ACCUMS_T for customer deposits
Created  : 09/28/2017 sxh487 CCN Project Team.....
***************************************************************/
CREATE TABLE CUST_DEP_CCN_ACCUMS_T 
   (	TRANSACTION_GUID RAW(16), 
	AMT NUMBER, 
	ACCUM_ID VARCHAR2(20), 
	RLS_RUN_CYCLE NUMBER, 
	LOAD_DATE DATE
   );
   
   CREATE INDEX CUST_DEP_ACCUMS_T_IND ON CUST_DEP_CCN_ACCUMS_T (TRANSACTION_GUID, ACCUM_ID)