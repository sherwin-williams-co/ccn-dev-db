create or replace PACKAGE CCN_EMPLOYEE_DETAILS_PKG 
IS
/*********************************************************** 
This package will contain all the procedures required to  work with employee details

Created : 06/16/2014 jxc517 CCN Project....
Changed : 
************************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE EMPLOYEE_DETAILS_S_SP (
/*******************************************************************************
	EMPLOYEE_DETAILS_S_SP

	This procedure is intended to select records from EMPLOYEE_DETAILS table

Created : 06/16/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);
END CCN_EMPLOYEE_DETAILS_PKG;

