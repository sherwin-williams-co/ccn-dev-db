/*
Below script add mollie to current store drafts outstanding emails

Created : 9/16/2019 jxc517 CCN Project Team....
Changed : 
*/
SELECT * FROM MAILING_GROUP WHERE GROUP_ID IN (20, 136);
UPDATE MAILING_GROUP SET MAIL_ID = MAIL_ID || ';Mollie.Haas@sherwin.com';
SELECT * FROM MAILING_GROUP WHERE GROUP_ID IN (20, 136);

COMMIT;