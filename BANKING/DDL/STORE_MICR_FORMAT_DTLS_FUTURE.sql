  CREATE TABLE STORE_MICR_FORMAT_DTLS_FUTURE 
   (	BANK_ACCOUNT_NBR VARCHAR2(20) NOT NULL ENABLE,
	MICR_FORMAT_ID NUMBER NOT NULL ENABLE,
	COST_CENTER_CODE VARCHAR2(6) NOT NULL ENABLE,
	MICR_COST_CNTR VARCHAR2(8),
	MICR_ROUTING_NBR VARCHAR2(11),
	MICR_FORMAT_ACCT_NBR VARCHAR2(17),
	EFFECTIVE_DATE DATE NOT NULL ENABLE,
	EXPIRATION_DATE DATE,
	FUTURE_ID NUMBER NOT NULL ENABLE,
	CONSTRAINT STORE_MICR_FORMAT_DTLS_FTR_PK PRIMARY KEY (COST_CENTER_CODE,FUTURE_ID) ENABLE,
	CONSTRAINT STORE_MICR_FORMAT_DTLS_FTR_FK FOREIGN KEY (MICR_FORMAT_ID,BANK_ACCOUNT_NBR,FUTURE_ID)
	 REFERENCES BANKING.BANK_MICR_FORMAT_FUTURE (MICR_FORMAT_ID,BANK_ACCOUNT_NBR,FUTURE_ID) ENABLE
   );
/