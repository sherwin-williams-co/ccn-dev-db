create or replace PACKAGE POS_SD_DAILY_LOAD
/****************************************************************
This package will load the Temp CCN Store Drafts tables
created : 05/03/2016 nxk927 CCN Project....
changed :
*****************************************************************/
AS

PROCEDURE POS_SD_DAILY_LOAD_SP(
/******************************************************************
This Procedure is a wrapper for the Initial Load of the store drafts tables

created : 05/03/2016 nxk927 CCN Project....
changed :
******************************************************************/
IN_DATE     IN DATE);

END POS_SD_DAILY_LOAD;