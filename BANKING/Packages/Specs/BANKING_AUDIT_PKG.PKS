create or replace PACKAGE BANKING_AUDIT_PKG AS
/*********************************************************** 
This package has procedures and functions related to the audit_log table

Created : 09/15/2015 jcx517 CCN project....
Changed : 
************************************************************/

PROCEDURE SELECT_AUDIT_LOG
/*******************************************************
Selects all rows from audit_log that have changed from
the last run of the backfeed process

Created : 09/15/2015 jcx517 CCN project....
Changed : 
*******************************************************/
;  

END BANKING_AUDIT_PKG;