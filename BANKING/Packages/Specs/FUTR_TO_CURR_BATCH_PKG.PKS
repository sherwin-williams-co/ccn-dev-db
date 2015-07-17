CREATE OR REPLACE PACKAGE FUTR_TO_CURR_BATCH_PKG
AS
/**********************************************************
  This Package contains procedured to move the future table records into
  current tables

created : 05/26/2015 jxc517 CCN Project....
changed :
**********************************************************/
PROCEDURE PROCESS
/******************************************************************************
  This procedure will move the future table records into current tables
  Tables:
      BANK_ACCOUNT_FUTURE
      LEAD_BANK_CC_FUTURE
      MEMBER_BANK_CC_FUTURE
      BANK_MICR_FORMAT_FUTURE

created : 05/26/2015 jxc517 CCN Project....
revised : 
*******************************************************************************/
;

END FUTR_TO_CURR_BATCH_PKG;

