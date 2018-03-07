/***************************************************************************** 
Below script is created to insert data into CCN_AUDIT_EXCLUDED_FIELDS table.
This table holds the table names and fields that are not part of the CCN audit.

Created : 02/20/2018 bxa919 CCN Project....


*****************************************************************************/

SET DEFINE OFF;

Insert into CCN_AUDIT_EXCLUDED_FIELDS (TABLE_NAME,COLUMN_NAME,EXCLUDED_INDICATOR) 
values ('BANK_CARD','MERCH_ID_CAN_MC','Y');

Insert into CCN_AUDIT_EXCLUDED_FIELDS (TABLE_NAME,COLUMN_NAME,EXCLUDED_INDICATOR) 
values ('BANK_CARD','PCI_MERCH_ID_CAN_MC','Y');

COMMIT;