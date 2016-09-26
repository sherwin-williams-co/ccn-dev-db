/*
Below script will replace thanranga's email id with FACTS AP team

Created : 09/26/2016 jxc517 CCN Project Team....
Modified:
*/
SELECT * FROM MAILING_GROUP WHERE GROUP_ID = '27';
--1 Row(s) Selected
UPDATE MAILING_GROUP SET MAIL_ID = 'ccnoracle.team@sherwin.com;facts_ap@sherwin.com' WHERE GROUP_ID = '27';
--1 Row(s) Updated

COMMIT;
