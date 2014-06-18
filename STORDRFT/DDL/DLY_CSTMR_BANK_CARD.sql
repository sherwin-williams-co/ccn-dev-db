CREATE TABLE "STORDRFT"."DLY_CSTMR_BANK_CARD" 
   (	"COST_CENTER_CODE" VARCHAR2(4 BYTE), 
	"TERMINAL_NUMBER" VARCHAR2(5 BYTE), 
	"TRANSACTION_NUMBER" VARCHAR2(5 BYTE), 
	"SORT_FORCE" VARCHAR2(3 BYTE), 
	"SEGMENT_CODE" VARCHAR2(2 BYTE), 
	"SUB_SEGMENT_CODE" VARCHAR2(2 BYTE), 
	"FILLER" VARCHAR2(5 BYTE), 
	"BANK_CARD_ACCOUNT_NUMBER" VARCHAR2(16 BYTE), 
	"BANK_AUTH" VARCHAR2(9 BYTE), 
	"BANK_AMOUNT_SIGN" VARCHAR2(1 BYTE), 
	"BANK_AMOUNT" VARCHAR2(9 BYTE), 
	"BANK_TYPE" VARCHAR2(1 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile "STORDRFT_LOAD_FILES":'DLY_CSTMR_BANK_CARD.bad'
        logfile "STORDRFT_LOAD_FILES":'DLY_CSTMR_BANK_CARD.log'
        discardfile "STORDRFT_LOAD_FILES":'DLY_CSTMR_BANK_CARD.dsc'
        LOAD WHEN ((18:19) = '17')
        FIELDS(
                COST_CENTER_CODE         CHAR(4),
                TERMINAL_NUMBER          CHAR(5),
                TRANSACTION_NUMBER       CHAR(5),
                SORT_FORCE               CHAR(3),
                SEGMENT_CODE             CHAR(2),
                SUB_SEGMENT_CODE         CHAR(2),
                FILLER                   CHAR(5),
                BANK_CARD_ACCOUNT_NUMBER CHAR(16),
                BANK_AUTH                CHAR(9),
                BANK_AMOUNT_SIGN         CHAR(1),
                BANK_AMOUNT              CHAR(9),
                BANK_TYPE                CHAR(1)
                               )
              )
      LOCATION
       ( 'CUSTOMER_LABOR.TXT'
       )
    );
