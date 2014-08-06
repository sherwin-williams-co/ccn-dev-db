create or replace PACKAGE errnums
/*********************************************************** 
This package will hold all error definitions for 
and system errors throughout the entire CCN applications

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

END errnums;