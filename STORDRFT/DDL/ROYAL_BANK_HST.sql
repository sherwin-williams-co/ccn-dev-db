/*******************************************************************************
This table is created to store Royal bank Report history records
Created  : 11/20/2917 sxh487 CCN Project.
*******************************************************************************/
CREATE TABLE ROYAL_BANK_HIST 
   (	TRANSIT_NUMBER VARCHAR2(5), 
	ACCOUNT_NUMBER VARCHAR2(11), 
	TRANSIT_TYPE VARCHAR2(2), 
	SUB_CODE VARCHAR2(2), 
	SERIAL_NUMBER VARCHAR2(11), 
	AMOUNT VARCHAR2(11), 
	STATUS_FLAG VARCHAR2(1), 
	ISSUE_DATE VARCHAR2(11), 
	PAID_DATE VARCHAR2(11), 
	TRANS_CODE VARCHAR2(4), 
	CHECK_NUMBER VARCHAR2(11), 
	STATUS VARCHAR2(2), 
	TOLRNC_AMOUNT VARCHAR2(3), 
	DESCRIPTION VARCHAR2(32), 
	DB_AMOUNT VARCHAR2(15), 
	LOAD_DATE DATE, 
	RUN_NBR NUMBER
   );