-- Below code is for mailing details associated with Polling 
-- craeted by rxv940 on 07/28/2017

Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('88','ccnoracle.team@sherwin.com');
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('89','ccnoracle.team@sherwin.com');
COMMIT;


SET SCAN OFF;
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('RequestidFailure','88','Polling - Requestid retrieval Failure' ,'ccnoracle.team@sherwin.com','Error while calling Java function to get the RequestID. Please check the log file. ','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('ARCHIVINGPROCESSFAILURE','89','Polling Failure','ccnoracle.team@sherwin.com','Error while archiving. Please check the log file.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;