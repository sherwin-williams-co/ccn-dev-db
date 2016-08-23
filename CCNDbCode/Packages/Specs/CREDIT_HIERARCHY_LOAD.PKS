create or replace PACKAGE CREDIT_HIERARCHY_LOAD as 
/*******************************************************************************
This package is intended to load Credit Hierarchy files from mainframe into the 
HIERARCHY tables

created : 01/28/2016 sxh487927 CCN project
modified:
*******************************************************************************/

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

