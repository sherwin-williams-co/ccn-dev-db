/*
created : nxk927 06/12/2017 
          table to load pos data
*/

  CREATE TABLE DLY_POS_BANK_PAID_DATA 
   (TRANGUID                 VARCHAR2(50) NOT NULL,
    TRANSACTION_SOURCE       VARCHAR2(1),
    TRANSACTION_TYPE         VARCHAR2(1),
    COST_CENTER_CODE         VARCHAR2(4),
    CHECK_SERIAL_NUMBER      VARCHAR2(10),
    PROCESS_DATE             VARCHAR2(7),
    FILLER                   VARCHAR2(16),
    TRANSACTION_SEGMENT_TYPE VARCHAR2(1),
    PAID_DATE                VARCHAR2(7),
    STOP_PAY_DATE            VARCHAR2(7),
    STOP_PAY_REMOVE_DATE     VARCHAR2(7),
    VOID_DATE                VARCHAR2(7),
    BANK_PAID_AMOUNT_SIGN    VARCHAR2(1),
    BANK_PAID_AMOUNT         VARCHAR2(9),
    BANK_NUMBER              VARCHAR2(3),
    BANK_ACCOUNT_NUMBER      VARCHAR2(16),
    CPCS_NUMBER              VARCHAR2(9),
    FILLER1                  VARCHAR2(8),
    PAYEE_INFO               VARCHAR2(16),
    ADDITIONAL_INFO          VARCHAR2(16),
    FS_ACCOUNT_NUMBER1       VARCHAR2(9),
    FS_AMOUNT_SIGN1          VARCHAR2(1),
    FS_AMOUNT1               VARCHAR2(9),
    FS_ACCOUNT_NUMBER2       VARCHAR2(9),
    FS_AMOUNT_SIGN2          VARCHAR2(1),
    FS_AMOUNT2               VARCHAR2(9),
    FS_ACCOUNT_NUMBER3       VARCHAR2(9),
    FS_AMOUNT_SIGN3          VARCHAR2(1),
    FS_AMOUNT3               VARCHAR2(9),
    RUNCYCLE                 VARCHAR2(100),
    LOAD_DATE                DATE
   );

