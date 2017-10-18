create or replace PACKAGE COMMON_TOOLS AS 
/*********************************************************** 
This package SPEC is intended to hold reuseable objects that are 
available to be used by the entire schema

created : 09/27/2017 sxh487 CCN project.....
************************************************************/

FUNCTION GET_CURR_RUNCYCLE
/******************************************************************
This function will return the current run cycle for the data to be
loaded from PNP

created : 09/27/2017 sxh487  CCN Project....
changed :
******************************************************************/
RETURN VARCHAR2;

FUNCTION GET_SALES_AMOUNT (
/**********************************************************
This function will return amt from PNP.ccn_accums table

parameters:
in_tran_guid
in_accum_id

created : 08/17/2017 sxp130 ccn project
modified:
**********************************************************/
   IN_TRAN_GUID   IN  PNP.CCN_ACCUMS.TRAN_GUID%TYPE,
   IN_ACCUM_ID    IN  PNP.CCN_ACCUMS.ACCUM_ID%TYPE) RETURN NUMBER;

FUNCTION COST_CENTER_LOOK_UP_FNC(
/**********************************************************
THIS FUNCTION WILL RETURN 6 DIGIT COST_CENTER_CODE
WHEN THE 4-DIGIT CODE IS PASSED OR JUST THE 4 DIGIT COST CENTER CODE IF MATCHING COST CENTER CODE IS NOT FOUND
ERROR IS RAISED IF ERROR FLAG IS SET TO YES ELSE NO ERROR WILL BE RAISED

Created : 06/08/2017 CCN PROJECT TEAM..
Modified: 08/10/2017 nxk927 CCN PROJECT TEAM..
          removing the raise error if the cost center is not present and returning the 4 digit cost center back
**********************************************************/
IN_COST_CENTER IN CUSTOMER_DEPOSIT.COST_CENTER_CODE%TYPE,
IN_ERROR_FLAG IN VARCHAR DEFAULT 'Y'
)
RETURN VARCHAR2;

END COMMON_TOOLS;