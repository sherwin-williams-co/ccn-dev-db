/*
     Created: 05/07/2018 sxh487 CCN Project Team..
     This table stores the history for customer_deposit_details
     during the closing of CUSTOMER_ACCOUNT_NUMBER
*/
CREATE TABLE CUST_DEP_DET_CLOSING_HIST 
   (	
        COST_CENTER_CODE        VARCHAR2(6), 
	TRANSACTION_DATE        DATE, 
	TERMINAL_NUMBER         VARCHAR2(5), 
	TRANSACTION_NUMBER      VARCHAR2(5), 
	TRANSACTION_GUID        RAW(16), 
	CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9), 
	POS_TRANSACTION_CODE    VARCHAR2(2), 
	TRAN_TIMESTAMP          TIMESTAMP (6), 
	TRANSACTION_TYPE        VARCHAR2(50), 
	TOTAL_SALES             NUMBER, 
	CUSTOMER_NET_BALANCE    NUMBER, 
	LOAD_DATE               DATE, 
	RLS_RUN_CYCLE           NUMBER, 
	ADJUSTED_DATE           DATE, 
	REFERENCE_NUMBER        VARCHAR2(5), 
	CLEARED_REASON          VARCHAR2(1000), 
	NOTES                   VARCHAR2(4000), 
	CLOSED_DATE             DATE, 
	GL_DIVISION             VARCHAR2(20), 
	DET_CLSNG_HST_DT        DATE,
	CONSTRAINT CUST_DEP_DET_CLOSING_HIST_PK PRIMARY KEY (CUSTOMER_ACCOUNT_NUMBER, CLOSED_DATE)
);