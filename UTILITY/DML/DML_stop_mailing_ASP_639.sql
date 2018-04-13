/******************************************************************************************************************* 
Below script is created to delete MAIL_CATEGORY To stop sending emails to SIMS Group .
Created : 04/13/2018 sxg151 CCN Project ASP-639....
********************************************************************************************************************/

SELECT * FROM MAILING_DETAILS WHERE GROUP_ID in (40,41);
SELECT * FROM MAILING_GROUP   WHERE GROUP_ID in (40,41);

DELETE MAILING_DETAILS WHERE GROUP_ID in (40,41);
DELETE MAILING_GROUP   WHERE GROUP_ID in (40,41);

COMMIT;

SELECT * FROM MAILING_DETAILS WHERE GROUP_ID in (40,41);
SELECT * FROM MAILING_GROUP   WHERE GROUP_ID in (40,41);


