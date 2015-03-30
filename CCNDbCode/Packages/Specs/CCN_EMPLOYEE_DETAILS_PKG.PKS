create or replace PACKAGE CCN_EMPLOYEE_DETAILS_PKG 
IS
/*********************************************************** 
This package will contain all the procedures required to  work with employee details

Created : 06/16/2014 jxc517 CCN Project....
Changed : 
************************************************************/

TYPE REF_CURSOR IS REF CURSOR;


FUNCTION GET_JOB_CODE
/**********************************************************
 GET_JOB_CODE

Returns the job_code from the Translation table
created : 11/05/2014 sxh487 CCN Project....
**********************************************************/
(IN_JOB_TITLE  IN   JOB_CODE_TRANSALATION.JOB_TITLE_SEGMENT%TYPE,
 IN_JOB_FAMILY IN   JOB_CODE_TRANSALATION.JOB_FAMILY_SEGMENT%TYPE,
 IN_JOB_TYPE   IN   JOB_CODE_TRANSALATION.ORG_UNIT_NAME%TYPE
 )
RETURN VARCHAR2;

FUNCTION GET_COST_CENTER_CATEGORY
/**********************************************************
 GET_COST_CENTER_CATEGORY

Returns Category value for given Cost Center Code
created : 03/30/2015 sxh487 CCN Project....
**********************************************************/
(IN_COST_CENTER_CODE IN VARCHAR2) 
RETURN VARCHAR2;

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

PROCEDURE EMPLOYEE_ADMIN_DETAILS_S_SP (
/*******************************************************************************
	EMPLOYEE_ADMIN_DETAILS_S_SP

	This procedure is intended to select records from EMPLOYEE_ADMIN_DETAILS table

Created : 06/23/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE SYNC_EMPLOYEE_DETAILS
/*******************************************************************************
	SYNC_EMPLOYEE_DETAILS

	This procedure will compare the data with the gems view and current tables,
  insert any missing data and update any modified data accorigly

Created : 07/23/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
;

PROCEDURE EMPLOYEE_ADMIN_DETAILS_D_SP (
/*******************************************************************************
	EMPLOYEE_ADMIN_DETAILS_D_SP

	This procedure is intended to delete records from EMPLOYEE_ADMIN_DETAILS table

<?xml version="1.0" encoding="UTF-8" ?>
<EMPLOYEE_ADMIN_DETAILS_UI xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
<EMPLOYEE_ADMIN_DETAILS>
<EMPLOYEE_NUMBER>XXXXXXXXX</EMPLOYEE_NUMBER>
<ADMIN_COST_CENTER_CODE>XXXXXX</ADMIN_COST_CENTER_CODE>
<EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
<EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
<ADMIN_JOB_CODE>XXXXX</ADMIN_JOB_CODE>
<EMPLOYEE_FIRST_NAME>XXXXXXXXXXXXXXXXXXXX</EMPLOYEE_FIRST_NAME>
<EMPLOYEE_LAST_NAME>XXXXXXXXXXXXXXXXXXXX</EMPLOYEE_LAST_NAME>
<EMPLOYEE_MIDDLE_NAME>XX</EMPLOYEE_MIDDLE_NAME>
</EMPLOYEE_ADMIN_DETAILS>
</EMPLOYEE_ADMIN_DETAILS_UI>

Created : 07/24/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE EMPLOYEE_ADMIN_DETAILS_I_SP (
/*******************************************************************************
	EMPLOYEE_ADMIN_DETAILS_I_SP

	This procedure is intended to insert records into EMPLOYEE_ADMIN_DETAILS table

Created : 07/24/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE EMPLOYEE_ADMIN_DETAILS_U_SP (
/*******************************************************************************
	EMPLOYEE_ADMIN_DETAILS_U_SP

	This procedure is intended to updates records in EMPLOYEE_ADMIN_DETAILS table

Created : 07/24/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

END CCN_EMPLOYEE_DETAILS_PKG;