/**********************************************************
Changed : 11/03/2015 jxc517 CCN Project....
          Modified the table to add BANK_DEP_BAG_FTR_ID column
          This column is used to track multiple orders in a current/future tab
          Modified table to change some VARCHAR2(*) fields to NUMBER
**********************************************************/
DROP TABLE BANK_DEP_BAG_TICKORD_HIST;
  CREATE TABLE BANK_DEP_BAG_TICKORD_HIST
   (	BANK_ACCOUNT_NBR           VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	COST_CENTER_CODE           VARCHAR2(6 BYTE) NOT NULL ENABLE, 
	BANK_DEP_BAG_FTR_ID        NUMBER NOT NULL ENABLE,
	DEPOSIT_BAG_ORDER_PRIORITY NUMBER, 
	DEPOSIT_BAG_ORDER_STATUS   VARCHAR2(1 BYTE), 
	DEPOSIT_BAG_ORDER_SEQ_NBR  NUMBER, 
	EFFECTIVE_DATE             DATE NOT NULL ENABLE, 
	EXPIRATION_DATE            DATE, 
	LAST_MAINTENANCE_DATE      DATE NOT NULL ENABLE, 
	LAST_MAINT_USER_ID         VARCHAR2(6 BYTE) NOT NULL ENABLE, 
	ORDER_DATE                 DATE,
	EXTRACTED_USER_ID          VARCHAR2(8 BYTE)
   );

