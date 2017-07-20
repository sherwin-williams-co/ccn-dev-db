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


PROCEDURE GENERATE_BNK_DRFT_CRRCTN_FILE(
/******************************************************************************
  This procedure will generate UAR BANK DRAFT CORRECTION FILE [SRA12060] file using
  MISCTRAN and OVERSHRT files we receive from Corporate Treasurers Department

as per requirements document:
SRA13513 [CFA TRANS] --> SRA15010 [CFA TRANS] --> SWSD.BANK.DRAFT.CORRECTS
CFA => Cash Flow Adjustments

Created : 10/27/2016 jxc517 CCN Project....
Changed : 11/09/2016 jxc517 CCN Project....
          modified the file name from TXT to txt
Changed : 03/17/2017 nxk927 CCN Project....
          OC/RC should be '-' and OD/RD should be '+'
          combining multiple transactions into one
Changed : 03/21/2017 jxc517 CCN Project Team....
          Added code NOT to consider refeed codes 0049 and 0055
*******************************************************************************/
IN_DATE            IN         DATE);

FUNCTION cost_center_look_up_fnc( 
/**********************************************************
This function will return 6 digit COST_CENTER_CODE
when the 4-digit code is passed or just the 4 digit cost center code if matching cost center code is not found 
Error is raised if error flag is set to Yes else No error will be raised

created : 06/08/2017 rxa457 CCN Project Team..
**********************************************************/
in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE ,
in_error_flag IN VARCHAR DEFAULT 'Y'
)
RETURN VARCHAR2;   

END STR_BNK_DPST_DLY_RCNCL_PROCESS;