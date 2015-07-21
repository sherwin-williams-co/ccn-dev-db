  CREATE TABLE BANK_ACCOUNT_T 
   (BANK_ACCOUNT_NBR VARCHAR2(16), 
	EFFECTIVE_DATE VARCHAR2(8), 
	EXPIRATION_DATE VARCHAR2(8), 
	BANK_NAME VARCHAR2(30), 
	BOOK_KEEPER_NBR VARCHAR2(2), 
	STATEMENT_TYPE VARCHAR2(2), 
	BANK_AUTO_RECON_IND VARCHAR2(1), 
	RECON_START_DATE VARCHAR2(8), 
	RECON_BANK_ACCOUNT_NBR VARCHAR2(16), 
	JV_BOOK_KEEPER_REF VARCHAR2(6), 
	JV_BANK_SHORT_NAME VARCHAR2(6), 
	IDI_BOOKKEEPER_REF VARCHAR2(6), 
	IDI_BANK_SHORT_NAME VARCHAR2(6), 
	ROUTING_NBR VARCHAR2(9)
   ) ;
 /
  