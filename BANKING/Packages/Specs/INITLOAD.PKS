CREATE OR REPLACE PACKAGE INITLOAD
AS
/**************************************************************** 
This package will load the new CCN BANKING Oracle Database
Created : 03/10/2015 nxk927 CCN Project....
Changed :
*****************************************************************/
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

