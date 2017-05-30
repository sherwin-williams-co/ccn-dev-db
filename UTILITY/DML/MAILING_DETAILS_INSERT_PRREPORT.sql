--------------------------------------------------------
--  File created - Friday-May-26-2017   rxa457 for asp-772
--------------------------------------------------------

REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('63','jmkeating@sherwin.com;baeverden@sherwin.com');


REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('STORE_PDH_HRCHY_MAIL','63','Price District Hierarchy Reporting for Stores Pricing Group','ccnoracle.team@sherwin.com','Please find attached the Price District Hierarchy Reporting details with this email.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
commit;
