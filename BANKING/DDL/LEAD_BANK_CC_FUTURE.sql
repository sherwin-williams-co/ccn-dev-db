  CREATE TABLE LEAD_BANK_CC_FUTURE 
   (LEAD_BANK_ACCOUNT_NBR VARCHAR2(16 BYTE) NOT NULL ENABLE, 
	LEAD_STORE_NBR VARCHAR2(6 BYTE) NOT NULL ENABLE, 
	EFFECTIVE_DATE DATE NOT NULL ENABLE, 
	EXPIRATION_DATE DATE, 
	BANK_BRANCH_NBR VARCHAR2(8 BYTE), 
	BANK_TYPE_CODE VARCHAR2(1 BYTE) NOT NULL ENABLE, 
	UPDATE_DATE DATE NOT NULL ENABLE, 
	LAST_UPD_USER_ID VARCHAR2(8 BYTE) NOT NULL ENABLE, 
	FUTURE_ID NUMBER NOT NULL ENABLE, 
	CONSTRAINT LEAD_BANK_CC_FUTURE_PK PRIMARY KEY (LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR, FUTURE_ID), 
	 CONSTRAINT LEAD_BANK_CC_FUTURE_FK FOREIGN KEY (LEAD_BANK_ACCOUNT_NBR, FUTURE_ID)
	  REFERENCES BANK_ACCOUNT_FUTURE (BANK_ACCOUNT_NBR, FUTURE_ID) ENABLE
   );
  /