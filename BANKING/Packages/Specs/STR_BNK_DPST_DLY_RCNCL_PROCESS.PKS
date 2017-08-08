create or replace PACKAGE STR_BNK_DPST_DLY_RCNCL_PROCESS
AS
/**********************************************************
  This Package contains procedured to perform the "Store Bank
  Deposit Daily Reconciliation" process

Created : 06/19/2015 jxc517 CCN Project....
Changed :
**********************************************************/
TYPE REF_CURSOR IS REF CURSOR;

FUNCTION GET_BNK_ACCNT_NBR_FOR_CC(
/******************************************************************************
 This function will return the bank account number for the cost center for the date minus
 delay date.

created : 07/25/2017 nxk927 CCN Project....
revised :
*******************************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2,
IN_DATE             IN DATE) RETURN VARCHAR2;

PROCEDURE GNRTE_BNK_ACT_MISMTH_RPT(
/******************************************************************************
  This procedure generates Report if there are mismatch in the source bank
  account number and db bank account

Created : 06/23/2017 nxk927 CCN Project....
Changed :
*******************************************************************************/
IN_TABLE_NAME IN    VARCHAR2,
IN_DATE       IN    DATE,
IN_CATEGORY   IN    VARCHAR2);

PROCEDURE GET_LEAD_BANK_RECORD(
/******************************************************************************
  This procedure gets the lead bank record for the cost center passed in

Created : 06/22/2015 jxc517 CCN Project....
Changed : Parameter IN_COST_CENTER_CODE should be passed as 4 characters. If 6 characters
          use substr(cc,3)
Changed : 06/20/2017 jxc517/nxk927 CCN Project....
          Added IN_DATE parameter
          Added condition to get the lead bank account number as of the Bank Deposit Day
*******************************************************************************/
IN_COST_CENTER_CODE       IN     VARCHAR2,
IN_DATE                   IN     DATE,
OUT_LEAD_BANK_RECORD         OUT LEAD_BANK_CC%ROWTYPE);

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
  This procedure will generate the uar.position file and the serail.dat file

Created : 07/27/2015 nxk927 CCN Project....
Changed :
*******************************************************************************/
IN_DATE            IN         DATE);

PROCEDURE LOAD_OVERSHRT(
/*****************************************************************************
	This procedure will load the data into UAR_OVERSHRT, OVERSHRT table from
  TEMP_UAR_OVERSHRT [using UAR.OVERSHRT file]

Created : 10/27/2016 jxc517 CCN Project....
Changed : 11/07/2016 jxc517 CCN Project....
          adding source bank account number from header details
          we get the max(line number) from header table prior to the line number in detail table
        : 05/23/2017 rxa457 CCN Project.. asp-761
          insert into JV_EXTRCT_CNTRL_FL changed (due to imapct from dropping column filler fields (TRAN_DATE1, UNKNOWN_FIELD, CODE1) from JV_EXTRCT_CNTRL_FL, UAR_JV_EXTRCT_CNTRL_FL )
          and COST_CENTER_CODE field changed to 6 digit equivalent
          and AMOUNT FIELD CHANGED TO NUMBER(10,2) FROM varchar2
          and TRAN_SEQNUM field changed to NUMBER FROM varchar2
Changed : 06/20/2017 jxc517/nxk927 CCN Project....
          Added IN_DATE parameter
          Signature change in call to GET_LEAD_BANK_RECORD
        : 06/28/2017 nxk927 CCN Project....
          logging the error before raising the error if any error occurs
        : 07/25/2017 nxk927 CCN Project....
          calling the function to get the bank account number
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

PROCEDURE PRIME_SUB_LOAD_PROCESS
/******************************************************************************
  This procedure will load the intermediate table
  from MISCTRAN with prime sub and banking JV/IDI details

Created : 10/10/2016 jxc517 CCN Project Team....
Changed :
*******************************************************************************/
;

FUNCTION COST_CENTER_LOOK_UP_FNC(
/**********************************************************
THIS FUNCTION WILL RETURN 6 DIGIT COST_CENTER_CODE
WHEN THE 4-DIGIT CODE IS PASSED OR JUST THE 4 DIGIT COST CENTER CODE IF MATCHING COST CENTER CODE IS NOT FOUND
ERROR IS RAISED IF ERROR FLAG IS SET TO YES ELSE NO ERROR WILL BE RAISED

CREATED : 06/08/2017 RXA457 CCN PROJECT TEAM..
**********************************************************/
IN_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE ,
IN_ERROR_FLAG IN VARCHAR DEFAULT 'Y')
RETURN VARCHAR2;

END STR_BNK_DPST_DLY_RCNCL_PROCESS;