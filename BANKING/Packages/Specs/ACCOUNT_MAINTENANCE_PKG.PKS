CREATE OR REPLACE PACKAGE ACCOUNT_MAINTENANCE_PKG
AS
/**********************************************************
This Package contains all the procedures used in
account maintenance window

Created : 07/09/2015 jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE ACCOUNT_MAINTENACE_UI_SP (
/*******************************************************************************
This procedure is intended to RETURN a ref cursor with data from banking
account maintenance related tables based on passed input bank account number
or cost center code

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_BANK_ACCOUNT_NBR           IN     VARCHAR2
,IN_COST_CENTER_CODE          IN     VARCHAR2
,OUT_BANK_ACCOUNT_REF_CUR        OUT REF_CURSOR
,OUT_BANK_ACCOUNT_FTR_REF_CUR    OUT REF_CURSOR
,OUT_BANK_LEAD_CC_REF_CUR        OUT REF_CURSOR
,OUT_BANK_LEAD_CC_FTR_REF_CUR    OUT REF_CURSOR
,OUT_BANK_MICR_FORMAT_REF_CUR    OUT REF_CURSOR
,OUT_BANK_MICR_FRMT_FTR_REF_CUR  OUT REF_CURSOR);

PROCEDURE ACCNT_MNTNC_UI_UPSERT_SP ( 
/******************************************************************************
	This procedure performs the core insert/update process for Account Maintenance Window

created : 07/09/2015 jxc517 CCN Project....
revised : 
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

PROCEDURE ACCNT_MNTNC_FUTURE_UPSERT_SP ( 
/******************************************************************************
This procedure is intended to update following tables used in the
Account Maintenance Window that are future records
    Tables: 
       BANK_ACCOUNT_FUTURE
       LEAD_BANK_CC_FUTURE
       BANK_MICR_FORMAT_FUTURE
Expire following tables used in the Account Maintenance Window that are current records
    Tables: 
       BANK_ACCOUNT
       LEAD_BANK_CC
       BANK_MICR_FORMAT

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_BANK_ACCOUNT_FUTURE_REC         IN BANK_ACCOUNT_FUTURE%ROWTYPE,
    IN_LEAD_BANK_CC_FUTURE_REC         IN LEAD_BANK_CC_FUTURE%ROWTYPE,
    IN_BANK_MICR_FORMAT_FUTURE_TAB     IN TABLE_IU_PKG.BANK_MICR_FORMAT_FTR_TAB_TYPE);

PROCEDURE ACCNT_MNTNC_CURRENT_DELETE_SP ( 
/******************************************************************************
	This procedure performs the core process for Account Maintenance Window,
  delete process for current records

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_BANK_ACCOUNT_NUMBER  IN  VARCHAR2);

PROCEDURE ACCNT_MNTNC_FUTURE_DELETE_SP ( 
/******************************************************************************
	This procedure performs the core process for Account Maintenance Window,
  delete process for future records

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_BANK_ACCOUNT_FTR_REC     IN     BANK_ACCOUNT_FUTURE%ROWTYPE,
    IN_FTR_TO_CURR_FLAG         IN     VARCHAR2 DEFAULT 'N');

PROCEDURE ACCNT_MNTNC_UI_DELETE_SP ( 
/******************************************************************************
	This procedure performs the core process for Account Maintenance Window,
  delete process

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_BANK_ACCOUNT_NUMBER  IN  VARCHAR2,
    IN_FUTURE_ID            IN  NUMBER,
    IN_USER_ID              IN  VARCHAR2);

END ACCOUNT_MAINTENANCE_PKG;

