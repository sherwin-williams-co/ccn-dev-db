create or replace PACKAGE CREDIT_HIERARCHY_LOAD as 
/*******************************************************************************
This package is intended to load Credit Hierarchy files from mainframe into the 
HIERARCHY tables

created : 01/28/2016 sxh487927 CCN project
modified:
*******************************************************************************/

PROCEDURE LOAD_CODE_DETAIL
/*******************************************************************************
  This procedure will insert data from the lookup tables into CODE_DETAIL table.
  
  
created : 07/25/2016 vxv336 CCN Project
          The REFCURSOR in this procedure gives it the potential to be used for 
          other hierarchies as well.
*******************************************************************************/
 ( in_sourcetable  IN VARCHAR2 );
   
PROCEDURE ALTER_HIER_TRIGGERS   
/*******************************************************************************
	ALTER_HIER_TRIGGERS   --    Alter Hierarchy table(s) triggers

  This procedure will enable and/or disable Hierarchy table(s) triggers based on an
  input "status" parameter.  
	  
created : 08/12/2013 SH CCN Project....
*******************************************************************************/
 ( IN_STATUS  IN VARCHAR2 );
    
PROCEDURE CREDIT_HIER_HDR_DESC_LOAD
/*******************************************************************************
This Procedure Loads HIERARCHY_HEADER and HIERARCHY_DESCRIPTION for credit hierarchy
before loading the files from Mainframe into hierarchy_detail table

created : 01/07/2016 sxh487 CCN project
modified:
*******************************************************************************/ 
;

PROCEDURE CREDIT_HIERARCHY_LOAD_MAIN
/******************************************************************************
This Procedure Loads the hierarchy_detail table with the 6 level Credit hierarchy
This procedure will build the necesarry  levels and will be loaded in the main table

created : 01/07/2016 sxh487 CCN project
modified:
*******************************************************************************/
;

PROCEDURE CREDIT_HIERARCHY_LOAD_MAIN_SP
/******************************************************************
This Procedure is a wrapper for the Credit Hierarchy Load.
This Procedure
    * Disables all the Triggers for HIERARCHY_DETAIL Table
    * Loads the HIERARCHY_HEADER,HIERARCHY_DESCRIPTION, INTERMEDIATE  tables
    * Loads the HIERARCHY_DETAIL table with the Credit Hierarchy data
    * Re-Enables the Triggers

created : 02/12/2016 sxh487 CCN project
modified:
******************************************************************/
;

END CREDIT_HIERARCHY_LOAD;