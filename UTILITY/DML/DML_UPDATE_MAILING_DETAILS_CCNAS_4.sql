/*********************************************************************************************
Replace CCN Project Oracle Development Group with CCN Application Support Group in production.
Created : 07/01/2019 axm868 -- CCNAS-4
**********************************************************************************************/

SELECT * FROM MAILING_GROUP;

SELECT * FROM MAILING_DETAILS;

UPDATE MAILING_GROUP
   SET MAIL_ID = REPLACE(MAIL_ID,'ccnoracle.team@sherwin.com','ccnsupport.team@sherwin.com');

UPDATE MAILING_DETAILS
   SET FROM_P = REPLACE(FROM_P,'ccnoracle.team@sherwin.com','ccnsupport.team@sherwin.com');

COMMIT;

SELECT * FROM MAILING_GROUP;

SELECT * FROM MAILING_DETAILS;