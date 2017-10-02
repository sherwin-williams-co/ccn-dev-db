/***************************************************************
Description : Table POS_CSTMR_DEP_LOAD_STATUS for customer deposits
Created  : 09/28/2017 sxh487 CCN Project Team.....
***************************************************************/
CREATE TABLE POS_CSTMR_DEP_LOAD_STATUS 
   (	RLS_RUN_CYCLE NUMBER NOT NULL ENABLE, 
	END_TS TIMESTAMP (6) WITH TIME ZONE, 
	START_TS TIMESTAMP (6) WITH TIME ZONE, 
	ORIGIN_DB VARCHAR2(50), 
	STATUS_CODE VARCHAR2(1), 
	RECORD_COUNT NUMBER, 
	CONTROL_TOTAL NUMBER, 
	LOAD_DATE DATE
   );