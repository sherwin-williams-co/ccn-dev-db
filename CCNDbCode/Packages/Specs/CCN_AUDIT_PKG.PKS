create or replace PACKAGE CCN_AUDIT_PKG AS
/*********************************************************** 
This package has procedures and functions related to the audit_log table

created : 02/29/2012 tal CCN project
revisions: 

************************************************************/

PROCEDURE SELECT_HIERARCHY_AUDIT_LOG
/**********************************************************
SELECT_HIERARCHY_AUDIT_LOG

Selects all rows from audit_log that have changed from
the last run of the backfeed process for hierarchy_detail table alone

created : 10/20/2013 jxc517 CCN Project Team . . . 
modified : 02/05/2014 jxc517 CCN Project Team . . . 
**********************************************************/
;
  
PROCEDURE SELECT_AUDIT_LOG
/*******************************************************
Selects all rows from audit_log that have changed from
the last run of the backfeed process

created : 06/07/2012
*******************************************************/
;  

PROCEDURE AUDIT_FIELDS_IU(
/**********************************************************
	AUDIT_FIELDS_IU

	This procedure is intended to insert records into CCN_ADDITIONAL_AUDIT_FIELDS
  table based on the input XML type passed
  
  If record already exists, ignore
  If record doesn't exist, insert one accordingly

created : 02/05/2014 jxc517 CCN Project....
**********************************************************/
    IN_UPPER_LVL_VER_VALUE XMLTYPE);
    
END CCN_AUDIT_PKG;

