/*
created : nxk927 06/12/2017 
          table to load pos data
*/

  CREATE TABLE DLY_POS_CSTMR_SALES_TAX 
   (TRANGUID                   VARCHAR2(50)  NOT NULL,
    COST_CENTER_CODE           VARCHAR2(4),
    TERMINAL_NUMBER            VARCHAR2(5),
    TRANSACTION_NUMBER         VARCHAR2(5),
    SORT_FORCE                 VARCHAR2(3),
    SEGMENT_CODE               VARCHAR2(2),
    SUB_SEGMENT_CODE           VARCHAR2(2),
    FILLER                     VARCHAR2(5),
    SALES_TAX_CORR_INDICATOR   VARCHAR2(1),
    SALES_TAX_COLL_AMOUNT_SIGN VARCHAR2(1),
    SALES_TAX_COLL_AMOUNT      VARCHAR2(7),
    SALES_TAX_INDICATOR        VARCHAR2(1),
    SALES_TAX_RATE_SIGN        VARCHAR2(1),
    SALES_TAX_RATE             VARCHAR2(5),
    SALES_TAX_CODE             VARCHAR2(5),
    RUNCYCLE                   VARCHAR2(100),
    LOAD_DATE                  DATE
   );

