/*
Below script will replace marcy.lee@sherwin.com to marcy.strojin@sherwin.com

Created : 01/03/2019 sxg151 CCN Project Team....
Modified:
*/
SELECT * FROM MAILING_GROUP WHERE GROUP_ID = '72';

UPDATE MAILING_GROUP
   SET MAIL_ID = 'ccnoracle.team@sherwin.com;marcy.strojin@sherwin.com;smis@sherwin.com'
 WHERE GROUP_ID = '72';


SELECT * FROM MAILING_GROUP WHERE GROUP_ID = '124';

UPDATE MAILING_GROUP
   SET MAIL_ID = 'ccnoracle.team@sherwin.com;marcy.strojin@sherwin.com'
 WHERE GROUP_ID = '124';

COMMIT;
