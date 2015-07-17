  CREATE TABLE TEMP_BANK_PRCCNTR 
   (PRICE_DIST_NBR VARCHAR2(5), 
	COST_CENTER_CODE VARCHAR2(6), 
	EFFECTIVE_DATE VARCHAR2(8), 
	EXPIRATION_DATE VARCHAR2(8), 
	LAST_MAINT_AUTH_ID VARCHAR2(6), 
	FILLER VARCHAR2(1)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "BANKING_LOAD_FILES"
	  ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile BANKING_LOAD_FILES:'TEMP_BANK_PRCCNTR.bad'
        logfile BANKING_LOAD_FILES:'TEMP_BANK_PRCCNTR.log'
        discardfile BANKING_LOAD_FILES:'TEMP_BANK_PRCCNTR.dsc'
        FIELDS MISSING FIELD VALUES ARE NULL
      (
        PRICE_DIST_NBR CHAR(5),
        COST_CENTER_CODE   CHAR(6), 
        EFFECTIVE_DATE   CHAR(8), 
        EXPIRATION_DATE  CHAR(8), 
        LAST_MAINT_AUTH_ID CHAR(6),
        FILLER CHAR(1)
       )
             )
      LOCATION
       ( 'CCN99CTR_PRCCNTR.TXT'
       )
    );

	/