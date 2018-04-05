--updating MESSAGE for the square footage email
--sxh487 04/05/2018

UPDATE MAILING_DETAILS
   SET MESSAGE ='Please find the attachment that contains the reason for which cost centers lease/own code (or) sq footage update failed.',
   SUBJECT ='CCN Sq Footage Batch Process Error'
 WHERE GROUP_ID ='104';
 
COMMIT;