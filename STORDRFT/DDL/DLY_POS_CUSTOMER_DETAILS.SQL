/*
created : nxk927 06/12/2017 
          table to load pos data
*/
  CREATE TABLE DLY_POS_CUSTOMER_DETAILS 
   (TRANGUID                     VARCHAR2(50) NOT NULL,
    COST_CENTER_CODE             VARCHAR2(4),
    TERMINAL_NUMBER              VARCHAR2(5),
    TRANSACTION_NUMBER           VARCHAR2(5),
    SORT_FORCE                   VARCHAR2(3),
    SEGMENT_CODE                 VARCHAR2(2),
    SUB_SEGMENT_CODE             VARCHAR2(2),
    FILLER                       VARCHAR2(5),
    SALES_NUMBER                 VARCHAR2(9),
    ITEM_QUANTITY_SIGN           VARCHAR2(1),
    ITEM_QUANTITY                VARCHAR2(7),
    ITEM_PRICE_SIGN              VARCHAR2(1),
    ITEM_PRICE                   VARCHAR2(7),
    ITEM_EXTERNAL_AMOUNT_SIGN    VARCHAR2(1),
    ITEM_EXTERNAL_AMOUNT         VARCHAR2(7),
    ITEM_DISC_AMOUNT_SIGN        VARCHAR2(1),
    ITEM_DISC_AMOUNT             VARCHAR2(7),
    ITEM_SALES_TAX_INDICATOR     VARCHAR2(1),
    ITEM_DISC_CODE               VARCHAR2(1),
    ITEM_DISC_TYPE               VARCHAR2(1),
    SALES_PROMO_CODE             VARCHAR2(1),
    GL_PRIME_ACCOUNT             VARCHAR2(4),
    GL_SUB_ACCOUNT               VARCHAR2(3),
    SCHEDULE_TYPE                VARCHAR2(2),
    SCHEDULE_VERSION             VARCHAR2(6),
    PRICE_LVL_CODE               VARCHAR2(1),
    PERCENT_OFF_LVL              VARCHAR2(3),
    PROD_DESC_SOURCE             VARCHAR2(1),
    ORGNL_POS_TERMINAL_NUMBER    VARCHAR2(5),
    ORGNL_POS_TRANSACTION_NUMBER VARCHAR2(5),
    RUNCYCLE                     VARCHAR2(100),
    LOAD_DATE                    DATE,
    SEQNBR                       VARCHAR2(10)
   );

