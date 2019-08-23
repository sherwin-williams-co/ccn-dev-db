/*
This script is created to update data into MAILING_GROUP table.

Created : 08/23/2019 sxs484 CCN Project CCNCC-170....
Modified: 
*/

SELECT * FROM MAILING_GROUP WHERE group_id =86;

UPDATE  MAILING_GROUP
   SET  MAIL_ID = MAIL_ID||';lee.jones@sherwin.com'
 WHERE GROUP_ID =86 ;
 
SELECT * FROM MAILING_GROUP WHERE group_id =86;
 
-- Commit The Transaction
COMMIT; 