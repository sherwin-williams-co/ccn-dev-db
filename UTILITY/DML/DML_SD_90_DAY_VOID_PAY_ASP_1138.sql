
/*
Below script will update Store Drafts 90 day void pay report email listing
from Joe Medina to Tom Beifuss

Created : 10/01/2018 kxm302 CCN Project Team....
Changed :
*/

SELECT * FROM MAILING_GROUP WHERE GROUP_ID = 39;
--1 Row(s) Selected
UPDATE MAILING_GROUP SET MAIL_ID = 'ccnoracle.team@sherwin.com;Katie.M.Pschesang@sherwin.com;tom.w.beifuss@sherwin.com' WHERE GROUP_ID = 39;
--1 Row(s) Updated
SELECT * FROM MAILING_GROUP WHERE GROUP_ID = 39;
--1 Row(s) Selected

COMMIT;