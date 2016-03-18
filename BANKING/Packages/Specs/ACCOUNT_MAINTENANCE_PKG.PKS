CREATE OR REPLACE PACKAGE         ACCOUNT_MAINTENANCE_PKG
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

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_BANK_ACCOUNT_NBR           IN     VARCHAR2
,OUT_BANK_ACCOUNT_REF_CUR        OUT REF_CURSOR
,OUT_BANK_ACCOUNT_FTR_REF_CUR    OUT REF_CURSOR
,OUT_BANK_LEAD_CC_REF_CUR        OUT REF_CURSOR
,OUT_BANK_LEAD_CC_FTR_REF_CUR    OUT REF_CURSOR
,OUT_BANK_MICR_FORMAT_REF_CUR    OUT REF_CURSOR
,OUT_BANK_MICR_FRMT_FTR_REF_CUR  OUT REF_CURSOR);


PROCEDURE ACCNT_MNTNC_UI_UPSERT_SP ( 
/******************************************************************************
	This procedure performs the core insert/update process for Account Maintenance Window

Created : 07/09/2015 jxc517 CCN Project....
Changed : 12/12/2015 dxv848 added the flag for future check
*******************************************************************************/
IN_ROW_DATA  IN  CLOB);

END ACCOUNT_MAINTENANCE_PKG;