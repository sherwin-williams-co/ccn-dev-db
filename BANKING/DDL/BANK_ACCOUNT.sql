
 CREATE TABLE BANK_ACCOUNT 
   (BANK_ACCOUNT_NBR VARCHAR2(16) NOT NULL ENABLE, 
	EFFECTIVE_DATE DATE NOT NULL ENABLE, 
	EXPIRATION_DATE DATE, 
	BANK_NAME VARCHAR2(30), 
	BOOK_KEEPER_NBR VARCHAR2(2), 
	BANK_AUTO_RECON_IND VARCHAR2(1), 
	RECON_START_DATE DATE, 
	RECON_BANK_ACCOUNT_NBR VARCHAR2(16), 
	JV_BOOK_KEEPER_REF VARCHAR2(6), 
	JV_BANK_SHORT_NAME VARCHAR2(6), 
	IDI_BOOKKEEPER_REF VARCHAR2(6), 
	IDI_BANK_SHORT_NAME VARCHAR2(6), 
	ROUTING_NBR VARCHAR2(9), 
	UPDATE_DATE DATE NOT NULL ENABLE, 
	LAST_UPD_USER_ID VARCHAR2(8 BYTE) NOT NULL ENABLE, 
	 CONSTRAINT BANK_ACCOUNT_PK PRIMARY KEY (BANK_ACCOUNT_NBR)
   );
  /