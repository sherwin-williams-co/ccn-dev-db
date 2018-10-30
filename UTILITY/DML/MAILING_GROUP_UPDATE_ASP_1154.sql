/**********************************************************************************
Below script  change mail_id for MAILING_GROUP from karen.e.wiker@sherwin.com
to katie.m.pschesang@sherwin.com
Created : kxm302 10/30/2018 CCN Project 
Modified:
**********************************************************************************/
SELECT * FROM MAILING_GROUP WHERE GROUP_ID = '120';

UPDATE MAILING_GROUP
   SET MAIL_ID = 'ccnoracle.team@sherwin.com;jessica.l.ator@sherwin.com;katie.m.pschesang@sherwin.com'
 WHERE GROUP_ID = '120';

COMMIT;

SELECT * FROM MAILING_GROUP WHERE GROUP_ID = '120';