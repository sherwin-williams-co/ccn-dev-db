CREATE OR REPLACE PACKAGE DEPOSIT_BAG_MAINTENANCE_PKG AS 
/**********************************************************
This Package contains all the procedures used in
deposit bag update maintenance window

Created : 07/15/2015 axk326 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;
PROCEDURE BANK_DEP_BAG_TICK_UI_SP (
/*******************************************************************************
	This procedure is intended to RETURN a ref cursor with data from BANK_DEP_BAG_TICK table

Inputs:
    IN_COST_CENTER_CODE

Created : 07/15/2015 axk326 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE IN     VARCHAR2
,OUT_REF_CUR           OUT REF_CURSOR);

PROCEDURE DEPOSIT_BAG_UPDT_UI_UPSERT_SP ( 
/******************************************************************************
This procedure is intended to update following tables used in the Deposit Bag Update Window
    Tables: 
       BANK_DEP_BAG_TICK

Created : 07/15/2015 axk326 CCN Project....
Changed : 
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

END DEPOSIT_BAG_MAINTENANCE_PKG;

