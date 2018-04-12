/******************************************************************************************************************* 
Below script is created to delete MAIL_CATEGORY To stop sending emails to SIMS Group .
Created : 04/11/2018 sxg151 CCN Project ASP-1016....
********************************************************************************************************************/
SELECT * FROM MAILING_DETAILS WHERE GROUP_ID IN (64,65);
SELECT * FROM MAILING_GROUP WHERE GROUP_ID GROUP_ID IN (64,65);

DELETE MAILING_DETAILS WHERE GROUP_ID IN (64,65);
DELETE MAILING_GROUP WHERE GROUP_ID GROUP_ID IN (64,65);

SELECT * FROM MAILING_DETAILS WHERE GROUP_ID IN (64,65);
SELECT * FROM MAILING_GROUP WHERE GROUP_ID GROUP_ID IN (64,65);

COMMIT;