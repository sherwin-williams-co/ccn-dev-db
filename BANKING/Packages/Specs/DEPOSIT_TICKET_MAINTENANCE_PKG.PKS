create or replace PACKAGE         DEPOSIT_TICKET_MAINTENANCE_PKG
AS
/**********************************************************
This Package contains all the procedures used in
bank deposit ticket maintenance window

Created : 07/09/2015 jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE DELETE_STORE_MICR_FORMAT_DTLS(
/*******************************************************************************
This procedure is intended to get the STORE_MICR_FORMAT_DTLS record
and delete it from the table

Created : 08/18/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE     IN    VARCHAR2,
IN_BANK_ACCOUNT_NBR     IN    VARCHAR2,
IN_MICR_FORMAT_ID       IN    NUMBER);

PROCEDURE EXPIRE_STORE_MICR_FORMAT_DTLS(
/*******************************************************************************
This procedure is intended to get the STORE_MICR_FORMAT_DTLS record
and expire it from the table

Created : 08/18/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE     IN    VARCHAR2,
IN_BANK_ACCOUNT_NBR     IN    VARCHAR2,
IN_MICR_FORMAT_ID       IN    NUMBER,
IN_EXPIRATION_DATE      IN    DATE);

PROCEDURE EXPR_STR_MICR_FRMT_DTLS_FTR(
/*******************************************************************************
This procedure is intended to get the STORE_MICR_FORMAT_DTLS record
and expire it from the table

Created : 08/18/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE     IN    VARCHAR2,
IN_BANK_ACCOUNT_NBR     IN    VARCHAR2,
IN_MICR_FORMAT_ID       IN    NUMBER,
IN_FUTURE_ID            IN    NUMBER,
IN_EXPIRATION_DATE      IN    DATE);

FUNCTION CONVERT_FORMAT_TO_VALUE(
/*******************************************************************************
This function converts the format into actual value to be stored in STORE_MICR_FORMAT_DTLS

Created : 08/18/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_FORMAT     IN     VARCHAR2,
IN_VALUE      IN     VARCHAR2) RETURN VARCHAR2;

FUNCTION CONVERT_MICR_CC_FORMAT(
/*******************************************************************************
This function converts the micr cost center format into actual value to be 
stored in STORE_MICR_FORMAT_DTLS

Created : 08/18/2015 jxc517 CCN Project....
Changed : 10/17/2016 nxk927 CCN Project....
          function name changed as his will be only used for micr cost center.
          Added the else conditions to consider numbers as well.
*******************************************************************************/
IN_FORMAT     IN     VARCHAR2,
IN_VALUE      IN     VARCHAR2) RETURN VARCHAR2;

FUNCTION GET_DEPOSIT_TKT_FUT_ID_NBR(
/*******************************************************************************
This fucntion is intended to return the deposit ticket future id
for the cost center that has been passed in

Created : 11/03/2015 nxk927 CCN Project....
Changed : 11/16/2015 axk326 CCN Project....
          Added spec to make this function as public
*******************************************************************************/
IN_COST_CENTER_CODE    IN      VARCHAR2,
IN_BANK_ACCT_NBR       IN      VARCHAR2,
IN_FUTURE_ID           IN      NUMBER) RETURN VARCHAR2;

PROCEDURE DEPOSIT_TICKET_MNTNC_UI_SP (
/*******************************************************************************
This procedure is intended to RETURN a ref cursor with data from 
tables based on passed input cost center code

Created : 08/21/2015 jxc517 CCN Project....
Changed : 10/22/2015 sxt410 CCN Project....
          Modified Signature To Pass Current Order Date And Future Order Date. 
Changed : 10/29/2015 jxc517 CCN Project....
          Modified code to include order by clause for bank MICR formats based on FORMAT_NAME
        : 11/16/2015 axk326 CCN Project....
          Added code to retreive the latest order details for the deposit ticket order when placed for current and future tabs
        : 11/23/2015 nxk927 CCN Project...
          For future tab only displaying if the record is a real not the virtual
        : 10/18/2016 nxk927 CCN Project....
          Modified Signature to pass member bank details to UI. It will be used to populate the 
          sub account number in the deposit ticket window. This is added to support the micr details 
          changes for the member bank cost center.
        : 02/09/2018 mxv711 CCN Project....
          Modified to pass Store MICR details separately for UI to display those details 
          even when there are no ticket orders placed on that cost center
*******************************************************************************/
IN_COST_CENTER_CODE                IN     VARCHAR2
,OUT_BANK_DEP_TICK_REF_CUR            OUT REF_CURSOR
,OUT_BANK_ACCOUNT_REF_CUR             OUT REF_CURSOR
,OUT_BANK_MICR_FORMAT_REF_CUR         OUT REF_CURSOR
,OUT_BANK_DEP_TICK_FTR_REF_CUR        OUT REF_CURSOR
,OUT_BANK_ACCOUNT_FTR_REF_CUR         OUT REF_CURSOR
,OUT_BANK_MICR_FRMT_FTR_REF_CUR       OUT REF_CURSOR
,OUT_BANK_DEP_TICKORD_REF_CUR         OUT REF_CURSOR
,OUT_BANK_DEP_TKORD_FTR_REF_CUR       OUT REF_CURSOR
,OUT_MBR_BANK_CC_REF_CUR              OUT REF_CURSOR
,OUT_MBR_BANK_CC_FTR_REF_CUR          OUT REF_CURSOR
,OUT_STORE_MICR_CUR                   OUT REF_CURSOR
,OUT_STORE_MICR_FTR_CUR               OUT REF_CURSOR);

PROCEDURE DEPOSIT_TKT_MNTNC_UI_UPSERT_SP( 
/******************************************************************************
	This procedure performs the core process for Deposit Ticket Maintenance Window

Created : 07/14/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_ROW_DATA         IN  CLOB,
IN_MBR_BNK_ACCT_NBR IN VARCHAR2 DEFAULT NULL);

PROCEDURE INSERT_BANK_DEPOSIT_DTLS_FTR(
/*******************************************************************************
This procedure is intended to build the STORE_MICR_FORMAT_DTLS_FUTURE, 
BANK_DEP_TICK_FUTURE records and insert the same

Created : 08/25/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE     IN    VARCHAR2,
IN_BANK_ACCOUNT_NBR     IN    VARCHAR2,
IN_FUTURE_ID            IN    NUMBER,
IN_EFFECTIVE_DATE       IN    DATE,
IN_EXPIRATION_DATE      IN    DATE,
IN_BANK_TYPE_CODE       IN    VARCHAR2);

PROCEDURE CREATE_DEPOSIT_TKT_INPUT_FILE(
/******************************************************************************
This procedure is intended to create the input deposit ticket file.
Corporate Treasury will then send the bank deposit ticket information to Linda. 
Depending on the request, either of the following will be done:
    1) Add a brand new bank account/routing number and attach store(s) to it
    2) Add a new store to an existing bank account/routing number
    3) Update existing bank account/routing number.  For example, a bank gets bought out and accounts are renumbered and/or routing number changes. 
      (Note, all of these events trigger printing of deposit tickets).

Created : 08/19/2015 jxc517 CCN Project....
Changed : 10/21/2015 nxk927 CCN Project...
          Added call to create the deposit order for future
Changed : 11/11/2015 nxk927 CCN Project...
          made changes to get the micr details of lead if not present for the members.
          added BANK_DEP_TICK_FTR_ID as a parameter to get the right data
*******************************************************************************/
    IN_COST_CENTER          IN VARCHAR2,
    IN_FUTURE_ID            IN VARCHAR2,
    IN_BANK_DEP_TICK_FTR_ID IN VARCHAR2);
    
PROCEDURE PLACE_DEPOSIT_TICKET_ORDER(
/*******************************************************************************
This procedure is intended to place a deposit ticket order for the store passed in

Created : 08/31/2015 jxc517 CCN Project....
Changed : 12/12/2016 nxk927 CCN Project....
          Changed the parameter name from order date to in_arrival_date
*******************************************************************************/
IN_COST_CENTER_CODE     IN     VARCHAR2,
IN_ARRIVAL_DATE         IN     DATE,
IN_FUTURE_ID            IN     NUMBER,
IN_USER_ID              IN     VARCHAR2); 

END DEPOSIT_TICKET_MAINTENANCE_PKG;