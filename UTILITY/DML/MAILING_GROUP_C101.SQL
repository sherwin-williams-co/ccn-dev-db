/*
Below script will update the distribution list to remove
ronie.hopp@sherwin.com and add william.n.heideman@sherwin.com instead

Created: 09/02/2016 jxc517 CCN Project Team....
Modified:
*/

SELECT * FROM MAILING_GROUP WHERE GROUP_ID = 19;
--1 Row(s) Selected
UPDATE MAILING_GROUP SET MAIL_ID = 'ccnoracle.team@sherwin.com;william.n.heideman@sherwin.com' WHERE GROUP_ID = 19;
--1 Row(s) Updated

COMMIT;
