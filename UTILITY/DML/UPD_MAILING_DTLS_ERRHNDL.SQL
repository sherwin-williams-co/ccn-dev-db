/*********************************************************************************************
 Created: 01/14/2016 AXK326 CCN Project Team....
          Mailing details for all the store drafts scripts when batch processing is in place
**********************************************************************************************/
SET SCAN OFF;
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('SD_BATCH_PROCESSING_ERROR','25','Failed Job in CCN Store Drafts Batch Processing Error','Keith.D.Parker@sherwin.com','Failed to perform daily batch process for CCN Store Drafts. ','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
COMMIT;