/*
Script Name: CCN_AUDIT_EXCLUDED_ADMIN.sql
Purpose    : For dropping and Inserting records into the CCN_AUDIT_EXCLUDED_FIELDS table.
             for Newly added allocation_cc and division_offset as these fields are not going to audit 

Created : 01/18/2018 axt754 CCN Project....
Changed :
*/

INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('ADMINISTRATION','ALLOCATION_CC','Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('ADMINISTRATION','DIVISION_OFFSET','Y');

-- Commit the Transaction
COMMIT;

-- See if the records were inserted
SELECT * FROM CCN_AUDIT_EXCLUDED_FIELDS WHERE TABLE_NAME = 'ADMINISTRATION';