create or replace PACKAGE CCN_HIERARCHY_FILE_GEN_PKG AS
  
PROCEDURE GENERATE_COSTCNTR_HRCHY_FILE(
/**********************************************************
This procedure is intended to generate an excel file with all hierarchy details and email it to user.
The hierarchies should be separated by work sheets rather than individual excels for each hierarchy.
cost center code is passed as a parameter.
Filters:
Created : 06/28/2018 pxa852 CCN project Team....
**********************************************************/
in_COST_CENTER_CODE       IN     VARCHAR2);

END CCN_HIERARCHY_FILE_GEN_PKG;