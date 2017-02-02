/*********************************************************************************************************************************************
Created: AXK326 02/02/2017
         Replacing Bradley Henderson from the GROUP_ID 20 which is for "OUTSTANDING DRAFT EXCEL SHEET FOR DIVISION C400" with Kathleen Dickey
         Replaced bradley.henderson@sherwin.com with kathleen.m.dickey@sherwin.com
*********************************************************************************************************************************************/
SELECT * FROM MAILING_GROUP WHERE GROUP_ID = '20';

UPDATE MAILING_GROUP
   SET MAIL_ID = 'ccnoracle.team@sherwin.com;kathleen.m.dickey@sherwin.com'
 WHERE GROUP_ID = '20';

COMMIT;

SELECT * FROM MAILING_GROUP WHERE GROUP_ID = '20';
