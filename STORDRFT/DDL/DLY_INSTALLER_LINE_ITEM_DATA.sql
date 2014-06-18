CREATE TABLE "STORDRFT"."DLY_INSTALLER_LINE_ITEM_DATA" 
   (	"TRANSACTION_SOURCE" VARCHAR2(1 BYTE), 
	"TRANSACTION_TYPE" VARCHAR2(1 BYTE), 
	"COST_CENTER_CODE" VARCHAR2(4 BYTE), 
	"CHECK_SERIAL_NUMBER" VARCHAR2(10 BYTE), 
	"PROCESS_DATE" VARCHAR2(7 BYTE), 
	"FILLER" VARCHAR2(16 BYTE), 
	"TRANSACTION_SEGMENT_TYPE" VARCHAR2(1 BYTE), 
	"ITEM_EXT_AMOUNT_SIGN" VARCHAR2(1 BYTE), 
	"ITEM_EXT_AMOUNT" VARCHAR2(9 BYTE), 
	"ORGNL_TERMINAL_NUMBER" VARCHAR2(5 BYTE), 
	"ORGNL_TRANSACTION_NUMBER" VARCHAR2(5 BYTE), 
	"ITEM_QUANTITY_SIGN" VARCHAR2(1 BYTE), 
	"ITEM_QUANTITY" VARCHAR2(7 BYTE), 
	"ITEM_PRICE_SIGN" VARCHAR2(1 BYTE), 
	"ITEM_PRICE" VARCHAR2(7 BYTE), 
	"GL_PRIME_ACCOUNT_NUMBER" VARCHAR2(4 BYTE), 
	"GL_SUB_ACCOUNT_NUMBER" VARCHAR2(3 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile "STORDRFT_LOAD_FILES":'DLY_INSTALLER_LINE_ITEM_DATA.bad'
        logfile "STORDRFT_LOAD_FILES":'DLY_INSTALLER_LINE_ITEM_DATA.log'
        discardfile "STORDRFT_LOAD_FILES":'DLY_INSTALLER_LINE_ITEM_DATA.dsc'
        LOAD WHEN ((40:40) = 'J')
        FIELDS(
                TRANSACTION_SOURCE        CHAR(1),
                TRANSACTION_TYPE          CHAR(1),
                COST_CENTER_CODE          CHAR(4),
                CHECK_SERIAL_NUMBER       CHAR(10),
                PROCESS_DATE              CHAR(7),
                FILLER                    CHAR(16),
                TRANSACTION_SEGMENT_TYPE  CHAR(1),
                ITEM_EXT_AMOUNT_SIGN      CHAR(1),
                ITEM_EXT_AMOUNT           CHAR(9),
                ORGNL_TERMINAL_NUMBER     CHAR(5),
                ORGNL_TRANSACTION_NUMBER  CHAR(5),
                ITEM_QUANTITY_SIGN        CHAR(1),
                ITEM_QUANTITY             CHAR(7),
                ITEM_PRICE_SIGN           CHAR(1),
                ITEM_PRICE                CHAR(7),
                GL_PRIME_ACCOUNT_NUMBER   CHAR(4),
                GL_SUB_ACCOUNT_NUMBER     CHAR(3)
                               )
              )
      LOCATION
       ( 'STORE_DRAFT.TXT'
       )
    );
