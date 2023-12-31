/***************************************************
This script rename the columns in CUST_DEP_REDEMPTION_DETAILS Table

Created : 11/06/2018 sxg151 CCN Project Team....
        : ASP-1150
***************************************************/
-- Rename the column names in CUST_DEP_REDEMPTION_DETAILS
ALTER TABLE CUST_DEP_REDEMPTION_DETAILS
RENAME COLUMN ORIGINAL_DEP_TERM_NBR TO ORGNL_DEPOSIT_TERMINAL_NBR;

ALTER TABLE CUST_DEP_REDEMPTION_DETAILS
RENAME COLUMN ORIGINAL_DEP_TRANS_NBR TO ORGNL_DEPOSIT_TRANSACTION_NBR;

ALTER TABLE CUST_DEP_REDEMPTION_DETAILS
RENAME COLUMN ORIGINAL_DEP_TRAN_DATE TO ORGNL_DEPOSIT_TRANSACTION_DATE;
