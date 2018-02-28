create or replace package CCN_ADMIN_TYPE_CC_LOAD AS 
/****************************************************************************** 
This package is intended to init load on "ALLOCATION_CC" and "DIVISION_OFFSET"
on "ADMINISTRATION" Table. 

Created : 01/17/2018 axt754 -- CCN Project Team...
Changed : 
******************************************************************************/

PROCEDURE INIT_LOAD_PROCESS
/****************************************************************************** 
This procedures takes care of following things as part of init load process
  # Reads the data from external table
  # Updates the Data into "ALLOCATION_CC" and "DIVISION_OFFSET" for "ADMINISTRATION" table
Created : 01/17/2018 axt754 -- CCN Project Team
Changes : 
******************************************************************************/
;

END CCN_ADMIN_TYPE_CC_LOAD;