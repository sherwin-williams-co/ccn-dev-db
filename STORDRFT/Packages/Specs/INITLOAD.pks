create or replace PACKAGE initLoad
/**************************************************************** 
This package will load the new CCN Store Drafts Oracle Database
created : 04/29/2013 jxc517 CCN Project....
changed :
*****************************************************************/
IS

PROCEDURE CCN_SD_INITLOAD_SP
/******************************************************************
This Procedure is a wrapper for the Initial Load of the store drafts tables
    * Deletes all the store drafts tables
    * Loads all the store drafts tables

created : 04/29/2013 jxc517 CCN Project....
changed :
******************************************************************/
;

END initLoad;

