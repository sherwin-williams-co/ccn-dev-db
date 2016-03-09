/*
Created :dxv848 creating a email group and details for SRA11000 initLoad Process.
*/


INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID) VALUES ('29', 'Keith.D.Parker@sherwin.com;Shahla.Husain@sherwin.com;Nirajan.Karki@sherwin.com;Jaydeep.Cheruku@sherwin.com;Abhitej.Kasula@sherwin.com;durga.sowjanya.vanaparti@sherwin.com;amarender.reddy.devidi@sherwin.com;mahesh.repala@sherwin.com');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY, GROUP_ID, SUBJECT, FROM_P, MESSAGE, SIGNATURE) VALUES ('SRA11000_PROCESS', '29', 'SRA11000 PROCESS FAILED', 'Keith.D.Parker@sherwin.com', 'SRA11000 InitLoad Process Failed', 'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'Senior Developer'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;

