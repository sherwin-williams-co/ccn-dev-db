/*********************************************************************************************
 Created: 02/22/2016 MXR916 CCN Project Team....
          Mailing details for the store drafts QRTLY report is added.
**********************************************************************************************/
SET SCAN OFF;
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('STORE_DRAFT_QRTLY_REPORT','21','STORE DRAFT 1099 QRTLY REPORT','Keith.D.Parker@sherwin.com','Please find the attached SD 1099 QRTLY Report.','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT;