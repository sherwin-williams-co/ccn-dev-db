/******************************************************************************************************************* 
Below script is created to delete MAIL_CATEGORY To stop sending emails to SIMS Group .
Created : 01/31/2018 sxg151 CCN Project ASP-894....
********************************************************************************************************************/

DELETE MAILING_DETAILS WHERE GROUP_ID = 28 and MAIL_CATEGORY = 'PCI_POS_TERMINAL_MISMATCH';
DELETE MAILING_GROUP WHERE GROUP_ID = 28;

COMMIT;