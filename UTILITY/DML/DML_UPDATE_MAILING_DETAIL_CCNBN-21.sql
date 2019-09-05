/*
This script is created to update data into MAILING_GROUP table.

Created : 09/05/2019 sxs484 CCN Project CCNBN-21....
Modified: 
*/

SELECT * FROM MAILING_GROUP WHERE group_id =55;

UPDATE  MAILING_GROUP
   SET  MAIL_ID = MAIL_ID||';Shaun.J.Byrnes@sherwin.com'
 WHERE GROUP_ID =55 ;
 
SELECT * FROM MAILING_GROUP WHERE group_id =55;
 
-- Commit The Transaction
COMMIT; 