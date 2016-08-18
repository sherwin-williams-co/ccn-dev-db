create or replace PACKAGE          CCN_HIERARCHY_FUTURE
AS

/*********************************************************** 
This package contains procedures/functions to deal with
hierarchy future records

Created : 03/24/2016 jxc517 CCN Project....
Modified:
************************************************************/

TYPE REF_CURSOR IS REF CURSOR;

FUNCTION IS_FUTURE_HIERARCHY_DETAIL_REC(
/***********************************************************
This function will check if the passed record is a future record
A record is considered future, if it is at Cost Center level and 
effective date is in future
      
Created : 03/31/2016 jxc517 CCN Project Team....
Modified: 
************************************************************/
    IN_HIERARCHY_DETAIL_REC     IN     HIERARCHY_DETAIL_FUTURE%ROWTYPE)
RETURN VARCHAR2;

PROCEDURE INSERT_HIERARCHY_DETAIL_FUTURE(
/***********************************************************
This procedure will insert the record into future and expire the same record
if it is linked to some other hierarchy in current tables
      
Created : 03/31/2016 jxc517 CCN Project Team....
Modified: 
************************************************************/
    IN_HIERARCHY_DETAIL_REC     IN     HIERARCHY_DETAIL_FUTURE%ROWTYPE);

PROCEDURE DELETE_HIERARCHY_DETAIL_FUTURE(
/***********************************************************
This procedure will delete the fututre record passed in and un-expire the same record
if it is linked to some other hierarchy in current tables
      
Created : 04/04/2016 jxc517 CCN Project Team....
Modified: 
************************************************************/
    IN_HIERARCHY_DETAIL_REC     IN     HIERARCHY_DETAIL_FUTURE%ROWTYPE);

END CCN_HIERARCHY_FUTURE;