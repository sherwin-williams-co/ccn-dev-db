create or replace PACKAGE         DEPOSIT_BAG_MAINTENANCE_PKG AS 
/**********************************************************
This Package contains all the procedures used in
deposit bag update maintenance window

Created : 07/15/2015 axk326/jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE DELETE_DEPOSIT_BAG_DTLS(
/*******************************************************************************
This procedure is intended to get the BANK_DEP_BAG_TICK record
and delete it from the table

Created : 10/19/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE     IN    VARCHAR2);

PROCEDURE EXPIRE_DEPOSIT_BAG_DTLS(
/*******************************************************************************
This procedure is intended to get the BANK_DEP_BAG_TICK record
and expire it from the table

Created : 10/20/2015 jxc517 CCN Project....
Changed : 11/12/2015 nxk927 CCN Project....
          Added BANK_ACCOUNT_NUMBER 
*******************************************************************************/
IN_COST_CENTER_CODE     IN    VARCHAR2,
IN_BANK_ACT_NBR         IN    VARCHAR2,
IN_EXPIRATION_DATE      IN    DATE);

PROCEDURE EXPR_DEPOSIT_BAG_DTLS_FTR(
/*******************************************************************************
This procedure is intended to get the BANK_DEP_BAG_TICK_FUTURE record
and expire it from the table

Created : 10/20/2015 jxc517 CCN Project....
Changed : 11/12/2015 nxk927 CCN Project....
          Added BANK_ACCOUNT_NUMBER
*******************************************************************************/
IN_COST_CENTER_CODE     IN    VARCHAR2,
IN_BANK_ACT_NBR         IN    VARCHAR2,
IN_FUTURE_ID            IN    NUMBER,
IN_EXPIRATION_DATE      IN    DATE);

PROCEDURE BANK_DEP_BAG_TICK_UI_SP (
/*******************************************************************************
	This procedure is intended to RETURN a ref cursor with data from BANK_DEP_BAG_TICK table

Inputs:
    IN_COST_CENTER_CODE

Created : 07/15/2015 axk326/jxc517 CCN Project....
Changed : 10/20/2015 jxc517 CCN Project....
          Added code to support future tables
Changed : 10/22/2015 sxt410 CCN Project....
          Modified Signature To Pass Current Order Date And Future Order Date.        
*******************************************************************************/
IN_COST_CENTER_CODE               IN     VARCHAR2
,OUT_BANK_DEP_BAG_TICK_CUR           OUT REF_CURSOR
,OUT_BANK_DEP_BAG_TICK_FTR_CUR       OUT REF_CURSOR
,OUT_BANK_DEP_BAG_TICKORD_CUR        OUT REF_CURSOR
,OUT_BANK_DEP_BAG_TKORD_FTR_CUR      OUT REF_CURSOR);

PROCEDURE DEPOSIT_BAG_UPDT_UI_UPSERT_SP ( 
/******************************************************************************
This procedure is intended to update following tables used in the Deposit Bag Update Window
    Tables: 
       BANK_DEP_BAG_TICK

Created : 07/15/2015 axk326/jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

PROCEDURE INSERT_BANK_DEP_BAG_DTLS_FTR(
/*******************************************************************************
This procedure is intended to build the BANK_DEP_BAG_TICK_FUTURE records and insert the same

Created : 10/20/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE     IN    VARCHAR2,
IN_BANK_ACCOUNT_NBR     IN    VARCHAR2,
IN_FUTURE_ID            IN    NUMBER,
IN_EFFECTIVE_DATE       IN    DATE,
IN_EXPIRATION_DATE      IN    DATE);

PROCEDURE PLACE_DEPOSIT_BAG_TICKET_ORDER(
/*******************************************************************************
This procedure is intended to place a deposit bag ticket order for the store passed in

Created : 10/20/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE     IN     VARCHAR2,
IN_ORDERED_DATE         IN     DATE,
IN_FUTURE_ID            IN     NUMBER,
IN_USER_ID              IN     VARCHAR2);

END DEPOSIT_BAG_MAINTENANCE_PKG;