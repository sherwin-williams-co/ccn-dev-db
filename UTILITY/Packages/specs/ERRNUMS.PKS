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
END errnums;

