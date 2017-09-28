create or replace PACKAGE POS_SD_DAILY_LOAD
/****************************************************************
This package will load the Temp CCN Store Drafts tables
created : 05/03/2016 nxk927 CCN Project....
changed :
*****************************************************************/
AS

PROCEDURE POS_SD_DAILY_LOAD_SP
/******************************************************************
This Procedure is a wrapper for the Initial Load of the store drafts tables

created : 06/10/2017 nxk927 CCN Project....
changed : 09/28/2017 nxk927 CCN Project....
          Removed the in_date parameter
******************************************************************/
;

END POS_SD_DAILY_LOAD;