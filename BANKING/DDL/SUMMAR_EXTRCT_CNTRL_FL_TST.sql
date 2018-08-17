  /*
Created : 08/14/2018 pxa852 CCN Project....
          This table will hold the data for POS_SUMM_EXTRCT_CNTRL_FL_TST.
          This table is created for testing purpose.
*/

CREATE TABLE SUMMAR_EXTRCT_CNTRL_FL_TST
   (COST_CENTER_CODE          VARCHAR2(6),
    CENTURY                   VARCHAR2(1),
    BANK_DEP_AMT              NUMBER(10,2),
    BANK_ACCOUNT_NBR          VARCHAR2(17),
    TRANSACTION_DATE          DATE,
    LOAD_DATE                 DATE,
    ORIGINATED_BANK_ACCNT_NBR VARCHAR2(17)
   );

  CREATE INDEX SUMMARY_IDX_TST ON SUMMAR_EXTRCT_CNTRL_FL_TST(SUBSTR(COST_CENTER_CODE,(-4)), BANK_DEP_AMT, TRANSACTION_DATE);