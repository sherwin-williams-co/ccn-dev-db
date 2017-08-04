-- Below code is for mailing details associated with Polling 
-- craeted by rxv940 on 07/28/2017

Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('88','ccnoracle.team@sherwin.com');
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('89','ccnoracle.team@sherwin.com');

COMMIT;

-- Below code is for mailing details associated with Polling 
-- craeted by rxv940 on 07/28/2017
SET SCAN OFF;
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('RequestidFailure','88','Polling - Requestid retrieval Failure' ,'ccnoracle.team@sherwin.com','Error while calling Java function to get the RequestID. Please check the log file. ','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('ARCHIVINGPROCESSFAILURE','89','Polling Failure','ccnoracle.team@sherwin.com','Error while archiving. Please check the log file.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;

-- Below code is for mailing details associated with Polling 
-- craeted by rxv940 on 08/01/2017

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('QueueDownloadFAILURE','88','Queue Download Failure','ccnoracle.team@sherwin.com','Error while downloading store lists from the Queue.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('XML_GEN_FAILURE_STR','88','XML Generation Failure','ccnoracle.team@sherwin.com','Error while generating the XML file for STORE.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('XML_GEN_FAILURE_TER','88','XML Generation Failure','ccnoracle.team@sherwin.com','Error while generating the XML file for TERRITORY.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('XML_GEN_FAILURE_PRM','88','XML Generation Failure','ccnoracle.team@sherwin.com','Error while generating the XML file for PARAM.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;