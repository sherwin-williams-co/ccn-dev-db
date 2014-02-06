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

  -- update
FUNCTION XML_EXTRACT_NO_EXCEPTION
/**********************************************************
This function returns null if XPATH does not exist within xml, 
this throws an exception if not handled this way
**********************************************************/
( p_xml IN XMLTYPE
, p_xpath IN VARCHAR2
)  RETURN VARCHAR2;
   
PROCEDURE PARSE_DIFFERENCE_XML
( IN_TABLE_NAME IN VARCHAR2
, IN_KEY        IN VARCHAR2
, OUT_CC_CODE 	OUT VARCHAR2
, OUT_CHANGE_TYPE OUT VARCHAR2
, OUT_DIFF OUT XMLTYPE
, OUT_LOG_ID OUT NUMBER
 );    

PROCEDURE Build_File_SP (
/**********************************************************
	Build_File_SP

	This procedure is intended to build a file based on the table layout
	in order to be consumed by the Mainframe to backfill Legacy MainFrame

	CostCenter - Cost Center that changed
	OracleTableName -Table name for row
	varible (based on the table that was updated)


created : 02/21/2012 kdp CCN Project....
**********************************************************/
IN_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE
,IN_TABLE_NAME IN VARCHAR2
,in_ROW_DATE   IN DATE
,IN_ROW_DATA    IN SYS.XMLTYPE
,in_CHANGE_TYPE in VARCHAR2
,in_LOG_ID      in NUMBER
);

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

