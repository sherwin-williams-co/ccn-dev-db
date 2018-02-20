/*
Script Name: CCN_AUDIT_EXCLUDED_MARKETING.sql
Purpose    : For dropping and Inserting records into the CCN_AUDIT_EXCLUDED_FIELDS table.
             for Newly added sq ft fields as these fields are not going to audit 

Created : 12/07/2017 axt754 CCN Project....
Changed :
*/

INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('MARKETING','TOTAL_SQ_FT','Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('MARKETING','SALES_SQ_FT','Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('MARKETING','WAREHOUSE_SQ_FT','Y');

-- Commit the Transaction
COMMIT;

-- See if the records were inserted
SELECT * FROM CCN_AUDIT_EXCLUDED_FIELDS WHERE TABLE_NAME = 'MARKETING';