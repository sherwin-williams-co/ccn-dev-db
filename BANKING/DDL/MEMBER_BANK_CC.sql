  CREATE TABLE MEMBER_BANK_CC 
   (LEAD_BANK_ACCOUNT_NBR VARCHAR2(16 BYTE) NOT NULL ENABLE, 
	LEAD_STORE_NBR VARCHAR2(6 BYTE) NOT NULL ENABLE, 
	MEMBER_STORE_NBR VARCHAR2(6 BYTE) NOT NULL ENABLE, 
	EFFECTIVE_DATE DATE NOT NULL ENABLE, 
	EXPIRATION_DATE DATE, 
	MEMBER_BANK_ACCOUNT_NBR VARCHAR2(16 BYTE), 
	BANK_BRANCH_NBR VARCHAR2(8 BYTE), 
	UPDATE_DATE DATE NOT NULL ENABLE, 
	LAST_UPD_USER_ID VARCHAR2(8 BYTE) NOT NULL ENABLE, 
    CONSTRAINT MEMBER_BANK_CC_PK PRIMARY KEY (LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR, MEMBER_STORE_NBR), 
	 CONSTRAINT MEMBER_BANK_CC_FK FOREIGN KEY (LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR)
	  REFERENCES LEAD_BANK_CC (LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR) ENABLE
   );
  /