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

PROCEDURE LOAD_DATA(
/******************************************************************************
  This procedure will load the table that will be used to generate the data
  for the UAR.POSITION file

Created : 07/27/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_DATE            IN         DATE);

PROCEDURE GENERATE_FILES(
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

PROCEDURE LOAD_OVERSHRT(
/*****************************************************************************
	This procedure will load the data into UAR_OVERSHRT, OVERSHRT table from
  TEMP_UAR_OVERSHRT [using UAR.OVERSHRT file]

Created : 10/27/2016 jxc517 CCN Project....
Changed : 11/07/2016 jxc517 CCN Project....
          adding source bank account number from header details
          we get the max(line number) from header table prior to the line number in detail table
Changed : 06/20/2017 jxc517/nxk927 CCN Project....
          Added IN_DATE parameter
          Signature change in call to GET_LEAD_BANK_RECORD
        : 06/28/2017 nxk927 CCN Project....
          logging the error before raising the error if any error occurs
        : 07/27/2017 nxk927 CCN Project....
          loading the table with load date as of the passed date rather than using sysdate
*****************************************************************************/
    IN_DATE            IN         DATE);

PROCEDURE GENERATE_CORRECTS_FILE(
/******************************************************************************
  This procedure will generate the bank draft corrects/cashflow file

Created : : 07/27/2017 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_DATE            IN         DATE);

END STR_BNK_DPST_DLY_RCNCL_PROCESS;