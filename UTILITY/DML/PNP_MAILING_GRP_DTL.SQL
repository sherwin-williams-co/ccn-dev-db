/*
Created :nxk927 email group for diff process
*/


INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID) VALUES ('56', 'ccnoracle.team@sherwin.com;smis@sherwin.com');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY, GROUP_ID, SUBJECT, FROM_P, MESSAGE, SIGNATURE) VALUES ('STOREDRAFTS_RECONCILE_FILES_GEN', '56', 'Storedrafts reconcile data generation.', 'ccnoracle.team@sherwin.com', 'Please find the storedrafts reconcile data files.', 'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;


