/*
     Created: 04/30/2018 sxh487 CCN Project Team..
     This table is for maintaining audit history for CUSTOMER_DEPOSIT_HEADER
*/
CREATE TABLE CUSTOMER_DEPOSIT_HEADER_HST 
   (	CUSTOMER_ACCOUNT_NUMBER     VARCHAR2(9), 
	CUSTOMER_NAME               VARCHAR2(255), 
	BILLCONTACT                 VARCHAR2(30), 
	BILLNM                      VARCHAR2(50), 
	BILLADDR1                   VARCHAR2(50), 
	BILLADDR2                   VARCHAR2(50), 
	BILLCITY                    VARCHAR2(20), 
	BILLZIP                     VARCHAR2(10), 
	BILLPHONE                   VARCHAR2(10), 
	RLS_RUN_CYCLE               NUMBER, 
	LOAD_DATE                   DATE, 
	CLEARED_REASON              VARCHAR2(100), 
	CLOSED_DATE                 DATE, 
	NOTES                       VARCHAR2(4000), 
	REFERENCE_NUMBER            VARCHAR2(5), 
	HIST_LOAD_DT                DATE
);
