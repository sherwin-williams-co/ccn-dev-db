/*******************************************************************************
Adding Index to MEMBER_STORE_NBR column in MEMBER_BANK_CC table to increase
performance when placing an order (UI).

Created : 10/26/2015 CCN Project....
*******************************************************************************/
CREATE INDEX MEMBER_STORE_NBR_IDX
ON MEMBER_BANK_CC (MEMBER_STORE_NBR);