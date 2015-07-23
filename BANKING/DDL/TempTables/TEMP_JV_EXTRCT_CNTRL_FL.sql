CREATE TABLE TEMP_JV_EXTRCT_CNTRL_FL 
   (	BANK_ACCOUNT_NBR VARCHAR2(17), 
	COST_CENTER_CODE VARCHAR2(4), 
	CENTURY VARCHAR2(1), 
	YEAR VARCHAR2(2), 
	MONTH VARCHAR2(2), 
	DAY VARCHAR2(2), 
	TRAN_SEQNUM VARCHAR2(9), 
	TCODE VARCHAR2(4), 
	AMOUNT VARCHAR2(12), 
	JV_TYPE VARCHAR2(3), 
	CFA_SIGN VARCHAR2(1), 
	REFEED_TCODE VARCHAR2(4), 
	DR_DIV VARCHAR2(3), 
	DR_PRIME VARCHAR2(4), 
	DR_SUB VARCHAR2(3), 
	DR_CC VARCHAR2(4), 
	DR_PROJ VARCHAR2(4), 
	DR_OFFSET_CDE VARCHAR2(1), 
	CR_DIV VARCHAR2(3), 
	CR_PRIME VARCHAR2(4), 
	CR_SUB VARCHAR2(3), 
	CR_CC VARCHAR2(4), 
	CR_PROJ VARCHAR2(4), 
	CR_OFFSET_CDE VARCHAR2(1), 
	FILLER VARCHAR2(1)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY BANKING_LOAD_FILES
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile BANKING_LOAD_FILES:'TEMP_JV_EXTRCT_CNTRL_FL.bad'
        logfile BANKING_LOAD_FILES:'TEMP_JV_EXTRCT_CNTRL_FL.log'
        discardfile BANKING_LOAD_FILES:'TEMP_JV_EXTRCT_CNTRL_FL.dsc'
        FIELDS( BANK_ACCOUNT_NBR  CHAR(17),
                COST_CENTER_CODE  CHAR(4),
                CENTURY           CHAR(1),
                "YEAR"            CHAR(2),
                "MONTH"           CHAR(2),
                "DAY"             CHAR(2),
                TRAN_SEQNUM       CHAR(9),
                TCODE             CHAR(4),
                AMOUNT            CHAR(12),
                JV_TYPE           CHAR(3),
                CFA_SIGN          CHAR(1),
                REFEED_TCODE      CHAR(4),
                DR_DIV            CHAR(3),
                DR_PRIME          CHAR(4),
                DR_SUB            CHAR(3),
                DR_CC             CHAR(4),
                DR_PROJ           CHAR(4),
                DR_OFFSET_CDE     CHAR(1),
                CR_DIV            CHAR(3),
                CR_PRIME          CHAR(4),
                CR_SUB            CHAR(3),
                CR_CC             CHAR(4),
                CR_PROJ           CHAR(4),
                CR_OFFSET_CDE     CHAR(1),
                FILLER            CHAR(1))
          )
      LOCATION
       ( 'SRA13510.TXT'
       )
    );
	/