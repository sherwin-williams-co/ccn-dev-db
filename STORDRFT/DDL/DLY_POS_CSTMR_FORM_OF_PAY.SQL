/*
created : nxk927 06/12/2017 
          table to load pos data
*/

  CREATE TABLE DLY_POS_CSTMR_FORM_OF_PAY 
   (TRANGUID                      VARCHAR2(50)  NOT NULL,
    COST_CENTER_CODE              VARCHAR2(4),
    TERMINAL_NUMBER               VARCHAR2(5),
    TRANSACTION_NUMBER            VARCHAR2(5),
    SORT_FORCE                    VARCHAR2(3),
    SEGMENT_CODE                  VARCHAR2(2),
    SUB_SEGMENT_CODE              VARCHAR2(2),
    FILLER                        VARCHAR2(5),
    PAY_DISC_CODE                 VARCHAR2(1),
    TRANSACTION_TOTAL_AMOUNT_SIGN VARCHAR2(1),
    TRANSACTION_TOTAL_AMOUNT      VARCHAR2(7),
    POS_LINE_CNT                  VARCHAR2(5),
    PAY_AMOUNT_SIGN               VARCHAR2(1),
    PAY_AMOUNT                    VARCHAR2(7),
    POS_DISC_SIGN                 VARCHAR2(1),
    POS_DISC                      VARCHAR2(7),
    SALES_DISC_AMOUNT_SIGN        VARCHAR2(1),
    SALES_DISC_AMOUNT             VARCHAR2(7),
    RUNCYCLE                      VARCHAR2(100),
    LOAD_DATE                     DATE
   );

