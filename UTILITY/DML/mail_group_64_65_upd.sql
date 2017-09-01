/*
Created : nxk927 CCN Project
          Updating the mail group for mail id 64 and 66.
*/
SELECT * FROM MAILING_DETAILS WHERE SUBJECT LIKE '%STORE BANK CARD%';
SELECT * FROM MAILING_GROUP WHERE GROUP_ID IN ('65','64');

UPDATE MAILING_GROUP
  SET MAIL_ID = 'smis@sherwin.com;ccnoracle.team@sherwin.com'
WHERE GROUP_ID in ('64','65');

SELECT * FROM MAILING_GROUP WHERE GROUP_ID IN ('65','64');

Commit;