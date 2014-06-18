CREATE TABLE "STORDRFT"."DLY_BANK_PAID_DATA" 
   (	"TRANSACTION_SOURCE" VARCHAR2(1 BYTE), 
	"TRANSACTION_TYPE" VARCHAR2(1 BYTE), 
	"COST_CENTER_CODE" VARCHAR2(4 BYTE), 
	"CHECK_SERIAL_NUMBER" VARCHAR2(10 BYTE), 
	"PROCESS_DATE" VARCHAR2(7 BYTE), 
	"FILLER" VARCHAR2(16 BYTE), 
	"TRANSACTION_SEGMENT_TYPE" VARCHAR2(1 BYTE), 
	"PAID_DATE" VARCHAR2(7 BYTE), 
	"STOP_PAY_DATE" VARCHAR2(7 BYTE), 
	"STOP_PAY_REMOVE_DATE" VARCHAR2(7 BYTE), 
	"VOID_DATE" VARCHAR2(7 BYTE), 
	"BANK_PAID_AMOUNT_SIGN" VARCHAR2(1 BYTE), 
	"BANK_PAID_AMOUNT" VARCHAR2(9 BYTE), 
	"BANK_NUMBER" VARCHAR2(3 BYTE), 
	"BANK_ACCOUNT_NUMBER" VARCHAR2(16 BYTE), 
	"CPCS_NUMBER" VARCHAR2(9 BYTE), 
	"FILLER1" VARCHAR2(8 BYTE), 
	"PAYEE_INFO" VARCHAR2(16 BYTE), 
	"ADDITIONAL_INFO" VARCHAR2(16 BYTE), 
	"FS_ACCOUNT_NUMBER1" VARCHAR2(9 BYTE), 
	"FS_AMOUNT_SIGN1" VARCHAR2(1 BYTE), 
	"FS_AMOUNT1" VARCHAR2(9 BYTE), 
	"FS_ACCOUNT_NUMBER2" VARCHAR2(9 BYTE), 
	"FS_AMOUNT_SIGN2" VARCHAR2(1 BYTE), 
	"FS_AMOUNT2" VARCHAR2(9 BYTE), 
	"FS_ACCOUNT_NUMBER3" VARCHAR2(9 BYTE), 
	"FS_AMOUNT_SIGN3" VARCHAR2(1 BYTE), 
	"FS_AMOUNT3" VARCHAR2(9 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile "STORDRFT_LOAD_FILES":'DLY_BANK_PAID_DATA.bad'
        logfile "STORDRFT_LOAD_FILES":'DLY_BANK_PAID_DATA.log'
        discardfile "STORDRFT_LOAD_FILES":'DLY_BANK_PAID_DATA.dsc'
        LOAD WHEN ((40:40) = 'P' OR (40:40) = 'R' OR (40:40) = 'S' OR (40:40) = 'V')
        FIELDS(
                TRANSACTION_SOURCE        CHAR(1),
                TRANSACTION_TYPE          CHAR(1),
                COST_CENTER_CODE          CHAR(4),
                CHECK_SERIAL_NUMBER       CHAR(10),
                PROCESS_DATE              CHAR(7),
                FILLER                    CHAR(16),
                TRANSACTION_SEGMENT_TYPE  CHAR(1),
                PAID_DATE                 CHAR(7),
                STOP_PAY_DATE             CHAR(7),
                STOP_PAY_REMOVE_DATE      CHAR(7),
                VOID_DATE                 CHAR(7),
                BANK_PAID_AMOUNT_SIGN     CHAR(1),
                BANK_PAID_AMOUNT          CHAR(9),
                BANK_NUMBER               CHAR(3),
                BANK_ACCOUNT_NUMBER       CHAR(16),
                CPCS_NUMBER               CHAR(9),
                FILLER1                   CHAR(8),
                PAYEE_INFO                CHAR(16),
                ADDITIONAL_INFO           CHAR(16),
                FS_ACCOUNT_NUMBER1        CHAR(9),
                FS_AMOUNT_SIGN1           CHAR(1),
                FS_AMOUNT1                CHAR(9),
                FS_ACCOUNT_NUMBER2        CHAR(9),
                FS_AMOUNT_SIGN2           CHAR(1),
                FS_AMOUNT2                CHAR(9),
                FS_ACCOUNT_NUMBER3        CHAR(9),
                FS_AMOUNT_SIGN3           CHAR(1),
                FS_AMOUNT3                CHAR(9)
                               )
              )
      LOCATION
       ( 'STORE_DRAFT.TXT'
       )
    );
