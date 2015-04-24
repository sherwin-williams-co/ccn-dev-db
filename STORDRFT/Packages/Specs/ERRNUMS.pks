create or replace PACKAGE errnums
/*********************************************************** 
This package will hold all error definitions for 
and system errors throughout the entire CCN applications

THIS PACKAGE CONTAINS ERROR NUMBERS FROM -20000 ONWARDS

created : 04/29/2014 jxc517 CCN Project
revisions: 

************************************************************/
IS
/*********************************************************** 
The "code_detail_val_size_err" passes a numerical error of -20023.
This error will be used when the Size of the code detail value exceeds
the value defined in the code header.

created : 04/29/2014 jxc517 CCN Project
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

created : 09/12/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_pay_indicator_set_err CONSTANT NUMBER := -20024;
exc_pay_indicator_set_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_pay_indicator_set_err , -20024);

/*********************************************************** 
The "mnl_drft_check_nbr_err" passes a numerical error of -20025.
This error will be used UI passes manual draft check number > 4 charactes.

created : 09/12/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_mnl_drft_check_nbr_err CONSTANT NUMBER := -20025;
exc_mnl_drft_check_nbr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_mnl_drft_check_nbr_err , -20025);

/*********************************************************** 
The "mntnc_not_allwd_twice_err" passes a numerical error of -20026.
This error will be used if there is a maintenance done twice on 
a regular draft in a single day

created : 09/29/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_mntnc_not_allwd_twice_err CONSTANT NUMBER := -20026;
exc_mntnc_not_allwd_twice_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_mntnc_not_allwd_twice_err , -20026);

/*********************************************************** 
The "gl_prime_accnt_nbr_err" passes a numerical error of -20027.
This error will be used if there is a gl_account passed with
prime account number not equal to 4 characters

created : 11/04/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_gl_prime_accnt_nbr_err CONSTANT NUMBER := -20027;
exc_gl_prime_accnt_nbr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_gl_prime_accnt_nbr_err , -20027);

/*********************************************************** 
The "gl_sub_accnt_nbr_err" passes a numerical error of -20028.
This error will be used if there is a gl_account passed with
sub account number not equal to 3 characters

created : 11/04/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_gl_sub_accnt_nbr_err CONSTANT NUMBER := -20028;
exc_gl_sub_accnt_nbr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_gl_sub_accnt_nbr_err , -20028);

/*********************************************************** 
The "mntnc_not_allwd_twice_wrn" passes a numerical error of -20029.
This warning will be used if there is a maintenance done twice on 
a manual draft in a single day

created : 12/10/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_mntnc_not_allwd_twice_wrn CONSTANT NUMBER := -20029;
exc_mntnc_not_allwd_twice_wrn EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_mntnc_not_allwd_twice_wrn , -20029);

/*********************************************************** 
The "dup_store_draft_err" passes a numerical error of -20030.
This warning will be used if there is a maintenance done twice on 
a manual draft in a single day

created : 12/30/2014 jxc517 CCN Project
revisions: 

************************************************************/
en_dup_store_draft_err CONSTANT NUMBER := -20030;
exc_dup_store_draft_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_dup_store_draft_err , -20030);

/*********************************************************** 
The "wrong_filter_err" passes a numerical error of -20031.
This error raises if the filtering options selected by user are wrong

created : 04/16/2015 jxc517 CCN Project
revisions: 

************************************************************/
en_wrong_filter_err CONSTANT NUMBER := -20031;
exc_wrong_filter_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(exc_wrong_filter_err , -20031);


END errnums;

