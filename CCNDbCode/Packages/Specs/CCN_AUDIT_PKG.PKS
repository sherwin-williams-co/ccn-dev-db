create or replace
PACKAGE CCN_AUDIT_PKG AS
/*********************************************************** 
This package has procedures and functions related to the audit_log table

created : 02/29/2012 tal CCN project
revisions: 

************************************************************/

FUNCTION XML_TO_STRING

/*******************************************************
Function to Return pipe delimited string (key value 
concatenated) based on the input key XML 

created : 06/07/2012
*******************************************************/

( 
  IN_Table_Name 	IN 	VARCHAR2
, IN_XML_KEY 		IN 	XMLTYPE
)
  RETURN VARCHAR2;
  
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

);
    
END CCN_AUDIT_PKG;