create or replace PACKAGE DEPOSITS_DAILY_LOAD
AS
/**************************************************************** 
This package will load the new CCN BANKING Oracle Database
with the files for deposit ticket and deposit bags along with their orders

NOTE: At one point this batch process will be obsolete

Created : 11/11/2015 jxc517 CCN Project....
Changed :
*****************************************************************/
FUNCTION GET_EXPIRATION_DATE(
/******************************************************************
   This Procedure gets the expiration date based on passed effective, expiration
   and previous records effective dates

Created : 11/11/2015 jxc517 CCN Project....
Changed :
******************************************************************/
IN_EFFECTIVE_DATE      IN    VARCHAR2,
IN_EXPIRATION_DATE     IN    VARCHAR2,
IN_PREV_EFFECTIVE_DATE IN    DATE) RETURN VARCHAR2;

PROCEDURE DEPOSITS_DAILY_LOAD_SP
/******************************************************************
This Procedure is a wrapper for the Initial Load of the BANK tables
    * Deletes store drafts tables related to deposit ticket and deposit bags
    * Loads store drafts tables related to deposit ticket and deposit bags

Created : 11/11/2015 jxc517 CCN Project....
Changed :
******************************************************************/
;
END DEPOSITS_DAILY_LOAD;

