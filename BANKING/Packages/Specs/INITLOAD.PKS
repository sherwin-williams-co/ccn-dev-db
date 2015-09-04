CREATE OR REPLACE PACKAGE INITLOAD
AS
/**************************************************************** 
This package will load the new CCN BANKING Oracle Database
Created : 03/10/2015 nxk927 CCN Project....
Changed :
*****************************************************************/
FUNCTION GET_EXPIRATION_DATE(
/******************************************************************
   This Procedure gets the expiration date based on passed effective, expiration
   and previous records effective dates

Created : 08/12/2015 jxc517 CCN Project....
Changed :
******************************************************************/
IN_EFFECTIVE_DATE      IN    VARCHAR2,
IN_EXPIRATION_DATE     IN    VARCHAR2,
IN_PREV_EFFECTIVE_DATE IN    DATE) RETURN VARCHAR2;

PROCEDURE INITLOAD_SP
/******************************************************************
This Procedure is a wrapper for the Initial Load of the BANK tables
    * Deletes all the store drafts tables
    * Loads all the store drafts tables

Created : 03/10/2015 nxk927 CCN Project....
Changed :
******************************************************************/
;
END INITLOAD;

