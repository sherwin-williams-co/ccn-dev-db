BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE DLY_CSTMR_SALES_TAX';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

  CREATE TABLE DLY_CSTMR_SALES_TAX 
   (	COST_CENTER_CODE VARCHAR2(4 BYTE), 
	TERMINAL_NUMBER VARCHAR2(5 BYTE), 
	TRANSACTION_NUMBER VARCHAR2(5 BYTE), 
	SORT_FORCE VARCHAR2(3 BYTE), 
	SEGMENT_CODE VARCHAR2(2 BYTE), 
	SUB_SEGMENT_CODE VARCHAR2(2 BYTE), 
	FILLER VARCHAR2(5 BYTE), 
	SALES_TAX_CORR_INDICATOR VARCHAR2(1 BYTE), 
	SALES_TAX_COLL_AMOUNT_SIGN VARCHAR2(1 BYTE), 
	SALES_TAX_COLL_AMOUNT VARCHAR2(7 BYTE), 
	SALES_TAX_INDICATOR VARCHAR2(1 BYTE), 
	SALES_TAX_RATE_SIGN VARCHAR2(1 BYTE), 
	SALES_TAX_RATE VARCHAR2(5 BYTE), 
	SALES_TAX_CODE VARCHAR2(5 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY STORDRFT_LOAD_FILES
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_LOAD_FILES:'DLY_CSTMR_SALES_TAX.bad'
        logfile STORDRFT_LOAD_FILES:'DLY_CSTMR_SALES_TAX.log'
        discardfile STORDRFT_LOAD_FILES:'DLY_CSTMR_SALES_TAX.dsc'
        LOAD WHEN ((18:19) = '04')
        FIELDS(
                COST_CENTER_CODE         CHAR(4),
                TERMINAL_NUMBER          CHAR(5),
                TRANSACTION_NUMBER       CHAR(5),
                SORT_FORCE               CHAR(3),
                SEGMENT_CODE             CHAR(2),
                SUB_SEGMENT_CODE         CHAR(2),
                FILLER                   CHAR(5),
                SALES_TAX_CORR_INDICATOR CHAR(1),
                SALES_TAX_COLL_AMOUNT_SIGN CHAR(1),
                SALES_TAX_COLL_AMOUNT    CHAR(7),
                SALES_TAX_INDICATOR      CHAR(1),
                SALES_TAX_RATE_SIGN      CHAR(1),
                SALES_TAX_RATE           CHAR(5),
                SALES_TAX_CODE           CHAR(5)
                               )
              )
      LOCATION
       ( 'CUSTOMER_LABOR.TXT'
       )
    );
