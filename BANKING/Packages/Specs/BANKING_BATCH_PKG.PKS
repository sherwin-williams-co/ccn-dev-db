create or replace PACKAGE BANKING_BATCH_PKG
AS 
/**********************************************************
  This Package is a wrapper for all batch processes of banking application

Created : 07/21/2015 axk326/jxc517 CCN Project....
Changed :
**********************************************************/
PROCEDURE CURRENT_TO_HISTORY_PROCESS
/******************************************************************************
  This procedure is a wrapper to call CURRENT_TO_HISTORY_PKG.PROCESS

Created : 07/21/2015 axk326/jxc517 CCN Project....
Changed :
*******************************************************************************/
;

PROCEDURE FUTURE_TO_CURRENT_PROCESS
/******************************************************************************
  This procedure is a wrapper to call FUTURE_TO_CURRENT_PKG.PROCESS

Created : 07/21/2015 axk326/jxc517 CCN Project....
Changed :
*******************************************************************************/
;

PROCEDURE LOAD_MEMER_BANK_CONCENT_CC(
/*******************************************************************
  This procedure will load the data in MEMBER_BANK_CONCENTRATION_CC table.
Created : sxg151 10/30/2017

********************************************************************/
IN_LOAD_DATE      IN DATE
)
;

FUNCTION GET_BANK_ACCOUNT_NAME(
/******************************************************************************
 This function will return bank account name of a lead bank account number
 which is active as of passed date.

created : 11/27/2018 pxa852 CCN Project....
revised :
*******************************************************************************/
IN_BANK_ACCOUNT_NBR IN VARCHAR2,
IN_DATE             IN DATE) RETURN VARCHAR2;

PROCEDURE BANKING_CONCENTRATION_MONTHLY_RPT(
/******************************************************************************
  This procedure is used to generate banking member concentration monthly
  report and send it to user.

Created : 10/09/2018 pxa852 CCN Project Team....
Changed :
*******************************************************************************/
 IN_RUN_DATE            IN         DATE);
END BANKING_BATCH_PKG;