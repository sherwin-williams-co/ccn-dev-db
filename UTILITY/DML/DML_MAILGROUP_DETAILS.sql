/*
Created :dxv848 creating a email group and details for SRA11000 initLoad Process.
*/


INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID) VALUES ('29', 'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY, GROUP_ID, SUBJECT, FROM_P, MESSAGE, SIGNATURE) VALUES ('SRA11000_INITLOAD', '29', 'SRA11000 INITLOAD PROCESS FAILED', 'ccnoracle.team@sherwin.com', 'SRA11000 InitLoad Process Failed', 'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;

