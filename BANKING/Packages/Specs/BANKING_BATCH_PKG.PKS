CREATE OR REPLACE PACKAGE BANKING_BATCH_PKG
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

PROCEDURE DPST_TCKTS_UPDATE_PROCESS
/******************************************************************************
  This procedure is a wrapper to call DPST_TCKTS_UPDATE_BATCH_PKG.PROCESS

Created : 07/21/2015 axk326/jxc517 CCN Project....
Changed :
*******************************************************************************/
;

END BANKING_BATCH_PKG;

