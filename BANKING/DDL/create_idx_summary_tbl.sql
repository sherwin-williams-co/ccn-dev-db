/***************************************************************
Index on SUMMARY_EXTRCT_CNTRL_FL added for Performance Improvement of loading SUMMARY_EXTRCT_CNTRL_FL table
Created: - 10/04/2017 nxk927 CCN Project Team...

****************************************************************/
CREATE INDEX SUMMARY_IDX ON SUMMARY_EXTRCT_CNTRL_FL (SUBSTR(COST_CENTER_CODE,-4),BANK_DEP_AMT, BANK_ACCOUNT_NBR,TRANSACTION_DATE );