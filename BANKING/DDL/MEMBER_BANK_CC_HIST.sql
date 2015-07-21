   CREATE TABLE MEMBER_BANK_CC_HIST 
   (LEAD_BANK_ACCOUNT_NBR VARCHAR2(16) NOT NULL ENABLE, 
	LEAD_STORE_NBR VARCHAR2(6) NOT NULL ENABLE, 
	MEMBER_STORE_NBR VARCHAR2(6) NOT NULL ENABLE, 
	EFFECTIVE_DATE DATE NOT NULL ENABLE, 
	EXPIRATION_DATE DATE NOT NULL ENABLE, 
	MEMBER_BANK_ACCOUNT_NBR VARCHAR2(16),
	BANK_BRANCH_NBR VARCHAR2(8), 
	UPDATE_DATE DATE NOT NULL ENABLE, 
	LAST_UPD_USER_ID VARCHAR2(8) NOT NULL ENABLE
   );
   CREATE INDEX "BANKING"."MEMBER_BANK_CC_HIST_INDX" ON "BANKING"."MEMBER_BANK_CC_HIST" ("LEAD_BANK_ACCOUNT_NBR","LEAD_STORE_NBR","MEMBER_STORE_NBR","EFFECTIVE_DATE");
  /