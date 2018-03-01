/********************************************************************************** 
This script is to update the data into MAILING_DETAILS table(Updated the Subject).

Created  : 12/21/2017 sxg151 CCN Project 
Modified : 
**********************************************************************************/

update MAILING_DETAILS
set Subject = 'Store Bank Deposit Reconciliation Data.'
where Group_Id = 41;

update MAILING_DETAILS
set Subject = 'Store Bank Deposit Reconciliation Data Process Failed.'
where Group_Id = 40;

update MAILING_DETAILS
set Subject = 'Store Bank Deposit Reconciliation Data Process Done.'
where Group_Id = 39;

COMMIT;