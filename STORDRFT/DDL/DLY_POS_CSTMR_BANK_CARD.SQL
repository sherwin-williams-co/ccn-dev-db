/*
created : nxk927 06/12/2017 
          table to load pos data
*/

  CREATE TABLE DLY_POS_CSTMR_BANK_CARD 
   (TRANGUID                 VARCHAR2(50) NOT NULL,
    COST_CENTER_CODE         VARCHAR2(4),
    TERMINAL_NUMBER          VARCHAR2(5),
    TRANSACTION_NUMBER       VARCHAR2(5),
    SORT_FORCE               VARCHAR2(3),
    SEGMENT_CODE             VARCHAR2(2),
    SUB_SEGMENT_CODE         VARCHAR2(2),
    FILLER                   VARCHAR2(5),
    BANK_CARD_ACCOUNT_NUMBER VARCHAR2(16),
    BANK_AUTH                VARCHAR2(9),
    BANK_AMOUNT_SIGN         VARCHAR2(1),
    BANK_AMOUNT              VARCHAR2(9),
    BANK_TYPE                VARCHAR2(1),
    RUNCYCLE                 VARCHAR2(100),
    LOAD_DATE                DATE
   );

