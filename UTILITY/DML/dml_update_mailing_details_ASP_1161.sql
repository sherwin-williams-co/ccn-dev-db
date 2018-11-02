/*******************************************************************************
Remove Kathleen M. Dickey from this distribution list and add Joseph P. Zbiegien
Created : 11/02/2018 sxg151 --ASP-1161
*******************************************************************************/

SELECT * FROM  MAILING_GROUP WHERE GROUP_ID = '20';

UPDATE MAILING_GROUP
SET MAIL_ID = 'ccnoracle.team@sherwin.com;joseph.p.zbiegien@sherwin.com' 
WHERE GROUP_ID = '20';
COMMIT;

SELECT * FROM  MAILING_GROUP WHERE GROUP_ID = '20';

