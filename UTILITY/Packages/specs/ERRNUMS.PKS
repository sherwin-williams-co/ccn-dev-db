create or replace PACKAGE errnums
/*********************************************************** 
This package will hold all error definitions for 
and system errors throughout the entire CCN applications

THIS PACKAGE CONTAINS ERROR NUMBERS FROM -20900 ONWARDS

created : 07/19/2014 jxc517 CCN Project
revisions: 

************************************************************/
IS

/*********************************************************** 
The "xxxxxxxx" passes a numerical error of -20900.
This error will be used when xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.

created : 07/99/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_xxxxxxxx CONSTANT NUMBER := -20900;
exc_xxxxxxxx EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_xxxxxxxx , -20900);

/***********************************************************
The "en_cc_not_approved_for_polling_exp" passes a numerical error of -20228.
If user try to trigger pos downloads for a cost center which
is not approved for polling then this error will raise.

created : 03/08/2019 pxa852 CCN Project Team...
revisions:
************************************************************/
en_cc_not_approved_for_polling CONSTANT NUMBER := -20228;
exc_cc_not_approved_for_polling EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_cc_not_approved_for_polling , -20228);

/***********************************************************
The "en_pos_download_exists_err" passes a numerical error of -20229.
If user try to trigger pos downloads for a cost center which is already exists
in POS downloads table with the file processed flag 'N'
then raise this error to user that POS Download already exists for this cost center.

created : 03/18/2019 pxa852 CCN Project Team...
revisions:
************************************************************/
en_pos_download_exists_err CONSTANT NUMBER := -20229;
exc_pos_download_exists_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_pos_download_exists_err , -20229);

END errnums;