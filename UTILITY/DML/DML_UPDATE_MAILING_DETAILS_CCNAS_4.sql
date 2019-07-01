/*********************************************************************************************
Replace CCN Project Oracle Development Group with CCN Application Support Group in production.
Created : 07/01/2019 axm868 -- CCNAS-4
**********************************************************************************************/

UPDATE MAILING_GROUP
   SET MAIL_ID = 'ccnsupport.team@sherwin.com';
   
COMMIT;