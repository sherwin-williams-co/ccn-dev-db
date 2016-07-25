/*****************************************************************************************
Created: 07/25/2016 AXK326
         This script contains DDL's related to following external tables:
         1. FF_ISSUE_CHANGE_DATA_TMP
         2. FF_INSTLR_LN_ITEM_DATA_TMP
         3. FF_DISBRSMT_LINE_ITEM_DATA_TMP
         4. FF_CUSTOMER_TMP
         5. FF_CUSTOMER_DETAILS_TMP
         6. FF_CSTMR_SALES_TAX_TMP
         7. FF_CSTMR_LINE_ITEM_DATA_TMP
         8. FF_CSTMR_FORM_OF_PAY_TMP
         9. FF_CSTMR_BANK_CARD_TMP
         10.FF_BANK_PAID_DATA
*****************************************************************************************/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE FF_ISSUE_CHANGE_DATA_TMP';
    EXECUTE IMMEDIATE 'DROP TABLE FF_INSTLR_LN_ITEM_DATA_TMP';
    EXECUTE IMMEDIATE 'DROP TABLE FF_DISBRSMT_LINE_ITEM_DATA_TMP';
    EXECUTE IMMEDIATE 'DROP TABLE FF_CUSTOMER_TMP';
    EXECUTE IMMEDIATE 'DROP TABLE FF_CUSTOMER_DETAILS_TMP';
    EXECUTE IMMEDIATE 'DROP TABLE FF_CSTMR_SALES_TAX_TMP';
    EXECUTE IMMEDIATE 'DROP TABLE FF_CSTMR_LINE_ITEM_DATA_TMP';
    EXECUTE IMMEDIATE 'DROP TABLE FF_CSTMR_FORM_OF_PAY_TMP';
    EXECUTE IMMEDIATE 'DROP TABLE FF_CSTMR_BANK_CARD_TMP';
    EXECUTE IMMEDIATE 'DROP TABLE FF_BANK_PAID_DATA';
    EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE FF_ISSUE_CHANGE_DATA_TMP
(    TRANSACTION_SOURCE VARCHAR2(1),
     TRANSACTION_TYPE VARCHAR2(1),
     COST_CENTER_CODE VARCHAR2(4),
     CHECK_SERIAL_NUMBER VARCHAR2(10),
     DRAFT_NUMBER VARCHAR2(4),
     PROCESS_DATE VARCHAR2(7),
     FILLER VARCHAR2(16),
     TRANSACTION_SEGMENT_TYPE VARCHAR2(1),
     NET_AMOUNT_SIGN VARCHAR2(1),
     NET_AMOUNT VARCHAR2(9),
     GROSS_AMOUNT_SIGN VARCHAR2(1),
     GROSS_AMOUNT VARCHAR2(9),
     RETAINAGE_AMOUNT_SIGN VARCHAR2(1),
     RETAINAGE_AMOUNT VARCHAR2(9),
     ISSUE_DATE VARCHAR2(7),
     TRANSACTION_DATE VARCHAR2(7),
     TERMINAL_NUMBER VARCHAR2(5),
     TRANSACTION_NUMBER VARCHAR2(5),
     CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9),
     CUSTOMER_JOB_NUMBER VARCHAR2(2),
     POS_TRANSACTION_CODE VARCHAR2(2),
     PAYEE_NAME VARCHAR2(30),
     ADDRESS_LINE_1 VARCHAR2(30),
     ADDRESS_LINE_2 VARCHAR2(30),
     CITY VARCHAR2(15),
     STATE_CODE VARCHAR2(2),
     ZIP_CODE VARCHAR2(10),
     PHONE_NUMBER VARCHAR2(10),
     TRANSACTION_TIME VARCHAR2(4),
     EMPLOYEE_NUMBER VARCHAR2(2),
     BOOK_DATE VARCHAR2(4),
     CYCLE_RUN_NUMBER VARCHAR2(2),
     REASON_CODE VARCHAR2(2)
) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_DATAFILES:'FF_ISSUE_CHANGE_DATA_TMP.bad'
        logfile STORDRFT_DATAFILES:'FF_ISSUE_CHANGE_DATA_TMP.log'
        discardfile STORDRFT_DATAFILES:'FF_ISSUE_CHANGE_DATA_TMP.dsc'
        LOAD WHEN ((40:40) = 'I' OR (40:40) = 'M')
        FIELDS(
                TRANSACTION_SOURCE        POSITION(1:1)   CHAR(1),
                TRANSACTION_TYPE          POSITION(2:2)   CHAR(1),
                COST_CENTER_CODE          POSITION(3:6)   CHAR(4),
                CHECK_SERIAL_NUMBER       POSITION(7:16)  CHAR(10),
                DRAFT_NUMBER              POSITION(12:15) CHAR(4),
                PROCESS_DATE              POSITION(17:23) CHAR(7),
                FILLER                                    CHAR(16),
                TRANSACTION_SEGMENT_TYPE                  CHAR(1),
                NET_AMOUNT_SIGN                           CHAR(1),
                NET_AMOUNT                                CHAR(9),
                GROSS_AMOUNT_SIGN                         CHAR(1),
                GROSS_AMOUNT                              CHAR(9),
                RETAINAGE_AMOUNT_SIGN                     CHAR(1),
                RETAINAGE_AMOUNT                          CHAR(9),
                ISSUE_DATE                                CHAR(7),
                TRANSACTION_DATE                          CHAR(7),
                TERMINAL_NUMBER                           CHAR(5),
                TRANSACTION_NUMBER                        CHAR(5),
                CUSTOMER_ACCOUNT_NUMBER                   CHAR(9),
                CUSTOMER_JOB_NUMBER                       CHAR(2),
                POS_TRANSACTION_CODE                      CHAR(2),
                PAYEE_NAME                                CHAR(30),
                ADDRESS_LINE_1                            CHAR(30),
                ADDRESS_LINE_2                            CHAR(30),
                CITY                                      CHAR(15),
                STATE_CODE                                CHAR(2),
                ZIP_CODE                                  CHAR(10),
                PHONE_NUMBER                              CHAR(10),
                TRANSACTION_TIME                          CHAR(4),
                EMPLOYEE_NUMBER                           CHAR(2),
                BOOK_DATE                                 CHAR(4),
                CYCLE_RUN_NUMBER                          CHAR(2),
                REASON_CODE                               CHAR(2)
              )
     )
     LOCATION
     ( 'STORE_DRAFT.TXT'
     )
    );

CREATE TABLE FF_INSTLR_LN_ITEM_DATA_TMP
(    TRANSACTION_SOURCE VARCHAR2(1),
     TRANSACTION_TYPE VARCHAR2(1),
     COST_CENTER_CODE VARCHAR2(4),
     CHECK_SERIAL_NUMBER VARCHAR2(10),
     PROCESS_DATE VARCHAR2(7),
     FILLER VARCHAR2(16),
     TRANSACTION_SEGMENT_TYPE VARCHAR2(1),
     ITEM_EXT_AMOUNT_SIGN VARCHAR2(1),
     ITEM_EXT_AMOUNT VARCHAR2(9),
     ORGNL_TERMINAL_NUMBER VARCHAR2(5),
     ORGNL_TRANSACTION_NUMBER VARCHAR2(5),
     ITEM_QUANTITY_SIGN VARCHAR2(1),
     ITEM_QUANTITY VARCHAR2(7),
     ITEM_PRICE_SIGN VARCHAR2(1),
     ITEM_PRICE VARCHAR2(7),
     GL_PRIME_ACCOUNT_NUMBER VARCHAR2(4),
     GL_SUB_ACCOUNT_NUMBER VARCHAR2(3)
)
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_DATAFILES:'FF_INSTLR_LN_ITEM_DATA_TMP.bad'
        logfile STORDRFT_DATAFILES:'FF_INSTLR_LN_ITEM_DATA_TMP.log'
        discardfile STORDRFT_DATAFILES:'FF_INSTLR_LN_ITEM_DATA_TMP.dsc'
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

CREATE TABLE FF_DISBRSMT_LINE_ITEM_DATA_TMP
(    TRANSACTION_SOURCE VARCHAR2(1),
     TRANSACTION_TYPE VARCHAR2(1),
     COST_CENTER_CODE VARCHAR2(4),
     CHECK_SERIAL_NUMBER VARCHAR2(10),
     PROCESS_DATE VARCHAR2(7),
     FILLER VARCHAR2(16),
     TRANSACTION_SEGMENT_TYPE VARCHAR2(1),
     ITEM_EXT_AMOUNT_SIGN VARCHAR2(1),
     ITEM_EXT_AMOUNT VARCHAR2(9),
     GL_PRIME_ACCOUNT_NUMBER VARCHAR2(4),
     GL_SUB_ACCOUNT_NUMBER VARCHAR2(3)
)
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_DATAFILES:'FF_DISBRSMT_LINE_ITEM_DATA.bad'
        logfile STORDRFT_DATAFILES:'FF_DISBRSMT_LINE_ITEM_DATA.log'
        discardfile STORDRFT_DATAFILES:'FF_DISBRSMT_LINE_ITEM_DATA.dsc'
        LOAD WHEN ((40:40) = 'L')
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
                GL_PRIME_ACCOUNT_NUMBER   CHAR(4),
                GL_SUB_ACCOUNT_NUMBER     CHAR(3)
               )
      )
      LOCATION
       ( 'STORE_DRAFT.TXT'
       )
    );

CREATE TABLE FF_CUSTOMER_TMP
(    COST_CENTER_CODE VARCHAR2(4),
     TERMINAL_NUMBER VARCHAR2(5),
     TRANSACTION_NUMBER VARCHAR2(5),
     SORT_FORCE VARCHAR2(3),
     SEGMENT_CODE VARCHAR2(2),
     SUB_SEGMENT_CODE VARCHAR2(2),
     FILLER VARCHAR2(5),
     TRANSACTION_DATE VARCHAR2(7),
     CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9),
     CUSTOMER_JOB_NUMBER VARCHAR2(2),
     POS_TRANSACTION_NUMBER_BATCH VARCHAR2(6),
     POS_TRANSACTION_TIME VARCHAR2(4),
     CYCLE_RUN_NUMBER VARCHAR2(2),
     EMPLOYEE_NUMBER VARCHAR2(2),
     POS_MODE_INDICATOR VARCHAR2(1),
     BUSINESS_TYPE_CODE VARCHAR2(2),
     SLS_TERRITORY_NUMBER VARCHAR2(4),
     SLS_TERRITORY_NUMBER_NO_CORR VARCHAR2(4),
     TERRITORY_SPLIT_INDICATOR VARCHAR2(1),
     POS_TRANSACTION_CODE VARCHAR2(2),
     POS_TRANSACTION_DATE VARCHAR2(7),
     POS_TERMINAL_NUMBER VARCHAR2(5),
     POS_TRANSACTION_NUMBER VARCHAR2(5),
     DATA_INDICATOR VARCHAR2(1),
     PURCHASE_ORDER_NUMBER VARCHAR2(20)
)
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_DATAFILES:'FF_CUSTOMER.bad'
        logfile STORDRFT_DATAFILES:'FF_CUSTOMER.log'
        discardfile STORDRFT_DATAFILES:'FF_CUSTOMER.dsc'
        LOAD WHEN ((18:19) = '00')
        FIELDS(
                COST_CENTER_CODE             CHAR(4),
                TERMINAL_NUMBER              CHAR(5),
                TRANSACTION_NUMBER           CHAR(5),
                SORT_FORCE                   CHAR(3),
                SEGMENT_CODE                 CHAR(2),
                SUB_SEGMENT_CODE             CHAR(2),
                FILLER                       CHAR(5),
                TRANSACTION_DATE             CHAR(7),
                CUSTOMER_ACCOUNT_NUMBER      CHAR(9),
                CUSTOMER_JOB_NUMBER          CHAR(2),
                POS_TRANSACTION_NUMBER_BATCH CHAR(6),
                POS_TRANSACTION_TIME         CHAR(4),
                CYCLE_RUN_NUMBER             CHAR(2),
                EMPLOYEE_NUMBER              CHAR(2),
                POS_MODE_INDICATOR           CHAR(1),
                BUSINESS_TYPE_CODE           CHAR(2),
                SLS_TERRITORY_NUMBER         CHAR(4),
                SLS_TERRITORY_NUMBER_NO_CORR CHAR(4),
                TERRITORY_SPLIT_INDICATOR    CHAR(1),
                POS_TRANSACTION_CODE         CHAR(2),
                POS_TRANSACTION_DATE         CHAR(7),
                POS_TERMINAL_NUMBER          CHAR(5),
                POS_TRANSACTION_NUMBER       CHAR(5),
                DATA_INDICATOR               CHAR(1),
                PURCHASE_ORDER_NUMBER        CHAR(20)
              )
      )
      LOCATION
       ( 'CUSTOMER_LABOR.TXT'
       )
    );

CREATE TABLE FF_CUSTOMER_DETAILS_TMP
(    COST_CENTER_CODE VARCHAR2(4),
     TERMINAL_NUMBER VARCHAR2(5),
     TRANSACTION_NUMBER VARCHAR2(5),
     SORT_FORCE VARCHAR2(3),
     SEGMENT_CODE VARCHAR2(2),
     SUB_SEGMENT_CODE VARCHAR2(2),
     FILLER VARCHAR2(5),
     SALES_NUMBER VARCHAR2(9),
     ITEM_QUANTITY_SIGN VARCHAR2(1),
     ITEM_QUANTITY VARCHAR2(7),
     ITEM_PRICE_SIGN VARCHAR2(1),
     ITEM_PRICE VARCHAR2(7),
     ITEM_EXTERNAL_AMOUNT_SIGN VARCHAR2(1),
     ITEM_EXTERNAL_AMOUNT VARCHAR2(7),
     ITEM_DISC_AMOUNT_SIGN VARCHAR2(1),
     ITEM_DISC_AMOUNT VARCHAR2(7),
     ITEM_SALES_TAX_INDICATOR VARCHAR2(1),
     ITEM_DISC_CODE VARCHAR2(1),
     ITEM_DISC_TYPE VARCHAR2(1),
     SALES_PROMO_CODE VARCHAR2(1),
     GL_PRIME_ACCOUNT VARCHAR2(4),
     GL_SUB_ACCOUNT VARCHAR2(3),
     SCHEDULE_TYPE VARCHAR2(2),
     SCHEDULE_VERSION VARCHAR2(6),
     PRICE_LVL_CODE VARCHAR2(1),
     PERCENT_OFF_LVL VARCHAR2(3),
     PROD_DESC_SOURCE VARCHAR2(1),
     ORGNL_POS_TERMINAL_NUMBER VARCHAR2(5),
     ORGNL_POS_TRANSACTION_NUMBER VARCHAR2(5)
)
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_DATAFILES:'FF_CUSTOMER_DETAILS.bad'
        logfile STORDRFT_DATAFILES:'FF_CUSTOMER_DETAILS.log'
        discardfile STORDRFT_DATAFILES:'FF_CUSTOMER_DETAILS.dsc'
        LOAD WHEN ((18:19) = '01' OR (18:19) = '09')
        FIELDS(
                COST_CENTER_CODE             CHAR(4),
                TERMINAL_NUMBER              CHAR(5),
                TRANSACTION_NUMBER           CHAR(5),
                SORT_FORCE                   CHAR(3),
                SEGMENT_CODE                 CHAR(2),
                SUB_SEGMENT_CODE             CHAR(2),
                FILLER                       CHAR(5),
                SALES_NUMBER                 CHAR(9),
                ITEM_QUANTITY_SIGN           CHAR(1),
                ITEM_QUANTITY                CHAR(7),
                ITEM_PRICE_SIGN              CHAR(1),
                ITEM_PRICE                   CHAR(7),
                ITEM_EXTERNAL_AMOUNT_SIGN    CHAR(1),
                ITEM_EXTERNAL_AMOUNT         CHAR(7),
                ITEM_DISC_AMOUNT_SIGN        CHAR(1),
                ITEM_DISC_AMOUNT             CHAR(7),
                ITEM_SALES_TAX_INDICATOR     CHAR(1),
                ITEM_DISC_CODE               CHAR(1),
                ITEM_DISC_TYPE               CHAR(1),
                SALES_PROMO_CODE             CHAR(1),
                GL_PRIME_ACCOUNT             CHAR(4),
                GL_SUB_ACCOUNT               CHAR(3),
                SCHEDULE_TYPE                CHAR(2),
                SCHEDULE_VERSION             CHAR(6),
                PRICE_LVL_CODE               CHAR(1),
                PERCENT_OFF_LVL              CHAR(3),
                PROD_DESC_SOURCE             CHAR(1),
                ORGNL_POS_TERMINAL_NUMBER    CHAR(5),
                ORGNL_POS_TRANSACTION_NUMBER CHAR(5)
              )
      )
      LOCATION
       ( 'CUSTOMER_LABOR.TXT'
       )
    );

CREATE TABLE FF_CSTMR_SALES_TAX_TMP
(    COST_CENTER_CODE VARCHAR2(4),
     TERMINAL_NUMBER VARCHAR2(5),
     TRANSACTION_NUMBER VARCHAR2(5),
     SORT_FORCE VARCHAR2(3),
     SEGMENT_CODE VARCHAR2(2),
     SUB_SEGMENT_CODE VARCHAR2(2),
     FILLER VARCHAR2(5),
     SALES_TAX_CORR_INDICATOR VARCHAR2(1),
     SALES_TAX_COLL_AMOUNT_SIGN VARCHAR2(1),
     SALES_TAX_COLL_AMOUNT VARCHAR2(7),
     SALES_TAX_INDICATOR VARCHAR2(1),
     SALES_TAX_RATE_SIGN VARCHAR2(1),
     SALES_TAX_RATE VARCHAR2(5),
     SALES_TAX_CODE VARCHAR2(5)
)
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_DATAFILES:'FF_CSTMR_SALES_TAX.bad'
        logfile STORDRFT_DATAFILES:'FF_CSTMR_SALES_TAX.log'
        discardfile STORDRFT_DATAFILES:'FF_CSTMR_SALES_TAX.dsc'
        LOAD WHEN ((18:19) = '04')
        FIELDS(
                COST_CENTER_CODE           CHAR(4),
                TERMINAL_NUMBER            CHAR(5),
                TRANSACTION_NUMBER         CHAR(5),
                SORT_FORCE                 CHAR(3),
                SEGMENT_CODE               CHAR(2),
                SUB_SEGMENT_CODE           CHAR(2),
                FILLER                     CHAR(5),
                SALES_TAX_CORR_INDICATOR   CHAR(1),
                SALES_TAX_COLL_AMOUNT_SIGN CHAR(1),
                SALES_TAX_COLL_AMOUNT      CHAR(7),
                SALES_TAX_INDICATOR        CHAR(1),
                SALES_TAX_RATE_SIGN        CHAR(1),
                SALES_TAX_RATE             CHAR(5),
                SALES_TAX_CODE             CHAR(5)
               )
      )
      LOCATION
       ( 'CUSTOMER_LABOR.TXT'
       )
    );

CREATE TABLE FF_CSTMR_LINE_ITEM_DATA_TMP
(    TRANSACTION_SOURCE VARCHAR2(1),
     TRANSACTION_TYPE VARCHAR2(1),
     COST_CENTER_CODE VARCHAR2(4),
     CHECK_SERIAL_NUMBER VARCHAR2(10),
     PROCESS_DATE VARCHAR2(7),
     FILLER VARCHAR2(16),
     TRANSACTION_SEGMENT_TYPE VARCHAR2(1),
     ITEM_EXT_AMOUNT_SIGN VARCHAR2(1),
     ITEM_EXT_AMOUNT VARCHAR2(9),
     ORGNL_CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9),
     ORGNL_JOB_NUMBER VARCHAR2(2)
)
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_DATAFILES:'FF_CUSTOMER_LINE_ITEM_DATA.bad'
        logfile STORDRFT_DATAFILES:'FF_CUSTOMER_LINE_ITEM_DATA.log'
        discardfile STORDRFT_DATAFILES:'FF_CUSTOMER_LINE_ITEM_DATA.dsc'
        LOAD WHEN ((40:40) = 'K')
        FIELDS(
                TRANSACTION_SOURCE             CHAR(1),
                TRANSACTION_TYPE               CHAR(1),
                COST_CENTER_CODE               CHAR(4),
                CHECK_SERIAL_NUMBER            CHAR(10),
                PROCESS_DATE                   CHAR(7),
                FILLER                         CHAR(16),
                TRANSACTION_SEGMENT_TYPE       CHAR(1),
                ITEM_EXT_AMOUNT_SIGN           CHAR(1),
                ITEM_EXT_AMOUNT                CHAR(9),
                ORGNL_CUSTOMER_ACCOUNT_NUMBER  CHAR(9),
                ORGNL_JOB_NUMBER               CHAR(2)
              )
      )
      LOCATION
       ( 'STORE_DRAFT.TXT'
       )
    );

CREATE TABLE FF_CSTMR_FORM_OF_PAY_TMP
(    COST_CENTER_CODE VARCHAR2(4),
     TERMINAL_NUMBER VARCHAR2(5),
     TRANSACTION_NUMBER VARCHAR2(5),
     SORT_FORCE VARCHAR2(3),
     SEGMENT_CODE VARCHAR2(2),
     SUB_SEGMENT_CODE VARCHAR2(2),
     FILLER VARCHAR2(5),
     PAY_DISC_CODE VARCHAR2(1),
     TRANSACTION_TOTAL_AMOUNT_SIGN VARCHAR2(1),
     TRANSACTION_TOTAL_AMOUNT VARCHAR2(7),
     POS_LINE_CNT VARCHAR2(5),
     PAY_AMOUNT_SIGN VARCHAR2(1),
     PAY_AMOUNT VARCHAR2(7),
     POS_DISC_SIGN VARCHAR2(1),
     POS_DISC VARCHAR2(7),
     SALES_DISC_AMOUNT_SIGN VARCHAR2(1),
     SALES_DISC_AMOUNT VARCHAR2(7)
)
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_DATAFILES:'FF_CSTMR_FORM_OF_PAY.bad'
        logfile STORDRFT_DATAFILES:'FF_CSTMR_FORM_OF_PAY.log'
        discardfile STORDRFT_DATAFILES:'FF_CSTMR_FORM_OF_PAY.dsc'
        LOAD WHEN ((18:19) = '06' OR (18:19) = '07')
        FIELDS(
                COST_CENTER_CODE              CHAR(4),
                TERMINAL_NUMBER               CHAR(5),
                TRANSACTION_NUMBER            CHAR(5),
                SORT_FORCE                    CHAR(3),
                SEGMENT_CODE                  CHAR(2),
                SUB_SEGMENT_CODE              CHAR(2),
                FILLER                        CHAR(5),
                PAY_DISC_CODE                 CHAR(1),
                TRANSACTION_TOTAL_AMOUNT_SIGN CHAR(1),
                TRANSACTION_TOTAL_AMOUNT      CHAR(7),
                POS_LINE_CNT                  CHAR(5),
                PAY_AMOUNT_SIGN               CHAR(1),
                PAY_AMOUNT                    CHAR(7),
                POS_DISC_SIGN                 CHAR(1),
                POS_DISC                      CHAR(7),
                SALES_DISC_AMOUNT_SIGN        CHAR(1),
                SALES_DISC_AMOUNT             CHAR(7)
              )
      )
      LOCATION
       ( 'CUSTOMER_LABOR.TXT'
       )
    );

CREATE TABLE FF_CSTMR_BANK_CARD_TMP
(    COST_CENTER_CODE VARCHAR2(4),
     TERMINAL_NUMBER VARCHAR2(5),
     TRANSACTION_NUMBER VARCHAR2(5),
     SORT_FORCE VARCHAR2(3),
     SEGMENT_CODE VARCHAR2(2),
     SUB_SEGMENT_CODE VARCHAR2(2),
     FILLER VARCHAR2(5),
     BANK_CARD_ACCOUNT_NUMBER VARCHAR2(16),
     BANK_AUTH VARCHAR2(9),
     BANK_AMOUNT_SIGN VARCHAR2(1),
     BANK_AMOUNT VARCHAR2(9),
     BANK_TYPE VARCHAR2(1)
)
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_DATAFILES:'FF_CSTMR_BANK_CARD.bad'
        logfile STORDRFT_DATAFILES:'FF_CSTMR_BANK_CARD.log'
        discardfile STORDRFT_DATAFILES:'FF_CSTMR_BANK_CARD.dsc'
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

 CREATE TABLE FF_BANK_PAID_DATA
(    TRANSACTION_SOURCE VARCHAR2(1),
     TRANSACTION_TYPE VARCHAR2(1),
     COST_CENTER_CODE VARCHAR2(4),
     CHECK_SERIAL_NUMBER VARCHAR2(10),
     PROCESS_DATE VARCHAR2(7),
     FILLER VARCHAR2(16),
     TRANSACTION_SEGMENT_TYPE VARCHAR2(1),
     PAID_DATE VARCHAR2(7),
     STOP_PAY_DATE VARCHAR2(7),
     STOP_PAY_REMOVE_DATE VARCHAR2(7),
     VOID_DATE VARCHAR2(7),
     BANK_PAID_AMOUNT_SIGN VARCHAR2(1),
     BANK_PAID_AMOUNT VARCHAR2(9),
     BANK_NUMBER VARCHAR2(3),
     BANK_ACCOUNT_NUMBER VARCHAR2(16),
     CPCS_NUMBER VARCHAR2(9),
     FILLER1 VARCHAR2(8),
     PAYEE_INFO VARCHAR2(16),
     ADDITIONAL_INFO VARCHAR2(16),
     FS_ACCOUNT_NUMBER1 VARCHAR2(9),
     FS_AMOUNT_SIGN1 VARCHAR2(1),
     FS_AMOUNT1 VARCHAR2(9),
     FS_ACCOUNT_NUMBER2 VARCHAR2(9),
     FS_AMOUNT_SIGN2 VARCHAR2(1),
     FS_AMOUNT2 VARCHAR2(9),
     FS_ACCOUNT_NUMBER3 VARCHAR2(9),
     FS_AMOUNT_SIGN3 VARCHAR2(1),
     FS_AMOUNT3 VARCHAR2(9)
)
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile STORDRFT_DATAFILES:'DLY_BANK_PAID_DATA.bad'
        logfile STORDRFT_DATAFILES:'DLY_BANK_PAID_DATA.log'
        discardfile STORDRFT_DATAFILES:'DLY_BANK_PAID_DATA.dsc'
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