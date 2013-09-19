PACKAGE AUDIT_LOG_DIFF AS
/*********************************************************** 
This package has procedures and functions related to the audit_log table

created : 02/29/2012 tal CCN project
revisions: 

************************************************************/

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
/*******************************************************
Procedure to Parse xmls from the audit_log table and 
create an output xml with the differences

Author   : OXD

versions : 02/22/2012
*******************************************************/
( IN_TABLE_NAME IN VARCHAR2
, IN_KEY        IN VARCHAR2
, OUT_DIFF OUT XMLTYPE
 );    
    
END AUDIT_LOG_DIFF;
/

