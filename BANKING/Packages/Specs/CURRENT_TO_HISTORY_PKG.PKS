CREATE OR REPLACE PACKAGE CURRENT_TO_HISTORY_PKG
AS
/**********************************************************
  This Package contains procedured to move the current table records into
  history tables

Created : 05/26/2015 jxc517 CCN Project....
Changed :
**********************************************************/
PROCEDURE PROCESS
/******************************************************************************
  This procedure will move the current table records into history tables
  Tables:
      LEAD_BANK_CC_HIST
      MEMBER_BANK_CC_HIST
      BANK_MICR_FORMAT_HIST
      BANK_ACCOUNT_HIST

Created : 05/26/2015 jxc517 CCN Project....
Changed : 07/22/2015 jxc517 CCN Project....
          Modified to move childs along with parents into history even if parent is active
*******************************************************************************/
;

END CURRENT_TO_HISTORY_PKG;

