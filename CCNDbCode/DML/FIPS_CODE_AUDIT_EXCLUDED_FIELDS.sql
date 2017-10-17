/***************************************************************************** 
Below script is created to insert data into CCN_AUDIT_EXCLUDED_FIELDS table.
This table holds the table names and fields that are not part of the CCN audit.
Created : 10/17/2017 sxh487 CCN Project....
        : The FIPS_CODE is added in this table so that it is not sent to the backfeed
*****************************************************************************/
SET DEFINE OFF;
--ADDRESS_USA
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS (TABLE_NAME,COLUMN_NAME,EXCLUDED_INDICATOR) 
VALUES ('ADDRESS_USA','FIPS_CODE','Y');

COMMIT;