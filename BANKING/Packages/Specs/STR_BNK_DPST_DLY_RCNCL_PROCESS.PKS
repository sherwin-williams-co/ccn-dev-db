create or replace PACKAGE STR_BNK_DPST_DLY_RCNCL_PROCESS
AS
/**********************************************************
  This Package contains procedured to perform the "Store Bank
  Deposit Daily Reconciliation" process

Created : 06/19/2015 jxc517 CCN Project....
Changed :
**********************************************************/
TYPE REF_CURSOR IS REF CURSOR;

FUNCTION RETURN_REFEED_CODE(
/*****************************************************************************
  This function will return the refeed code from the Refeed_lookup_tb for the 
  passed Tcode

Created : 08/23/2016 nxk927 CCN Project....
Changed :
*****************************************************************************/
IN_TCODE         IN VARCHAR2
) RETURN VARCHAR2;

PROCEDURE EXECUTE_PROCESS(
/******************************************************************************
  This procedure is the core procedure for performing the "Store Bank
  Deposit Daily Reconciliation" process for the date passed in

Created : 06/19/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_DATE            IN         DATE);

PROCEDURE PRIME_SUB_LOAD_PROCESS
/******************************************************************************
  This procedure will load the intermediate table 
  from MISCTRAN with prime sub and banking JV/IDI details

Created : 10/10/2016 jxc517 CCN Project Team....
Changed : 
*******************************************************************************/
;

PROCEDURE EXECUTE_CORRECTS_PROCESS(
/******************************************************************************
  This procedure is the core procedure for performing the "Store Bank
  Deposit Daily Reconciliation" process for the date passed in

Created : 11/07/2016 jxc517 CCN Project....
Changed :
*******************************************************************************/
IN_DATE            IN         DATE);


FUNCTION COST_CENTER_LOOK_UP_FNC( 
/**********************************************************
THIS FUNCTION WILL RETURN 6 DIGIT COST_CENTER_CODE
WHEN THE 4-DIGIT CODE IS PASSED OR JUST THE 4 DIGIT COST CENTER CODE IF MATCHING COST CENTER CODE IS NOT FOUND 
ERROR IS RAISED IF ERROR FLAG IS SET TO YES ELSE NO ERROR WILL BE RAISED

CREATED : 06/08/2017 RXA457 CCN PROJECT TEAM..
**********************************************************/
IN_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE ,
IN_ERROR_FLAG IN VARCHAR DEFAULT 'Y'
)
RETURN VARCHAR2;   

END STR_BNK_DPST_DLY_RCNCL_PROCESS;