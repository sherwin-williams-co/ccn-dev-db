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

PROCEDURE STORE_BANK_DPST_RECON_DATA(
/**********************************************************
This procedure is intended to generate a file with the
Store Bank  Deposit Daily Reconciliation data for the last
2 weeks
Created : 09/12/2016 mxk766 CCN project....
Changed : 03/01/2018 sxg151 Renamed Procedure STORE_BANK_DPST_RECON_DT To STORE_BANK_DPST_RECON_DATA
**********************************************************/
    IN_RUN_PERIOD    IN     NUMBER,
    IN_SERVER_NAME   IN     VARCHAR2,
    IN_LOG_FILE      IN     VARCHAR2)
;

END BANKING_BATCH_PKG;