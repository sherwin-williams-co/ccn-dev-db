/***************************************************************
Description : Table BATCH_JOB for customer deposits
Created  : 09/28/2017 sxh487 CCN Project Team.....
***************************************************************/
CREATE TABLE BATCH_JOB 
   (	BATCH_JOB_NAME VARCHAR2(20) NOT NULL ENABLE, 
	BATCH_JOB_NUMBER NUMBER(12,0) NOT NULL ENABLE, 
	BATCH_JOB_STATUS VARCHAR2(20), 
	BATCH_JOB_START_DATE DATE, 
	BATCH_JOB_END_DATE DATE, 
	BATCH_JOB_LAST_RUN_DATE DATE, 
	TRANS_STATUS VARCHAR2(20), 
	SERVER_NAME VARCHAR2(20), 
	LOG_FILE VARCHAR2(500)
   );