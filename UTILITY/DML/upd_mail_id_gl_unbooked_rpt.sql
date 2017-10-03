/*
     Created: 10/03/2017 axt754 CCN Project Team..
     This script creates updates,to mail_id's 
     for 'Installer G/L Unbooked Transactions Report'
*/
-- Following Query gives the mail_id's for 'Installer G/L Unbooked Transactions Report'
SELECT MG.MAIL_ID
  FROM MAILING_GROUP MG,
       MAILING_DETAILS MD
 WHERE MD.GROUP_ID = MG.GROUP_ID
   AND UPPER(MD.SUBJECT) = UPPER('Installer G/L Unbooked Transactions Report');
   
-- Anonymous block to update Mail_id
DECLARE
V_MAIL_REC MAILING_DETAILS%ROWTYPE;
BEGIN
   --GET MAILING_GROUP_ID for 'Installer G/L Unbooked Transactions Report'
    SELECT *
      INTO V_MAIL_REC
      FROM MAILING_DETAILS 
     WHERE UPPER(SUBJECT) = UPPER('Installer G/L Unbooked Transactions Report');
     
     --Update MAIL_ID to 'ccnoracle.team@sherwin.com;mary.f.kirkpatrick@sherwin.com'
     UPDATE MAILING_GROUP
        SET MAIL_ID = 'ccnoracle.team@sherwin.com;mary.f.kirkpatrick@sherwin.com'
      WHERE GROUP_ID = V_MAIL_REC.GROUP_ID;
      
    --Commit The transaction
    COMMIT;
END;
/
-- Following Query gives the mail_id's updated for 'Installer G/L Unbooked Transactions Report'
SELECT MG.MAIL_ID
  FROM MAILING_GROUP MG,
       MAILING_DETAILS MD
 WHERE MD.GROUP_ID = MG.GROUP_ID
   AND UPPER(MD.SUBJECT) = UPPER('Installer G/L Unbooked Transactions Report');
