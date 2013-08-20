create or replace
PACKAGE HIERARCHY_LOADING_PKG as 
/*********************************************************** 
This package is intended to load files from mainframe into the 
HIERARCHY tables

created : 08/12/2013 SH CCN project
************************************************************/

PROCEDURE HEADER_DESCRIPTION_INS_SP
/*******************************************************************************
HEADER_DESCRIPTION_INS_SP - The Procedure Loads HIERARCHY_HEADER and HIERARCHY_DESCRIPTION
before loading the files from Mainframe

created : 08/19/2013 SH CCN Project....
*******************************************************************************/
;
   
PROCEDURE ALTER_HIER_TRIGGERS   
/*******************************************************************************
	ALTER_HIER_TRIGGERS   --    Alter Hierarchy table(s) triggers

  This procedure will enable and/or disable Hierarchy table(s) triggers based on an
  input "status" parameter.  
	  
created : 08/12/2013 SH CCN Project....
*******************************************************************************/
 ( IN_STATUS  IN VARCHAR2 );
       
PROCEDURE GLOBAL_HIERARCHY_LOAD
/**********************************************************
GLOBAL_HIERARCHY_LOAD

created : 08/12/2013 SH CCN Project....
**********************************************************/
;    

PROCEDURE ADMIN_TO_SALES_DIV_HIER_LOAD
/**********************************************************
ADMIN_TO_SALES_DIV_HIER_LOAD

created : 08/12/2013 SH CCN Project....
**********************************************************/ 
;

PROCEDURE ADMIN_TO_SALES_AREA_HIER_LOAD
/*******************************************************************************
	ADMIN_TO_SALES_AREA_HIER_LOAD

created : 08/12/2013 SH CCN Project.... 
*******************************************************************************/
;

PROCEDURE ADMIN_TO_SALES_DIST_HIER_LOAD
/**********************************************************
ADMIN_TO_SALES_DIST_HIER_LOAD

created : 08/12/2013 SH CCN Project.... 
*******************************************************************************/
;
                                                    
PROCEDURE LEGACY_GL_DIV_HIER_LOAD 
/******************************************************************************
LEGACY_GL_DIVISION

created : 08/12/2013 SH CCN Project.... 

*******************************************************************************/
; 

PROCEDURE ALTERNATE_DAD_HIER_LOAD
/******************************************************************************
ALTERNATE_DAD

created : 08/12/2013 SH CCN Project.... 

*******************************************************************************/
; 

PROCEDURE CITY_MANAGER_DAD_HIER_LOAD
/******************************************************************************
CITY_MANAGER_DAD

created : 08/12/2013 SH CCN Project.... 

*******************************************************************************/
; 

PROCEDURE FACTS_DIVISION_HIER_LOAD
/******************************************************************************
FACTS_DIVISION

created : 08/12/2013 SH CCN Project.... 

*******************************************************************************/
; 

PROCEDURE HIER_LOAD_MAIN_SP
/******************************************************************
This Procedure is a wrapper for the Hierarchy Load all the files from
mainframe in /app/ccn/datafiles into the hierarchy_detail table
This Procedure
    * Disables all the Triggers for hierarchy_detail Table
    * Deletes the hierarchy_detail table
    * Loads the hierarchy_detail table
    * Re-Enables the Triggers

Created: SH 05/06/2013
******************************************************************/
;

END HIERARCHY_LOADING_PKG;