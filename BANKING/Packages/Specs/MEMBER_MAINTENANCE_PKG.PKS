create or replace PACKAGE MEMBER_MAINTENANCE_PKG
AS
/**********************************************************
This Package contains all the procedures used in
member cost center maintenance window

Created : 07/09/2015 jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE MEMBER_MNTNC_CURRENT_UPSERT_SP ( 
/******************************************************************************
This procedure is intended to update following table used in the
Member CC Maintenance Window that are current records
    Tables: 
       MEMBER_BANK_CC

Created : 07/10/2015 jxc517 CCN Project....
Changed : 10/14/2015 jxc517 CCN Project....
          Code has been changed to deal with virtual futures
Changed : 10/20/2015 jxc517 CCN Project....
          Code has been changed to deal with Deposit Bag futures
*******************************************************************************/
    IN_MBR_BANK_CC_TAB IN TABLE_IU_PKG.MEMBER_BANK_CC_TAB_TYPE);

PROCEDURE MEMBER_CC_MAINTENACE_UI_SP (
/*******************************************************************************
	This procedure is intended to RETURN a ref cursor with data from member
  cost center maintenance related tables

Inputs:
    IN_COST_CENTER_CODE

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE          IN     VARCHAR2
,OUT_BANK_MBR_CC_REF_CUR         OUT REF_CURSOR
,OUT_BANK_MBR_CC_FTR_REF_CUR     OUT REF_CURSOR);

PROCEDURE MEMBER_MNTNC_UI_UPSERT_SP(
/******************************************************************************
This procedure is intended to update following tables used in the Mamber Maintenance Window
    Tables: 
       MEMBER_BANK_CC
       MEMBER_BANK_CC_FUTURE

Created : 07/09/2015 jxc517 CCN Project....
Changed :
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

PROCEDURE MBR_MNTNC_UI_DELETE_SP ( 
/******************************************************************************
	This procedure performs the core process for Member Maintenance Window,
  delete process

Created : 10/23/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_MEMBER_BANK_CC_REC   IN  MEMBER_BANK_CC%ROWTYPE,
    IN_FUTURE_ID            IN  NUMBER);

END MEMBER_MAINTENANCE_PKG;

