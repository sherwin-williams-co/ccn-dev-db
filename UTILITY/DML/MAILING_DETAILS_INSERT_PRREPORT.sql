/********************************************************************************************************************************************
Inserting new mailing group ID for 'Pricng Stores Group" email ID's. This mailing group will be used to send emails to Pricing Stores Group.
Inserts into MAILING_DEAILS for Price District Hierarchy Reporting which is scheduled every Monday 8 am. Inserts separate records for both success and error email
Task - ASP-772

Created : 05/25/2017 rxa457 CCN Project Team....
Changed:  06/14/2017 rxa457 CCN Project Team....
              Changed to pricing district group mail ID rather than individual ID's based on confirmation received from users on 06/12/2017
********************************************************************************************************************************************/

REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('63','Pricing.StoresGroup@sherwin.com;ccnoracle.team@sherwin.com');


REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('STORE_PDH_HRCHY_MAIL','63','Price District Hierarchy Reporting for Stores Pricing Group','ccnoracle.team@sherwin.com','Please find attached the Price District Hierarchy Reporting details with this email.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('STORE_PDH_HRCHY_ERROR','25','Price District Hierarchy Reporting Process for Stores Pricing Group failed','ccnoracle.team@sherwin.com','Price District Hierarchy Reporting process for Stores Pricing Group failed - Please refer attachment for Error log file','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

commit;
