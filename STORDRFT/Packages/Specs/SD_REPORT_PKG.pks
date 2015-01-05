create or replace 
PACKAGE SD_REPORT_PKG AS 
/*********************************************************** 
This package contains the core logic to load STORE_DRAFT_REPORTS  table

Created : 12/04/2014 jxc517 and nxk927 CCN Project Team.....
Modified: 
************************************************************/

PROCEDURE CCN_HIERARCHY_INFO
/**********************************************************
This procedure is for truncating the CCN_HIERARCHY_INFO  table
and pull the updated data from the HIERARCHY_DETAIL_VIEW

Created : 03/04/2014  nxk927 CCN Project Team.....
**********************************************************/
;

FUNCTION GET_RQSTD_ATTRIBUTE_VALUE(
/***********************************************************
This Procedure will get the requested attribute value for from
the passed UPPER_LVL_VER_DESC XML
      
NEVER DELETE THIS PROCEDURE AS "REPORT_HRCHY_EMP_DTLS_VW" VIEW USES THIS PROCEDURE
      
Created : 08/14/2014 nxk927 CCN Project.....
Modified: 12/04/2014 jxc517 CCN Project Team.....
          COmments were added as this is not used here in the package but used in view
************************************************************/
    IN_UPPER_LVL_VER_VALUE  IN     HIERARCHY_DETAIL.UPPER_LVL_VER_VALUE%TYPE,
    IN_ATTRIBUTE_NAME       IN     VARCHAR2) RETURN VARCHAR2;

FUNCTION CC_MANAGER(
/***********************************************************
This Function will get the requested manager name for the cost center
      
Created :  08/14/2014 nxk927 CCN Project.....
Modified:
************************************************************/
    IN_COST_CENTER_CODE EMPLOYEE_DETAILS.COST_CENTER_CODE%TYPE) RETURN VARCHAR2;

FUNCTION GET_MANAGER_NAME(
/***********************************************************
This function contains the core logic to get the manager name
for the passed division/area/district combinations

Created : 12/04/2014 jxc517 CCN Project Team.....
Modified: 
************************************************************/
    IN_HRCHY_HDR_NAME  IN     HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE,
    IN_LEVEL_VALUE     IN     VARCHAR2) RETURN VARCHAR2;

PROCEDURE SD_UNBOOK_RCRDS_OUTSIDE_RANGE(
/**********************************************************
This is the core procedure that gets invoked for eliminating the
records with accumulated labor - accumulated draft per line item 
outside the given range of -500 and 500

Created : 01/05/2015 jxc517 CCN Project Team.....
Modified: 
**********************************************************/
    IN_END_DATE     IN     DATE);

PROCEDURE SD_REPORT_QUERY(
/**********************************************************
This is the core procedure that gets invoked for loading the data

Created : 12/04/2014 jxc517 CCN Project Team.....
Modified: 
**********************************************************/
    IN_END_DATE IN DATE);

END SD_REPORT_PKG;