create or replace PACKAGE ERRNUMS
AS
/*********************************************************** 
This package will hold all error definitions for 
and system errors throughout the entire Customer Deposit application

THIS PACKAGE CONTAINS ERROR NUMBERS FROM -20000 ONWARDS

Created : 09/29/2017 sxh487 CCN Project....
************************************************************/

/*********************************************************** 
The "dup_mainframe_costcntr_err" passes a numerical error of -20001.
This error will state that the entered new cost center has same 
last 4 characters as one already existing in the system. 

created : 09/27/2017 sxh487 CCN Project Team...
revisions: 
************************************************************/
en_dup_mainframe_costcntr_err CONSTANT NUMBER := -20001;
exc_dup_mainframe_costcntr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(EXC_DUP_MAINFRAME_COSTCNTR_ERR , -20001);

/*********************************************************** 
The "en_invalid_account_nbr" passes a numerical error of -20002.
This error will check the valid account number 

created : 10/30/2017 sxg151 CCN Project Team...
        : ASP-1150
revisions: 
************************************************************/
en_invalid_account_nbr CONSTANT NUMBER := -20002;
exc_invalid_account_nbr EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_invalid_account_nbr , -20002);

/*********************************************************** 
The "en_hdr_det_acct_nbr_missmatch_err" passes a numerical error of -20003.
If Header account missmatch with the Detail Account. 
created : 11/29/2018 sxg151 CCN Project Team...
          ASP-1150
************************************************************/
en_hdr_det_acct_nbr_mismatch_err CONSTANT NUMBER := -20003;
exc_hdr_det_acct_nbr_mismatch_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_hdr_det_acct_nbr_mismatch_err , -20003);

END ERRNUMS;