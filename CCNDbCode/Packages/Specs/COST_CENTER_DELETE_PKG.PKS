create or replace PACKAGE COST_CENTER_DELETE_PKG AS 
/**********************************************************
This Package contains all the procedures used to deal with
removing/archiving a cost center from CCN database

Created : 03/16/2016 jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE DELETE_COST_CENTER
/**********************************************************
	This procedure is the core procedure that gets invoked
	for bulk cost center deletions from CCN application

created : 03/15/2016 jxc517 CCN Project Team...
modified: 
**********************************************************/;

END COST_CENTER_DELETE_PKG;