BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TEMP_SDL_CC_ACCOUNT';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE TEMP_SDL_CC_ACCOUNT 
   (	COST_CENTER_CODE VARCHAR2(6 BYTE), 
	TRANSACTION_DATE VARCHAR2(8 BYTE), 
	TERM_NUMBER VARCHAR2(5 BYTE), 
	TRANSACTION_NUMBER VARCHAR2(5 BYTE), 
	SEGMENT_CODE VARCHAR2(2 BYTE), 
	SUB_SEGMENT_CODE VARCHAR2(2 BYTE), 
	PAY_DISC_CODE VARCHAR2(1 BYTE), 
	TRANSACTOIN_TOTAL_AMT VARCHAR2(7 BYTE), 
	TRAN_TOTAL_AMT_SGN VARCHAR2(1 BYTE), 
	POS_LINE_COUNT VARCHAR2(5 BYTE), 
	PAY_AMOUNT VARCHAR2(7 BYTE), 
	PAY_AMOUNT_SGN VARCHAR2(1 BYTE), 
	PAY_DISCOUNT VARCHAR2(7 BYTE), 
	PAY_DISCOUNT_SGN VARCHAR2(1 BYTE), 
	SALES_DISCOUNT_AMT VARCHAR2(7 BYTE), 
	SALES_DISCOUNT_AMT_SGN VARCHAR2(1 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY STORDRFT_LOAD_FILES
      ACCESS PARAMETERS
      ( RECORDS FIXED 68
        badfile STORDRFT_LOAD_FILES:'TEMP_SDL_CC_ACCOUNT.bad'
        logfile STORDRFT_LOAD_FILES:'TEMP_SDL_CC_ACCOUNT.log'
        discardfile STORDRFT_LOAD_FILES:'TEMP_SDL_CC_ACCOUNT.dsc'
        FIELDS(
                COST_CENTER_CODE         CHAR(6),
                TRANSACTION_DATE         CHAR(8),
                TERM_NUMBER              CHAR(5),
                TRANSACTION_NUMBER       CHAR(5),
                SEGMENT_CODE             CHAR(2),
                SUB_SEGMENT_CODE         CHAR(2),
                PAY_DISC_CODE            CHAR(1),
                TRANSACTOIN_TOTAL_AMT    CHAR(7),
                TRAN_TOTAL_AMT_SGN       CHAR(1),
                POS_LINE_COUNT           CHAR(5),
                PAY_AMOUNT               CHAR(7),
                PAY_AMOUNT_SGN           CHAR(1),
                PAY_DISCOUNT             CHAR(7),
                PAY_DISCOUNT_SGN         CHAR(1),
                SALES_DISCOUNT_AMT       CHAR(7),
                SALES_DISCOUNT_AMT_SGN   CHAR(1)
                               )
                  )
      LOCATION
       ( 'CCN99CTR_LCTRCNT.TXT'
       )
    );
