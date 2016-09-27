create or replace PACKAGE DPST_TCKTS_UPDATE_BATCH_PKG
AS
/**********************************************************
  This Package contains procedured to update the deposit tickets on a daily
  basis based on the files we recieve from POS

Created : 08/31/2015 jxc517 CCN Project....
Changed :
**********************************************************/
PROCEDURE PROCESS(
/******************************************************************************
  This procedure will update the deposit tickets on a daily
  basis based on the files we recieve from POS

Created : 08/31/2015 jxc517 CCN Project....
Changed : 08/19/2016 nxk927 CCN project....
          changed signature. Added servername and logfile name
*******************************************************************************/
IN_SERVER_NAME  IN VARCHAR2,
IN_LOGFILE      IN VARCHAR2);

END DPST_TCKTS_UPDATE_BATCH_PKG;