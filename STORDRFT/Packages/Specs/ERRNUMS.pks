create or replace PACKAGE errnums
/*********************************************************** 
This package will hold all error definitions for 
and system errors throughout the entire CCN applications

THIS PACKAGE CONTAINS ERROR NUMBERS FROM -20000 ONWARDS

created : 04/29/2011 jxc517 CCN Project
revisions: 

************************************************************/
IS
/*********************************************************** 
The "code_detail_val_size_err" passes a numerical error of -20023.
This error will be used when the Size of the code detail value exceeds
the value defined in the code header.

created : 04/29/2011 jxc517 CCN Project
revisions: 

************************************************************/
en_code_detail_val_size_err CONSTANT NUMBER := -20023;
exc_code_detail_val_size_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_code_detail_val_size_err , -20023);

/*********************************************************** 
The "pay_indicator_set_err" passes a numerical error of -20024.
This error will be used when user trys to change the draft details
after pay indicator is set.

created : 09/12/2011 jxc517 CCN Project
revisions: 

************************************************************/
en_pay_indicator_set_err CONSTANT NUMBER := -20024;
exc_pay_indicator_set_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_pay_indicator_set_err , -20024);

/*********************************************************** 
The "mnl_drft_check_nbr_err" passes a numerical error of -20025.
This error will be used UI passes manual draft check number > 4 charactes.

created : 09/12/2011 jxc517 CCN Project
revisions: 

************************************************************/
en_mnl_drft_check_nbr_err CONSTANT NUMBER := -20025;
exc_mnl_drft_check_nbr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_mnl_drft_check_nbr_err , -20025);

END errnums;

