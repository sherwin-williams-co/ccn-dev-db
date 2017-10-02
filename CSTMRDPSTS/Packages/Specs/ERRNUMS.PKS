create or replace PACKAGE ERRNUMS
AS
/*********************************************************** 
This package will hold all error definitions for 
and system errors throughout the entire Banking application

THIS PACKAGE CONTAINS ERROR NUMBERS FROM -20000 ONWARDS

Created : 09/29/2017 sxh487 CCN Project....
************************************************************/

/*********************************************************** 
The "dup_mainframe_costcntr_err" passes a numerical error of -20042.
This error will state that the entered new cost center has same 
last 4 characters as one already existing in the system. 

created : 09/27/2017 sxh487 CCN Project Team...
revisions: 
************************************************************/
en_dup_mainframe_costcntr_err CONSTANT NUMBER := -20042;
exc_dup_mainframe_costcntr_err EXCEPTION;
PRAGMA EXCEPTION_INIT
(EXC_DUP_MAINFRAME_COSTCNTR_ERR , -20042);

END ERRNUMS;