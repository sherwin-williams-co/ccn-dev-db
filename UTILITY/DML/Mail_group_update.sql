/*
Below script will remove charles from the mailing group

Created : 10/05/2017 nxk927 CCN Project Team....
Modified:
*/
SELECT * FROM MAILING_GROUP WHERE GROUP_ID = '5';
--1 Row(s) Selected
UPDATE MAILING_GROUP
   SET MAIL_ID = 'ccnoracle.team@sherwin.com;pmmalloy@sherwin.com;lboyd@sherwin.com;Sanjeeth.Duvuru@sherwin.com'
 WHERE GROUP_ID = 5;
--1 Row(s) Updated

COMMIT;

