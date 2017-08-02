/*
created : nxk927 06/12/2017 
          table to load pos data
*/
  CREATE TABLE DLY_POS_CUSTOMER 
   (TRANGUID                        VARCHAR2(50) NOT NULL,
    COST_CENTER_CODE                VARCHAR2(4),
    TERMINAL_NUMBER                 VARCHAR2(5),
    TRANSACTION_NUMBER              VARCHAR2(5),
    SORT_FORCE                      VARCHAR2(3),
    SEGMENT_CODE                    VARCHAR2(2),
    SUB_SEGMENT_CODE                VARCHAR2(2),
    FILLER                          VARCHAR2(5),
    TRANSACTION_DATE                VARCHAR2(7),
    CUSTOMER_ACCOUNT_NUMBER         VARCHAR2(9),
    CUSTOMER_JOB_NUMBER             VARCHAR2(2),
    POS_TRANSACTION_NUMBER_BATCH    VARCHAR2(6),
    POS_TRANSACTION_TIME            VARCHAR2(4),
    CYCLE_RUN_NUMBER                VARCHAR2(2),
    EMPLOYEE_NUMBER                 VARCHAR2(2),
    POS_MODE_INDICATOR              VARCHAR2(1),
    BUSINESS_TYPE_CODE              VARCHAR2(2),
    SLS_TERRITORY_NUMBER            VARCHAR2(4),
    SLS_TERRITORY_NUMBER_NO_CORR    VARCHAR2(4),
    TERRITORY_SPLIT_INDICATOR       VARCHAR2(1),
    POS_TRANSACTION_CODE            VARCHAR2(2),
    POS_TRANSACTION_DATE            VARCHAR2(7),
    POS_TERMINAL_NUMBER             VARCHAR2(5),
    POS_TRANSACTION_NUMBER          VARCHAR2(5),
    DATA_INDICATOR                  VARCHAR2(1),
    PURCHASE_ORDER_NUMBER           VARCHAR2(20)
    RUNCYCLE                        VARCHAR2(100),
    LOAD_DATE                       DATE
   );

