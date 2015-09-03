create or replace PACKAGE PRICE_DIST_HRCHY_LOAD
/*******************************************************************************
This package is intended to load price district files from mainframe into the 
HIERARCHY tables

created : 08/29/2015 nxk927 CCN project
modified:
*******************************************************************************/
AS
PROCEDURE PRICE_DSTRCT_HIER_LOAD_MAIN_SP
/******************************************************************
This Procedure is a wrapper for the Pricing district Hierarchy Load.
This Procedure
    * Disables all the Triggers for HIERARCHY_DETAIL Table
    * Loads the HIERARCHY_HEADER,HIERARCHY_DESCRIPTION, INTERMEDIATE  tables
    * Loads the HIERARCHY_DETAIL table with the price district data
    * Re-Enables the Triggers

created : 08/29/2015 nxk927 CCN project
modified:
******************************************************************/
;
PROCEDURE CREATE_PRICE_DISTRICT_FILE
/******************************************************************************
This Procedure create file on the server for the price district hierarchy only for 
second level

created : 08/29/2015 nxk927 CCN project
modified:
*******************************************************************************/
;
END PRICE_DIST_HRCHY_LOAD;