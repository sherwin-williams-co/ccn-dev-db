/*******************************************************************************
Changed the order of column in Index for MEMBER_BANK_CC table to increase
performance when placing an order (UI).

Created : 10/26/2015 CCN Project....
*******************************************************************************/

DROP INDEX MEMBER_BANK_CC_PK;


CREATE INDEX MEMBER_BANK_CC_IDX
ON MEMBER_BANK_CC (MEMBER_STORE_NBR, LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR);