/*
Below script replace Marissa A Papas <Marissa.Papas@sherwin.com> with Jeremy Howe <Jeremy.Howe@sherwin.com>

Created : 9/23/2019 jxc517 CCN Project Team....
Changed : 
*/
SELECT * FROM MAILING_GROUP WHERE GROUP_ID IN (26);
UPDATE MAILING_GROUP SET MAIL_ID = REPLACE(MAIL_ID,'marissa.papas@sherwin.com','Jeremy.Howe@sherwin.com') WHERE GROUP_ID IN (26);
SELECT * FROM MAILING_GROUP WHERE GROUP_ID IN (26);

COMMIT;
