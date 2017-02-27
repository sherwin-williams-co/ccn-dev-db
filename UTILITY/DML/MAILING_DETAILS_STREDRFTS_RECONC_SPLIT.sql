/*********************************************************************************************
 Created: 02/27/2017 axt754 CCN Project Team....
          Mailing details for the store drafts Daily Reconcilation split
**********************************************************************************************/
SET SCAN OFF;
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('SUNTRUST DRAFT MAINT RECORDS WRITTEN - STBD1300','12','SUNTRUST DRAFT MAINT RECORDS WRITTEN SPLIT From Daily Reconcilation details','ccnoracle.team@sherwin.com','Please find SUNTRUST DRAFT MAINT RECORDS WRITTEN Records split.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('SUNTRUST DRAFT AUDIT RECORDS READ - STBD1300','12','SUNTRUST DRAFT AUDIT RECORDS READ SPLIT From Daily Reconcilation details','ccnoracle.team@sherwin.com','Please find SUNTRUST DRAFT AUDIT RECORDS READ Records split.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT;