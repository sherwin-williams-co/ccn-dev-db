create or replace PACKAGE COMMON_TOOLS AS 
/*********************************************************** 
This package SPEC is intended to hold reuseable objects that are 
available to be used by the entire schema

created : 09/27/2017 sxh487 CCN project.....
************************************************************/

--global variable
G_NON_MERCH_CODE VARCHAR2(2) := '05';

FUNCTION GET_CURR_RUNCYCLE
/******************************************************************
This function will return the current run cycle for the data to be
loaded from PNP

created : 09/27/2017 sxh487  CCN Project....
changed :
******************************************************************/
RETURN VARCHAR2;

FUNCTION GET_SALES_LINE_AMOUNT (
/**********************************************************
This function will return amt from PNP.CCN_SALES_LINES table

parameters:
in_tran_guid

created : 05/29/2018 sxh487 ccn project
modified:
**********************************************************/
IN_TRAN_GUID     IN  CCN_SALES_LINES_T.TRAN_GUID%TYPE,
IN_RLS_RUN_CYCLE IN  CCN_SALES_LINES_T.RLS_RUN_CYCLE%TYPE
)
RETURN NUMBER;

FUNCTION COST_CENTER_LOOK_UP_FNC(
/**********************************************************
THIS FUNCTION WILL RETURN 6 DIGIT COST_CENTER_CODE
WHEN THE 4-DIGIT CODE IS PASSED OR JUST THE 4 DIGIT COST CENTER CODE IF MATCHING COST CENTER CODE IS NOT FOUND
ERROR IS RAISED IF ERROR FLAG IS SET TO YES ELSE NO ERROR WILL BE RAISED

Created : 06/08/2017 CCN PROJECT TEAM..
Modified: 08/10/2017 nxk927 CCN PROJECT TEAM..
          removing the raise error if the cost center is not present and returning the 4 digit cost center back
modified 08/30/2019 sxc403 CCN Project Team
         Modified the number of parameters to call cost_center_lookup_fnc to match costcenter.common_tools pkgbody.
**********************************************************/
IN_COST_CENTER IN CUSTOMER_DEPOSIT_TRANSACTION_DTL.COST_CENTER_CODE%TYPE
)
RETURN VARCHAR2;

FUNCTION FNC_GET_LATEST_CUM_AMT(
/**********************************************************
This function will return the net balance remaining
as of the day before the current load

Created : 01/25/2018 sxh487
Modified: 02/06/2019 pxa852 CCN Project Team...
          Modified code to replace old table with the new table that is created as part of new data model
**********************************************************/
IN_CUST_ACCOUNT_NBR IN CUSTOMER_DEPOSIT_TRANSACTION_DTL.CUSTOMER_ACCOUNT_NUMBER%TYPE
)
RETURN NUMBER;

FUNCTION GET_GL_DIVISION(
/***********************************************************
GET_GL_DIVISION
      This Function will get the GL_DIVISION

Created : 02/22/2017 SXH487
************************************************************/
IN_COST_CENTER_CODE     IN     CUSTOMER_DEPOSIT_TRANSACTION_DTL.COST_CENTER_CODE%TYPE
)
RETURN VARCHAR2;

FUNCTION BUILD_DEP_HDR_HST_FROM_CURR(
/***********************************************************
	This function will build the history record from
  current CUSTOMER_DEPOSIT_HEADER record

Created : 05/02/2018 sxh487
Changed :
************************************************************/
IN_CUSTOMER_ACCOUNT_NUMBER   IN  CUSTOMER_DEPOSIT_HEADER.CUSTOMER_ACCOUNT_NUMBER%TYPE)
RETURN CUSTOMER_DEPOSIT_HEADER_HST%ROWTYPE;

END COMMON_TOOLS;
