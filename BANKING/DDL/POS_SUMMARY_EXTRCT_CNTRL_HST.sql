  /*
Created : 06/22/2018 nxk927 CCN Project....
          This table will hold the data for SUMMARY_EXTRCT_CNTRL_FL
*/

CREATE TABLE POS_SUMMARY_EXTRCT_CNTRL_HST
   (COST_CENTER_CODE           VARCHAR2(6),
    BANK_DEP_AMT               NUMBER,
    BANK_ACCOUNT_NBR           VARCHAR2(17),
    TRANSACTION_DATE           DATE, 
    LOAD_DATE                  DATE,
    ORIGINATED_BANK_ACCNT_NBR  VARCHAR2(17),
    RLS_RUN_CYCLE              NUMBER);
