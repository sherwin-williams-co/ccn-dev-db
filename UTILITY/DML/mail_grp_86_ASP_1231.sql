/*
Below script will update the distribution list to add email id "tlseneski@sherwin.com" "matthew.j.sorin@sherwin.com"

Created: 03/21/2019 sxg151 CCN Project Team....
       : ASP-1231
Modified:
*/

SELECT * FROM MAILING_GROUP WHERE GROUP_ID = '86';

UPDATE MAILING_GROUP 
   SET MAIL_ID = 'ccnoracle.team@sherwin.com;psg.finplan@sherwin.com;fabio.disanza@sherwin.com;tlseneski@sherwin.com;matthew.j.sorin@sherwin.com' 
 WHERE GROUP_ID = '86';


SELECT * FROM MAILING_GROUP WHERE GROUP_ID = '86';

COMMIT;
