/*******************************************************************************
Created Index on STORE_DRAFTS to improve the performance of the 1099 runs

Created : 03/18/2016 jxc517/sxh487 CCN Project....
Changed : 
*******************************************************************************/
CREATE INDEX STORE_DRAFTS_INVC_NBR ON STORE_DRAFTS(COST_CENTER_CODE, CUSTOMER_ACCOUNT_NUMBER, FSS_INVOICE_NUMBER);