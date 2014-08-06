create or replace PACKAGE HIERARCHY_LOADING_HST_PKG
/*********************************************************** 
This package is intended to load files from mainframe into the 
HIERARCHY tables

created : 08/12/2013 SH CCN project
************************************************************/
AS

PROCEDURE LOAD_TEMP_TABLES
/*******************************************************************************
	LOAD_TEMP_TABLES   --    Loads all temporary teables before process start

created : 05/08/2014 CCN Project....
*******************************************************************************/
;
 
PROCEDURE GLOBAL_HIERARCHY_LOAD
/**********************************************************
GLOBAL_HIERARCHY_LOAD

created : 05/08/2014 CCN Project....
**********************************************************/
;

PROCEDURE ADMIN_TO_SALES_DIV_HIER_LOAD
/**********************************************************
ADMIN_TO_SALES_DIV_HIER_LOAD

created : 05/08/2014 CCN Project....
**********************************************************/ 
;

PROCEDURE ADMIN_TO_SALES_AREA_HIER_LOAD
/*******************************************************************************
	ADMIN_TO_SALES_AREA_HIER_LOAD

created : 05/08/2014 CCN Project.... 
*******************************************************************************/
;

PROCEDURE ADMIN_TO_SALES_DIST_HIER_LOAD
/**********************************************************
ADMIN_TO_SALES_DIST_HIER_LOAD

created : 05/08/2014 CCN Project.... 
*******************************************************************************/
;
                                                    
PROCEDURE LEGACY_GL_DIV_HIER_LOAD 
/******************************************************************************
LEGACY_GL_DIV_HIER_LOAD

created : 05/08/2014 CCN Project.... 

*******************************************************************************/
;

PROCEDURE ALTERNATE_DAD_HIER_LOAD
/******************************************************************************
ALTERNATE_DAD_HIER_LOAD

created : 05/08/2014 CCN Project.... 

*******************************************************************************/
;

PROCEDURE FACTS_DIVISION_HIER_LOAD
/******************************************************************************
FACTS_DIVISION_HIER_LOAD

created : 05/08/2014 CCN Project.... 

*******************************************************************************/
; 

PROCEDURE HIER_LOAD_MAIN_SP
/******************************************************************
This Procedure is a wrapper for the Hierarchy Load all the files from
mainframe in /app/ccn/datafiles into the HIERARCHY_DETAIL_HST table
This Procedure
    * Deletes the HIERARCHY_DETAIL_HST table
    * Loads the HIERARCHY_DETAIL_HST table
    * Re-Enables the Triggers

created : 05/08/2014 CCN Project.... 
******************************************************************/
;

END HIERARCHY_LOADING_HST_PKG;

