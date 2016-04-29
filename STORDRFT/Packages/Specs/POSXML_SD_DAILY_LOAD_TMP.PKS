create or replace PACKAGE POSXML_SD_DAILY_LOAD_TMP 
/*********************************************************************************** 
This package will load the POSXML store drafts new temp tables.
created : 03/22/2016 axk326 CCN Project....
changed :
***********************************************************************************/
AS 

PROCEDURE POSXML_SD_DAILY_LOAD_SP(
/**********************************************************************************
This Procedure is a wrapper for the Initial Load of the POSXML store drafts new 
temp tables.

created : 03/22/2016 axk326 CCN Project....
changed :
**********************************************************************************/
IN_DATE DATE
);

END POSXML_SD_DAILY_LOAD_TMP;