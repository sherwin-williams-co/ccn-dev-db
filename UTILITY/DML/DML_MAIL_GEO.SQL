/*
This script inserts records into MAILING_GROUP and MAILING_DETAILS tables
for ADDRESS_GEO_DETAILS table
created by rxv940 on 03/20/2018 for ASP-976
Run this in Utility
*/



INSERT INTO MAILING_GROUP
VALUES ('109', 'ccnoracle.team@sherwin.com');
-- 1 record inserted

INSERT INTO MAILING_DETAILS 
VALUES ('LOAD_CCN_ADDRESS_GEO_DETAILS', '109', 'CCN_ADDRESS_GEO_DETAILS table load failed', 'ccnoracle.team@sherwin.com', 
'Loading data into CCN_ADDRESS_GEO_DETAILS failed - Please refer the log file..', 'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
-- 1 record inserted
COMMIT;