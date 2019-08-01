/*
This script is created to update data into MAILING_GROUP table.

Created : 08/01/2019 sxs484 CCN Project CCNCC-157....
Modified: 
*/

SELECT * FROM MAILING_GROUP WHERE group_id =86;

UPDATE  MAILING_GROUP
   SET  MAIL_ID = MAIL_ID||';tasacerich@sherwin.com'
 WHERE GROUP_ID =86 ;
 
SELECT * FROM MAILING_GROUP WHERE group_id =86;
 
-- Commit The Transaction
COMMIT; 