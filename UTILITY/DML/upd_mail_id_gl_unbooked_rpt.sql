/*
     Created: 10/03/2017 axt754 CCN Project Team..
	 Revised: 08/02/2018 kxm302 CCN Project Team..
              Update email id from Mary F. Kirkpatrick to Marissa Papas
     This script updates,to mail_id's
     for 'Installer G/L Unbooked Transactions Report'
*/
-- Following Query gives the mail_id's for 'Installer G/L Unbooked Transactions Report'
SELECT MG.*
  FROM MAILING_GROUP MG,
       MAILING_DETAILS MD
 WHERE MD.GROUP_ID = MG.GROUP_ID
   AND UPPER(MD.SUBJECT) = UPPER('Installer G/L Unbooked Transactions Report');
   
-- Update MAIL_ID to 'ccnoracle.team@sherwin.com;marissa.papas@sherwin.com'
UPDATE MAILING_GROUP
   SET MAIL_ID = 'ccnoracle.team@sherwin.com;marissa.papas@sherwin.com'
 WHERE GROUP_ID = 26; -- '26' is for 'Installer G/L Unbooked Transactions Report'
      
--Commit The transaction
COMMIT;

-- Following Query gives the mail_id's updated for 'Installer G/L Unbooked Transactions Report'
SELECT MG.MAIL_ID
  FROM MAILING_GROUP MG,
       MAILING_DETAILS MD
 WHERE MD.GROUP_ID = MG.GROUP_ID
   AND UPPER(MD.SUBJECT) = UPPER('Installer G/L Unbooked Transactions Report');