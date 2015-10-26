/*******************************************************************************
Changing the column order of existing primary key in MEMBER_BANK_CC table to increase
performance when placing an order (UI).

Created : 10/26/2015 CCN Project....
*******************************************************************************/

ALTER TABLE MEMBER_BANK_CC 
DROP CONSTRAINT  MEMBER_BANK_CC_PK;

ALTER TABLE MEMBER_BANK_CC 
ADD CONSTRAINT MEMBER_BANK_CC_PK
PRIMARY KEY (MEMBER_STORE_NBR, LEAD_BANK_ACCOUNT_NBR, LEAD_STORE_NBR);