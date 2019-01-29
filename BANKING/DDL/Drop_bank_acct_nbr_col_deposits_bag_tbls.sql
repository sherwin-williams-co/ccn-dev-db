/*******************************************************************************
This script drops the bank account number column from deposit bag tables
CREATED : 01/23/2019 pxa852 CCN Project...
*******************************************************************************/

ALTER TABLE BANK_DEP_BAG_TICK DROP COLUMN BANK_ACCOUNT_NUMBER;
ALTER TABLE BANK_DEP_BAG_TICK_HIST DROP COLUMN BANK_ACCOUNT_NUMBER;

ALTER TABLE BANK_DEP_BAG_TICKORD DROP COLUMN BANK_ACCOUNT_NUMBER;
ALTER TABLE BANK_DEP_BAG_TICKORD_HIST DROP COLUMN BANK_ACCOUNT_NUMBER;

commit;