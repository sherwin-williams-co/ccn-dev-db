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

END STR_BNK_DPST_DLY_RCNCL_PROCESS;