
  CREATE TABLE HST_GENERAL_LEDGER_ACCOUNTS
   (	GL_ACCOUNT_NUMBER VARCHAR2(16 BYTE) NOT NULL ENABLE, 
	DESCRIPTION VARCHAR2(100 BYTE), 
	PROFIT_OR_LOSS VARCHAR2(5 BYTE), 
	EFFECTIVE_DATE DATE, 
	EXPIRATION_DATE DATE DEFAULT NULL, 
	CREATED_BY VARCHAR2(10 BYTE), 
	HST_LOAD_DATE DATE
   );
   
   CREATE TABLE HST_PRGM_GL_ACCNT_RLTN_DTLS
   (	GL_PS_ACCOUNT_NUMBER VARCHAR2(16 BYTE) NOT NULL ENABLE, 
	PROGRAM_NAME VARCHAR2(100 BYTE), 
	SORTED_SEQUENCE NUMBER, 
	SHARED VARCHAR2(5 BYTE), 
	EFFECTIVE_DATE DATE, 
	EXPIRATION_DATE DATE DEFAULT NULL, 
	CREATED_BY VARCHAR2(10 BYTE), 
	HST_LOAD_DATE DATE
   );
   
    CREATE TABLE HST_PROGRAMS
   (	PROGRAM_NAME VARCHAR2(100 BYTE) NOT NULL ENABLE, 
	EFFECTIVE_DATE DATE, 
	EXPIRATION_DATE DATE DEFAULT NULL, 
	CREATED_BY VARCHAR2(10 BYTE), 
	HST_LOAD_DATE DATE
   );

