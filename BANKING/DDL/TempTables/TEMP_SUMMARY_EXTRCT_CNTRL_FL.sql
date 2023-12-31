CREATE TABLE TEMP_SUMMARY_EXTRCT_CNTRL_FL 
   (	COST_CENTER_CODE VARCHAR2(4), 
	CENTURY VARCHAR2(1), 
	"YEAR" VARCHAR2(2), 
	"MONTH" VARCHAR2(2), 
	"DAY" VARCHAR2(2), 
	BANK_DEP_AMT VARCHAR2(9), 
	FILLER VARCHAR2(1), 
	BANK_ACCOUNT_NBR VARCHAR2(17)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY BANKING_LOAD_FILES
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile BANKING_LOAD_FILES:'TEMP_SUMMARY_EXTRCT_CNTRL_FL.bad'
        logfile BANKING_LOAD_FILES:'TEMP_SUMMARY_EXTRCT_CNTRL_FL.log'
        discardfile BANKING_LOAD_FILES:'TEMP_SUMMARY_EXTRCT_CNTRL_FL.dsc'
        FIELDS( COST_CENTER_CODE CHAR(4),
                CENTURY          CHAR(1),
                "YEAR"           CHAR(2),
                "MONTH"          CHAR(2),
                "DAY"            CHAR(2),
                BANK_DEP_AMT     CHAR(9),
                FILLER           CHAR(1),
                BANK_ACCOUNT_NBR CHAR(17) )
          )
      LOCATION
       ( 'SRA10510.TXT'
       )
    );
	/