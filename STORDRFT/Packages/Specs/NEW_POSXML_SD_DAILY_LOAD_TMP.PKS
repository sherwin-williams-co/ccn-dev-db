create or replace PACKAGE NEW_POSXML_SD_DAILY_LOAD_TMP
/****************************************************************
This package will load the Temp CCN Store Drafts tables
created : 05/03/2016 AXK326 CCN Project....
changed :
*****************************************************************/
AS

PROCEDURE POSXML_SD_DAILY_LOAD_SP(
/******************************************************************
This Procedure is a wrapper for the Initial Load of the store drafts tables
created : 05/03/2016 axk326 CCN Project....
changed :
******************************************************************/
IN_DATE DATE
);

END NEW_POSXML_SD_DAILY_LOAD_TMP;