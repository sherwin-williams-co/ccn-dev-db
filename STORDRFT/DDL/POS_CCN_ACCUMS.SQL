/*
created : nxk927 06/12/2017 
          table to load pos data to add logic for the form of pay data compare it with the legacy data
*/

CREATE TABLE POS_CCN_ACCUMS
   (TRAN_GUID                      VARCHAR2(50) NOT NULL ENABLE,
    COST_CENTER_CODE               VARCHAR2(6),
    TERMINAL_NUMBER                VARCHAR2(6),
    TRANSACTION_NUMBER             VARCHAR2(6),
    SORT_FORCE                     VARCHAR2(1),
    SEGMENT_CODE                   VARCHAR2(1),
    SUB_SEGMENT_CODE               VARCHAR2(1),
    FILLER                         VARCHAR2(1),
    PAY_DISC_CODE                  VARCHAR2(1),
    TRANSACTION_TOTAL_AMOUNT_SIGN  VARCHAR2(1),
    TRANSACTION_TOTAL_AMOUNT       VARCHAR2(10),
    POS_LINE_CNT                   VARCHAR2(1),
    PAY_AMOUNT_SIGN                VARCHAR2(1),
    PAY_AMOUNT                     VARCHAR2(10),
    POS_DISC_SIGN                  VARCHAR2(1),
    POS_DISC                       VARCHAR2(10),
    SALES_DISC_AMOUNT_SIGN         VARCHAR2(1),
    SALES_DISC_AMOUNT              VARCHAR2(10),
    RLS_RUN_CYCLE                  VARCHAR2(10),
    ACCUM_ID                       VARCHAR2(5),
    TRANID                         VARCHAR2(8),
    SEQNBR                         VARCHAR2(10)
   );
