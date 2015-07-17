CREATE OR REPLACE PACKAGE DEPOSIT_TICKET_MAINTENANCE_PKG
AS
/**********************************************************
This Package contains all the procedures used in
bank deposit ticket maintenance window

Created : 07/09/2015 jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE DEPOSIT_TICKET_MNTNC_UI_SP (
/*******************************************************************************
This procedure is intended to RETURN a ref cursor with data from 
tables based on passed input cost center code

Created : 07/14/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE          IN     VARCHAR2
,OUT_BANK_DEP_TICK_REF_CUR       OUT REF_CURSOR
,OUT_BANK_ACCOUNT_REF_CUR        OUT REF_CURSOR
,OUT_BANK_MICR_FORMAT_REF_CUR    OUT REF_CURSOR);

PROCEDURE DEPOSIT_TKT_MNTNC_UI_UPSERT_SP( 
/******************************************************************************
	This procedure performs the core process for Deposit Ticket Maintenance Window

Created : 07/14/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW_DATA  IN  CLOB);

END DEPOSIT_TICKET_MAINTENANCE_PKG;

