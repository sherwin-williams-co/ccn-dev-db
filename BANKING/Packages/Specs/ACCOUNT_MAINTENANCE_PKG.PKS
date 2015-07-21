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
    IN_FUTURE_ID            IN  NUMBER);

END ACCOUNT_MAINTENANCE_PKG;

