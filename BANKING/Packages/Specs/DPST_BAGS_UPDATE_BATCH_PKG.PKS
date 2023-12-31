create or replace PACKAGE DPST_BAGS_UPDATE_BATCH_PKG
AS
/**********************************************************
  This Package contains procedured to update the deposit bag tickets on a daily
  basis based on the files we recieve from POS

Created : 10/20/2015 jxc517 CCN Project....
Changed :
**********************************************************/
PROCEDURE PROCESS(
/******************************************************************************
  This procedure will update the deposit bag tickets on a daily
  basis based on the files we recieve from POS

Created : 10/20/2015 jxc517 CCN Project....
Changed : 08/19/2016 nxk927 CCN project....
          changed signature. Added servername and logfile name
Changed : 08/26/2016 nxk927 CCN project....
          added commit for each loop
*******************************************************************************/
IN_SERVER_NAME  IN VARCHAR2,
IN_LOGFILE      IN VARCHAR2);

PROCEDURE INTRM_DPST_BAG_PROCESS(
/******************************************************************************
  This procedure will update the deposit tickets on a daily
  basis based on the files we recieve from POS

Created : 09/06/2016 nxk927 CCN Project....
Changed :
*******************************************************************************/
IN_SERVER_NAME  IN VARCHAR2,
IN_LOGFILE      IN VARCHAR2);

PROCEDURE DPST_BAG_PROCESS(
/******************************************************************************
  This procedure will update the deposit tickets on a daily
  basis based on the files we recieve from POS

Created : 07/07/2017 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_SERVER_NAME  IN VARCHAR2,
IN_LOGFILE      IN VARCHAR2);

END DPST_BAGS_UPDATE_BATCH_PKG;