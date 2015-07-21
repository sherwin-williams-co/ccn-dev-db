CREATE OR REPLACE PACKAGE BANKING_BATCH_PKG AS 
/**********************************************************
  This Package is a wrapper for all batch processes of banking application

created : 07/21/2015 axk326/jxc517 CCN Project....
changed :
**********************************************************/
PROCEDURE CURRENT_TO_HISTORY_PROCESS
/******************************************************************************
  This procedure is a wrapper to call CURRENT_TO_HISTORY_PKG.PROCESS

created : 05/26/2015 axk326/jxc517 CCN Project....
revised : 
*******************************************************************************/
;

PROCEDURE FUTURE_TO_CURRENT_PROCESS
/******************************************************************************
  This procedure is a wrapper to call FUTURE_TO_CURRENT_PKG.PROCESS

created : 05/26/2015 axk326/jxc517 CCN Project....
revised : 
*******************************************************************************/
;

END BANKING_BATCH_PKG;

