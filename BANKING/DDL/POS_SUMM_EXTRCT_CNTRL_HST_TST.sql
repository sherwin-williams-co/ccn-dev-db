  /*
Created : 08/14/2018 pxa852 CCN Project....
          This table will hold the history information.
          This table is created for testing purpose.
*/

CREATE TABLE POS_SUMM_EXTRCT_CNTRL_HST_TST
   (COST_CENTER_CODE          VARCHAR2(6),
    BANK_DEP_AMT              NUMBER,
    BANK_ACCOUNT_NBR          VARCHAR2(17),
    TRANSACTION_DATE          DATE,
    LOAD_DATE                 DATE,
    ORIGINATED_BANK_ACCNT_NBR VARCHAR2(17),
    RLS_RUN_CYCLE             NUMBER
   );