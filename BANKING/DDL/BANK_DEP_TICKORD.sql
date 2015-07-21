  CREATE TABLE BANK_DEP_TICKORD 
   (BANK_ACCOUNT_NBR VARCHAR2(16) NOT NULL ENABLE, 
	COST_CENTER_CODE VARCHAR2(6) NOT NULL ENABLE, 
	DEPOSIT_ORDER_PRIORITY VARCHAR2(3), 
	DEPOSIT_ORDER_STATUS VARCHAR2(1), 
	COST_CENTER VARCHAR2(4), 
	DEPOSIT_ORDER_SEQ_NBR VARCHAR2(3), 
	EFFECTIVE_DATE DATE NOT NULL ENABLE, 
	EXPIRATION_DATE DATE, 
	LAST_MAINTENANCE_DATE DATE, 
	LAST_MAINT_USER_ID VARCHAR2(6), 
	EXTRACT_DATE DATE, 
	EXTRACTED_USER_ID VARCHAR2(8), 
	 CONSTRAINT BANK_DEP_TICKORD_PK PRIMARY KEY (COST_CENTER_CODE), 
	 CONSTRAINT BANK_DEP_TICKORD_FK1 FOREIGN KEY (BANK_ACCOUNT_NBR, COST_CENTER_CODE)
	  REFERENCES BANKING.BANK_DEP_TICK (BANK_ACCOUNT_NBR, COST_CENTER_CODE) ENABLE
   );
  /