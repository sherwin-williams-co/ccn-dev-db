CREATE OR REPLACE PACKAGE         BANK_DEP_TICKOAK_PKG AS
/**********************************************************
This Package contains all the procedures used in
bank deposit tickoak maintenance window

Created : 07/31/2015 sxt410 CCN Project....
Changed :
**********************************************************/
TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE BANK_DEP_TICKOAK_UI_SP (
/*******************************************************************************
    This procedure is intended to RETURN a ref cursor with data from 
    Bank Deposit TicketOak table.

Created : 07/31/2015 sxt410 CCN Project....
Changed : 
*******************************************************************************/
OUT_BANK_DEP_TICKOAK_REF_CUR       OUT REF_CURSOR);

PROCEDURE BANK_DEP_TICKOAK_UI_UPSERT_SP( 
/******************************************************************************
    This procedure performs the core process for Bank Deposit TicketOak
    Maintenance Window.

Created : 07/31/2015 sxt410 CCN Project....
Changed : 
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

END BANK_DEP_TICKOAK_PKG;

