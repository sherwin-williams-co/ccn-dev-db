/*
This script is created to update data into MAILING_GROUP table.

Created : 09/06/2019 sxs484 CCN Project CCNSD-39....
Modified: 
*/

SELECT * FROM MAILING_GROUP WHERE group_id =19;
 
 UPDATE  MAILING_GROUP
   SET  MAIL_ID =replace(mail_id,'william.n.heideman@sherwin.com','Brandon.Koprowski@sherwin.com')
 WHERE GROUP_ID =19 ;
 
SELECT * FROM MAILING_GROUP WHERE group_id =19;
 
-- Commit The Transaction
COMMIT; 

/*
