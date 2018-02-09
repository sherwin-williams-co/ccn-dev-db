/*******************************************************************************
  Alter table script to add MASTER_CARD_ID and PCI_MASTER_CARD_ID  columns to BANK_CARD table.
  CREATED : 02/09/2018 bxa919 CCN Project...
*******************************************************************************/

ALTER TABLE BANK_CARD ADD MERCH_ID_CAN    VARCHAR2(15);
ALTER TABLE BANK_CARD ADD PCI_MERCH_ID_CAN  VARCHAR2(20);