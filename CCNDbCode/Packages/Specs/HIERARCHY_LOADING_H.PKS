CREATE OR REPLACE PACKAGE HIERARCHY_LOADING_H as 
/*********************************************************** 
This package is intended to load files from mainframe into the 
HIERARCHY tables

created : 08/12/2013 SH CCN project
************************************************************/
   
      
PROCEDURE GLOBAL_HIERARCHY_LOAD
/**********************************************************
GLOBAL_HIERARCHY_LOAD

created : 08/12/2013 SH CCN Project....
**********************************************************/
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
(IN_BATCH_FLAG        VARCHAR2);

END HIERARCHY_LOADING_H;

