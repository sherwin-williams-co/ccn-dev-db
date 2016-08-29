CREATE OR REPLACE PACKAGE         BANKING_UI_INTERFACE_APP_PKG
AS
/**********************************************************
  This Package is intended to be the wrapper for all banking
  related packages that are invoked from UI

Created : 03/30/2015 jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

FUNCTION GET_FUTURE_ID(
/***********************************************************
	This procedure will be called from UI to get the future id 

Created : 07/23/2015 jxc517 CCN Project Team....
Changed : 
************************************************************/
IN_BANK_ACCOUNT_NBR IN VARCHAR2) RETURN NUMBER;

PROCEDURE ACCOUNT_MAINTENACE_UI_SP (
/*******************************************************************************
	This procedure is intended to RETURN a ref cursor with data from banking
  account maintenance related table

Inputs:
    IN_BANK_ACCOUNT_NBR
    IN_COST_CENTER_CODE

Created : 03/30/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_BANK_ACCOUNT_NBR           IN     VARCHAR2
,IN_COST_CENTER_CODE           IN     VARCHAR2
,OUT_BANK_ACCOUNT_REF_CUR        OUT REF_CURSOR
,OUT_BANK_ACCOUNT_FTR_REF_CUR    OUT REF_CURSOR
,OUT_BANK_LEAD_CC_REF_CUR        OUT REF_CURSOR
,OUT_BANK_LEAD_CC_FTR_REF_CUR    OUT REF_CURSOR
,OUT_BANK_MICR_FORMAT_REF_CUR    OUT REF_CURSOR
,OUT_BANK_MICR_FRMT_FTR_REF_CUR  OUT REF_CURSOR);

PROCEDURE BANK_DEP_TICK_UI_SP (
/*******************************************************************************
	This procedure is intended to RETURN a ref cursor with data from BANK_DEP_TICK table

Inputs:
    IN_COST_CENTER_CODE

Created : 05/20/2015 jxc517 CCN Project....
Changed : 08/21/2015 jxc517 CCN Project....
          Modified signature to pass future details also to allow future maintenance
Changed : 10/22/2015 sxt410 CCN Project....
          Modified Signature To Pass Current Order Date And Future Order Date.
*******************************************************************************/
IN_COST_CENTER_CODE           IN     VARCHAR2
,OUT_BANK_DEP_TICK_REF_CUR       OUT REF_CURSOR
,OUT_BANK_ACCOUNT_REF_CUR        OUT REF_CURSOR
,OUT_BANK_MICR_FORMAT_REF_CUR    OUT REF_CURSOR
,OUT_BANK_DEP_TICK_FTR_REF_CUR   OUT REF_CURSOR
,OUT_BANK_ACCOUNT_FTR_REF_CUR    OUT REF_CURSOR
,OUT_BANK_MICR_FRMT_FTR_REF_CUR  OUT REF_CURSOR
,OUT_BANK_DEP_TICKORD_REF_CUR    OUT REF_CURSOR
,OUT_BANK_DEP_TKORD_FTR_REF_CUR  OUT REF_CURSOR
);

PROCEDURE BANK_DEP_BAG_TICK_UI_SP (
/*******************************************************************************
	This procedure is intended to RETURN a ref cursor with data from BANK_DEP_BAG_TICK table

Inputs:
    IN_COST_CENTER_CODE

Created : 05/20/2015 jxc517 CCN Project....
Changed : 10/20/2015 jxc517 CCN Project....
          Changes made to support future tabs
Changed : 10/22/2015 sxt410 
*******************************************************************************/
IN_COST_CENTER_CODE               IN     VARCHAR2
,OUT_BANK_DEP_BAG_TICK_CUR           OUT REF_CURSOR
,OUT_BANK_DEP_BAG_TICK_FTR_CUR       OUT REF_CURSOR
,OUT_BANK_DEP_BAG_TICKORD_CUR        OUT REF_CURSOR
,OUT_BANK_DEP_BAG_TKORD_FTR_CUR      OUT REF_CURSOR);

PROCEDURE MEMBER_CC_MAINTENACE_UI_SP (
/*******************************************************************************
	This procedure is intended to RETURN a ref cursor with data from member
  cost center maintenance related tables

Inputs:
    IN_COST_CENTER_CODE

Created : 05/22/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE          IN     VARCHAR2
,OUT_BANK_MBR_CC_REF_CUR         OUT REF_CURSOR
,OUT_BANK_MBR_CC_FTR_REF_CUR     OUT REF_CURSOR);

PROCEDURE BANK_HISTORY_UI_SP (
/*******************************************************************************
	This procedure is intended to RETURN a ref cursor with data from the
  history of the cost center (Independent/Lead/Member) passed

Inputs:
    IN_COST_CENTER_CODE

Created : 06/05/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE IN     VARCHAR2
,OUT_REF_CUR           OUT REF_CURSOR);

PROCEDURE BANK_DEP_TICK_OAK_UI_SP (
/*******************************************************************************
    This procedure is intended to RETURN a ref cursor with data from BANK_DEP_TICKOAK table

Created : 07/31/2015 sxt410 CCN Project....
Changed : 
*******************************************************************************/
OUT_BANK_DEP_TICKOAK_REF_CUR    OUT REF_CURSOR);

PROCEDURE ACCNT_MNTNC_UI_UPSERT_SP ( 
/******************************************************************************
This procedure is intended to update following tables used in the Account Maintenance Window
    Tables: 
       BANK_ACCOUNT
       BANK_ACCOUNT_FUTURE
       LEAD_BANK_CC
       LEAD_BANK_CC_FUTURE
       BANK_MICR_FORMAT
       BANK_MICR_FORMAT_FUTURE

<?xml version="1.0" encoding="UTF-8" ?>
<ACCOUNT_MAINTENANCE_UI xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
    <BANK_ACCOUNT>
        <BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</BANK_ACCOUNT_NBR>
        <EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
        <EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
        <BANK_NAME>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</BANK_NAME>
        <BOOK_KEEPER_NBR>XX</BOOK_KEEPER_NBR>
        <STATEMENT_TYPE>XX</STATEMENT_TYPE>
        <BANK_AUTO_RECON_IND>X</BANK_AUTO_RECON_IND>
        <RECON_START_DATE>MM-DD-RRRR</RECON_START_DATE>
        <RECON_BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</RECON_BANK_ACCOUNT_NBR>
        <JV_BOOK_KEEPER_REF>XXXXXX</JV_BOOK_KEEPER_REF>
        <JV_BANK_SHORT_NAME>XXXXXX</JV_BANK_SHORT_NAME>
        <IDI_BOOKKEEPER_REF>XXXXXX</IDI_BOOKKEEPER_REF>
        <IDI_BANK_SHORT_NAME>XXXXXX</IDI_BANK_SHORT_NAME>
        <ROUTING_NBR>XXXXXXXXX</ROUTING_NBR>
        <UPDATE_DATE>MM-DD-RRRR</UPDATE_DATE>
        <LAST_UPD_USER_ID>XXXXXXXX</LAST_UPD_USER_ID>
        <FUTURE_ID>XXXXXXXXXXXXXXXXXXXXXX</FUTURE_ID>
    </BANK_ACCOUNT>
    <LEAD_BANK_CC>
        <LEAD_BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</LEAD_BANK_ACCOUNT_NBR>
        <LEAD_STORE_NBR>XXXXXX</LEAD_STORE_NBR>
        <EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
        <EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
        <BANK_BRANCH_NBR>XXXXXXXX</BANK_BRANCH_NBR>
        <BANK_TYPE_CODE>X</BANK_TYPE_CODE>
        <UPDATE_DATE>MM-DD-RRRR</UPDATE_DATE>
        <LAST_UPD_USER_ID>XXXXXXXX</LAST_UPD_USER_ID>
        <FUTURE_ID>XXXXXXXXXXXXXXXXXXXXXX</FUTURE_ID>
    </LEAD_BANK_CC>
    <BANK_MICR_FORMAT_TABLE>
        <BANK_MICR_FORMAT>
            <BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</BANK_ACCOUNT_NBR>
            <FORMAT_NAME>XXXXXX</FORMAT_NAME>
            <DJDE_FORM_PARM>XXXXXX</DJDE_FORM_PARM>
            <DJDE_FEED_PARM>XXXXX</DJDE_FEED_PARM>
            <MICR_COST_CNTR>XXXXXXXX</MICR_COST_CNTR>
            <MICR_ROUTING_NBR>XXXXXXXXXXX</MICR_ROUTING_NBR>
            <MICR_FORMAT_ACTNBR>XXXXXXXXXXXXXXXXX</MICR_FORMAT_ACTNBR>
            <REORDER_POINT>XXXXX</REORDER_POINT>
            <REORDER_NUMBER_BKS>XXXXX</REORDER_NUMBER_BKS>
            <IMAGES_PER_PAGE>X</IMAGES_PER_PAGE>
            <NBR_FORMS_PER_BK>XXXXX</NBR_FORMS_PER_BK>
            <PART_PAPER_PER_FORM>X</PART_PAPER_PER_FORM>
            <NBR_DEP_TICKETS_PER_BK>XXXXX</NBR_DEP_TICKETS_PER_BK>
            <SHEETS_OF_PAPER_PER_BK>XXXXX</SHEETS_OF_PAPER_PER_BK>
            <EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
            <EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
            <LAST_MAINTENANCE_DATE>MM-DD-RRRR</LAST_MAINTENANCE_DATE>
            <LAST_MAINT_USER_ID>XXXXXX</LAST_MAINT_USER_ID>
            <UPDATE_DATE>MM-DD-RRRR</UPDATE_DATE>
            <LAST_UPD_USER_ID>XXXXXXXX</LAST_UPD_USER_ID>
            <FUTURE_ID>XXXXXXXXXXXXXXXXXXXXXX</FUTURE_ID>
        </BANK_MICR_FORMAT>
        <BANK_MICR_FORMAT>
            <BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</BANK_ACCOUNT_NBR>
            <FORMAT_NAME>XXXXXX</FORMAT_NAME>
            <DJDE_FORM_PARM>XXXXXX</DJDE_FORM_PARM>
            <DJDE_FEED_PARM>XXXXX</DJDE_FEED_PARM>
            <MICR_COST_CNTR>XXXXXXXX</MICR_COST_CNTR>
            <MICR_ROUTING_NBR>XXXXXXXXXXX</MICR_ROUTING_NBR>
            <MICR_FORMAT_ACTNBR>XXXXXXXXXXXXXXXXX</MICR_FORMAT_ACTNBR>
            <REORDER_POINT>XXXXX</REORDER_POINT>
            <REORDER_NUMBER_BKS>XXXXX</REORDER_NUMBER_BKS>
            <IMAGES_PER_PAGE>X</IMAGES_PER_PAGE>
            <NBR_FORMS_PER_BK>XXXXX</NBR_FORMS_PER_BK>
            <PART_PAPER_PER_FORM>X</PART_PAPER_PER_FORM>
            <NBR_DEP_TICKETS_PER_BK>XXXXX</NBR_DEP_TICKETS_PER_BK>
            <SHEETS_OF_PAPER_PER_BK>XXXXX</SHEETS_OF_PAPER_PER_BK>
            <EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
            <EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
            <LAST_MAINTENANCE_DATE>MM-DD-RRRR</LAST_MAINTENANCE_DATE>
            <LAST_MAINT_USER_ID>XXXXXX</LAST_MAINT_USER_ID>
            <UPDATE_DATE>MM-DD-RRRR</UPDATE_DATE>
            <LAST_UPD_USER_ID>XXXXXXXX</LAST_UPD_USER_ID>
            <FUTURE_ID>XXXXXXXXXXXXXXXXXXXXXX</FUTURE_ID>
        </BANK_MICR_FORMAT>
    </BANK_MICR_FORMAT_TABLE>
</ACCOUNT_MAINTENANCE_UI>

Created : 05/18/2015 jxc517 CCN Project....
Changed : 12/12/2015 dxv848 added the flag for future checks.
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB,
    IN_FLAG      IN VARCHAR2);

PROCEDURE MEMBER_MNTNC_UI_UPSERT_SP(
/******************************************************************************
This procedure is intended to update following tables used in the Mamber Maintenance Window
    Tables: 
       MEMBER_BANK_CC
       MEMBER_BANK_CC_FUTURE

<?xml version="1.0" encoding="UTF-8" ?>
<MEMBER_CC_MAINTENANCE_UI xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
    <MEMBER_BANK_CC_TABLE>
        <MEMBER_BANK_CC>
            <LEAD_BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</LEAD_BANK_ACCOUNT_NBR>
            <LEAD_STORE_NBR>XXXXXX</LEAD_STORE_NBR>
            <MEMBER_STORE_NBR>XXXXXX</MEMBER_STORE_NBR>
            <EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
            <EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
            <MEMBER_BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</MEMBER_BANK_ACCOUNT_NBR>
            <BANK_BRANCH_NBR>XXXXXXXX</BANK_BRANCH_NBR>
            <UPDATE_DATE>MM-DD-RRRR</UPDATE_DATE>
            <LAST_UPD_USER_ID>XXXXXXXX</LAST_UPD_USER_ID>
            <FUTURE_ID>XXXXXXXXXXXXXXXXXXXXXX</FUTURE_ID>
        </MEMBER_BANK_CC>    
        <MEMBER_BANK_CC>
            <LEAD_BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</LEAD_BANK_ACCOUNT_NBR>
            <LEAD_STORE_NBR>XXXXXX</LEAD_STORE_NBR>
            <MEMBER_STORE_NBR>XXXXXX</MEMBER_STORE_NBR>
            <EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
            <EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
            <MEMBER_BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</MEMBER_BANK_ACCOUNT_NBR>
            <BANK_BRANCH_NBR>XXXXXXXX</BANK_BRANCH_NBR>
            <UPDATE_DATE>MM-DD-RRRR</UPDATE_DATE>
            <LAST_UPD_USER_ID>XXXXXXXX</LAST_UPD_USER_ID>
            <FUTURE_ID>XXXXXXXXXXXXXXXXXXXXXX</FUTURE_ID>
        </MEMBER_BANK_CC>  
        <MEMBER_BANK_CC>
            <LEAD_BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</LEAD_BANK_ACCOUNT_NBR>
            <LEAD_STORE_NBR>XXXXXX</LEAD_STORE_NBR>
            <MEMBER_STORE_NBR>XXXXXX</MEMBER_STORE_NBR>
            <EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
            <EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
            <MEMBER_BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</MEMBER_BANK_ACCOUNT_NBR>
            <BANK_BRANCH_NBR>XXXXXXXX</BANK_BRANCH_NBR>
            <UPDATE_DATE>MM-DD-RRRR</UPDATE_DATE>
            <LAST_UPD_USER_ID>XXXXXXXX</LAST_UPD_USER_ID>
            <FUTURE_ID>XXXXXXXXXXXXXXXXXXXXXX</FUTURE_ID>
        </MEMBER_BANK_CC>
    </MEMBER_BANK_CC_TABLE>
</MEMBER_CC_MAINTENANCE_UI>

Created : 07/10/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);
    
PROCEDURE DEPOSIT_TICKET_UI_UPSERT_SP ( 
/******************************************************************************
This procedure is intended to update following tables used in the Deposit Ticket Window
    Tables: 
       BANK_DEP_TICK

<?xml version="1.0" encoding="UTF-8" ?>
<BANK_DEP_TICK_UI xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
    <BANK_DEP_TICK>
        <BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</BANK_ACCOUNT_NBR>
        <COST_CENTER_CODE>XXXXXX</COST_CENTER_CODE>
        <DAILY_USE_ACTUAL>XXX</DAILY_USE_ACTUAL>
        <DAILY_USE_OVERRIDE>XXX</DAILY_USE_OVERRIDE>
        <DEP_TKTS_ONHAND_QTY>XXXXX</DEP_TKTS_ONHAND_QTY>
        <YTD_DEP_TKTS_ORDERED_QTY>XXXXX</YTD_DEP_TKTS_ORDERED_QTY>
        <REORDER_POINT>XXXXX</REORDER_POINT>
        <REORDER_NUMBER_BKS>XXXXX</REORDER_NUMBER_BKS>
        <IMAGES_PER_PAGE>X</IMAGES_PER_PAGE>
        <NBR_FORMS_PER_BK>XXXXX</NBR_FORMS_PER_BK>
        <PART_PAPER_PER_FORM>X</PART_PAPER_PER_FORM>
        <NBR_DEP_TICKETS_PER_BK>XXXXX</NBR_DEP_TICKETS_PER_BK>
        <SHEETS_OF_PAPER_PER_BK>XXXXX</SHEETS_OF_PAPER_PER_BK>
        <EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
        <EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
        <LAST_MAINTENANCE_DATE>MM-DD-RRRR</LAST_MAINTENANCE_DATE>
        <LAST_MAINT_USER_ID>XXXXXX</LAST_MAINT_USER_ID>
        <REORDER_SWITCH>X</REORDER_SWITCH>
        <LAST_VW_ORDER_DATE>MM-DD-RRRR</LAST_VW_ORDER_DATE>
        <MICR_FORMAT_ID>XX</MICR_FORMAT_ID>
        <FUTURE_ID>X</FUTURE_ID>
    </BANK_DEP_TICK>
</BANK_DEP_TICK_UI>

created : 05/21/2015 jxc517 CCN Project....
revised : 
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

PROCEDURE PLACE_DEPOSIT_TICKET_ORDER(
/*******************************************************************************
This procedure is intended to place a deposit ticket order for the store passed in

Created : 08/31/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE     IN     VARCHAR2,
IN_ORDERED_DATE         IN     DATE,
IN_FUTURE_ID            IN     NUMBER,
IN_USER_ID              IN     VARCHAR2);

PROCEDURE DEPOSIT_BAG_UPDT_UI_UPSERT_SP ( 
/******************************************************************************
This procedure is intended to update following tables used in the Deposit Bag Update Window
    Tables: 
       BANK_DEP_BAG_TICK

<?xml version="1.0" encoding="UTF-8" ?>
<BANK_DEP_BAG_TICK_UI xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
    <BANK_DEP_BAG_TICK>
        <BANK_ACCOUNT_NBR>XXXXXXXXXXXXXXXX</BANK_ACCOUNT_NBR>
        <COST_CENTER_CODE>XXXXXX</COST_CENTER_CODE>
        <DEPBAG_DAILY_USE_ACTUAL>XXXXX</DEPBAG_DAILY_USE_ACTUAL>
        <DEPBAG_DLY_USE_OVERRIDE>XXXXX</DEPBAG_DLY_USE_OVERRIDE>
        <DEPBAG_LAST_ORDER_DATE>MM-DD-RRRR</DEPBAG_LAST_ORDER_DATE>
        <DEPBAG_LAST_ORDER_QTY>XXXXX</DEPBAG_LAST_ORDER_QTY>
        <DEPBAG_ONHAND_QTY>XXXXX</DEPBAG_ONHAND_QTY>
        <DEPBAG_REORDER_QTY>XXXXX</DEPBAG_REORDER_QTY>
        <DEPBAG_YTD_ORDERED_QTY>XXXXX</DEPBAG_YTD_ORDERED_QTY>
        <DEP_BAG_REORDER_POINT>XXXXX</DEP_BAG_REORDER_POINT>
        <DEP_BAG_TYPE>X</DEP_BAG_TYPE>
        <DEP_BAG_REORDER_SWITCH>X</DEP_BAG_REORDER_SWITCH>
        <EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
        <EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
    </BANK_DEP_BAG_TICK>
</BANK_DEP_BAG_TICK_UI>

Created : 05/21/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

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

PROCEDURE BANK_DEP_TICK_OAK_UI_UPSERT_SP ( 
/******************************************************************************
This procedure is intended to insert into following tables used in the 
Bank Deposit Ticket Oak Window.
    Tables: 
       BANK_DEP_TICKOAK

Created : 07/31/2015 sxt410 CCN Project....
Changed : 
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

PROCEDURE LEAD_BANK_FROM_SP 
/*******************************************************************************
    This procedure is intended to select records from Lead bank table including the 
    members from the member bank table that we will be tranferred from.  

Created : 07/08/2015 nxk927/jxc517 CCN Project....
Changed : 
*******************************************************************************/
(IN_COST_CENTER_CODE IN     VARCHAR2
,OUT_REF_CUR   OUT  REF_CURSOR
,OUT_REF_CUR1   OUT  REF_CURSOR
);

PROCEDURE LEAD_BANK_TO_SP 
/*******************************************************************************
    This procedure is intended to select records from Lead bank table and the
    member bank table that we will tranfer the records to.

Created : 07/08/2015 nxk927/jxc517 CCN Project....
Changed : 
*******************************************************************************/
(IN_COST_CENTER_CODE IN     VARCHAR2
,OUT_REF_CUR   OUT  REF_CURSOR);


PROCEDURE MAKE_LEAD_PROCESS
/*******************************************************************************
    This procedure is the shortcut proc to make the member bank as the lead 
    and transfer all the other member to the new lead.

Created : 07/08/2015 nxk927/jxc517 CCN Project....
Changed : 09/29/2015 sxh487 Added an IN_MAKE_LEAD_FLAG to bypass the
          Warning message which states that "this process will delete 
          all Futures". This Needs to be a 'Y' if the user hits the 'OK' button
          to proceed with the process 
*******************************************************************************/
(IN_MAKE_LEAD_FLAG           IN     VARCHAR2
,IN_NEW_LEAD_CC              IN     VARCHAR2
,IN_USER_ID                  IN     VARCHAR2
,IN_EFFECTIVE_DATE           IN     DATE);

PROCEDURE LEAD_TRANSFER_PROCESS(
/***********************************************************
	This procedure will be called from ui to transfer particular cost center
    from one lead to another
        
EXAMPLE INPUT:
<?XML VERSION="1.0" ENCODING="UTF-8"?>
<MEMBER_TRANSFER_UI>
    <USER_ID>XXXXXX</USER_ID>
    <FROM_LEAD_CC>701234</FROM_LEAD_CC>
    <TO_LEAD_CC>705678</TO_LEAD_CC>
    <MEMBER_STORES>
      <MEMBER><MEMBER_STORE_NBR>701451</MEMBER_STORE_NBR><EFFECTIVE_DATE>MM-DD-RRRR HH:MI:SS AM</EFFECTIVE_DATE></MEMBER>
      <MEMBER><MEMBER_STORE_NBR>702000</MEMBER_STORE_NBR><EFFECTIVE_DATE>MM-DD-RRRR HH:MI:SS AM</EFFECTIVE_DATE></MEMBER>
    </MEMBER_STORE>
</MEMBER_TRANSFER_UI>

Created : 07/08/2015 nxk927/jxc517 CCN Project....
Changed : 09/14/2015 axk326 CCN Project....
          Added EFFECTIVE_DATE node to the XML
Changed : 09/29/2015 sxh487 Added an IN_TRANSFER_FLAG to bypass the
          Warning message which states that "this process will delete 
          all Futures". This Needs to be a 'Y' if the user hits the 'OK' button
          to proceed with the process 
************************************************************/
IN_TRANSFER_FLAG          IN VARCHAR2,
IN_XML                    CLOB);

PROCEDURE ACCNT_MNTNC_UI_DELETE_SP(
/***********************************************************
This procedure is used to delete the bank accounts future records
based on the future id and bank account number that are passed as inputs

Created : 07/13/2015 jxc517 CCN Project....
Changed :
************************************************************/
    IN_BANK_ACCOUNT_NUMBER  IN  VARCHAR2,
    IN_FUTURE_ID            IN  NUMBER);

PROCEDURE CODE_HEADER_S_SP (
/**********************************************************
This procedure is a Wrapper to BANKING_PICK_LIST_PKG.CODE_HEADER_S_SP
Procedure

created : 11/24/2015 dxv848 CCN Project....
changed :
**********************************************************/
IN_HEADER_NAME          IN CODE_HEADER.CODE_HEADER_NAME%TYPE
,IN_HEADER_TYPE         IN CODE_HEADER.CODE_HEADER_TYPE%TYPE
,OUT_CODE_HEADER_CUR    OUT REF_CURSOR)
;

PROCEDURE CODE_DETAIL_S_SP (
/**********************************************************
This procedure is a Wrapper to BANKING_PICK_LIST_PKG.CODE_DETAIL_S_SP
Procedure

created : 11/24/2015 dxv848 CCN Project....
changed :
**********************************************************/
IN_HEADER_NAME        IN CODE_DETAIL.CODE_HEADER_NAME%TYPE
,IN_HEADER_TYPE       IN CODE_DETAIL.CODE_HEADER_TYPE%TYPE
,OUT_CODE_DETAIL_CUR  OUT REF_CURSOR)
;

PROCEDURE CODE_DETAIL_DESC_SP (
/**********************************************************
	This procedure is Wrapper to BANKING_PICK_LIST_PKG.CODE_DETAIL_DESC_SP
Procedure

created : 11/21/2015 dxv848 CCN Project....
changed :
**********************************************************/
IN_HEADER_NAME       IN CODE_DETAIL.CODE_HEADER_NAME%TYPE
,IN_HEADER_TYPE      IN CODE_DETAIL.CODE_HEADER_TYPE%TYPE
,IN_DETAIL_VALUE     IN CODE_DETAIL.CODE_DETAIL_VALUE%TYPE
,OUT_CODE_DETAIL_CUR OUT REF_CURSOR)
;

PROCEDURE CODE_DETAIL_INSERT(
/**********************************************************
  This procedure is a Wrapper to BANKING_PICK_LIST_PKG.CODE_DETAIL_INSERT
Procedure
 This procedure will insert into the CODE_DETAIL table
<CODE_DETAIL_UI>
  <CODE_DETAIL>
      <CODE_HEADER_NAME>SAT</CODE_HEADER_NAME>
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE>
      <CODE_DETAIL_VALUE>CD</CODE_DETAIL_VALUE>
      <CODE_DETAIL_DESCRIPTION>TEST</CODE_DETAIL_DESCRIPTION>
      <CODE_DETAIL_EXPIRE_FLAG></CODE_DETAIL_EXPIRE_FLAG>
      <CODE_DETAIL_EXPIRE_USER></CODE_DETAIL_EXPIRE_USER>
	    <CODE_DETAIL_EXPIRE_EFF_DATE></CODE_DETAIL_EXPIRE_EFF_DATE>
	    <CODE_DETAIL_ID>1</CODE_DETAIL_ID>
      <CODE_DETAIL_CREATE_USER></CODE_DETAIL_CREATE_USER>
	    <CODE_DETAIL_EFF_DATE></CODE_DETAIL_EFF_DATE>
  </CODE_DETAIL>
  <CODE_DETAIL>
      <CODE_HEADER_NAME>SAT</CODE_HEADER_NAME>
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE>
      <CODE_DETAIL_VALUE>CE</CODE_DETAIL_VALUE>
      <CODE_DETAIL_DESCRIPTION>TEST</CODE_DETAIL_DESCRIPTION>
      <CODE_DETAIL_EXPIRE_FLAG></CODE_DETAIL_EXPIRE_FLAG>
      <CODE_DETAIL_EXPIRE_USER></CODE_DETAIL_EXPIRE_USER>
	    <CODE_DETAIL_EXPIRE_EFF_DATE></CODE_DETAIL_EXPIRE_EFF_DATE>
	    <CODE_DETAIL_ID>2</CODE_DETAIL_ID>
      <CODE_DETAIL_CREATE_USER></CODE_DETAIL_CREATE_USER>
	    <CODE_DETAIL_EFF_DATE></CODE_DETAIL_EFF_DATE>
  </CODE_DETAIL>
  <CODE_DETAIL>
      <CODE_HEADER_NAME>SAT</CODE_HEADER_NAME>
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE>
      <CODE_DETAIL_VALUE>CF</CODE_DETAIL_VALUE>
      <CODE_DETAIL_DESCRIPTION>TES</CODE_DETAIL_DESCRIPTION>
      <CODE_DETAIL_EXPIRE_FLAG></CODE_DETAIL_EXPIRE_FLAG>
      <CODE_DETAIL_EXPIRE_USER></CODE_DETAIL_EXPIRE_USER>
	    <CODE_DETAIL_EXPIRE_EFF_DATE></CODE_DETAIL_EXPIRE_EFF_DATE>
	    <CODE_DETAIL_ID>3</CODE_DETAIL_ID>
      <CODE_DETAIL_CREATE_USER></CODE_DETAIL_CREATE_USER>
	    <CODE_DETAIL_EFF_DATE></CODE_DETAIL_EFF_DATE>
  </CODE_DETAIL>
</CODE_DETAIL_UI>

created : 01/06/2016 dxv848 CCN Project....
changed :
**********************************************************/
    IN_XML                VARCHAR2);

PROCEDURE CODE_DETAIL_UPDATE(
/**********************************************************
	This procedure is a Wrapper to BANKING_PICK_LIST_PKG.CODE_DETAIL_UPDATE
Procedure
  This procedure will UPDATE into the table CODE_DETAIL
<CODE_DETAIL_UI>
  <CODE_DETAIL>
      <CODE_HEADER_NAME>SAT</CODE_HEADER_NAME>
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE>
      <CODE_DETAIL_VALUE>CE</CODE_DETAIL_VALUE>
      <CODE_DETAIL_DESCRIPTION>TEST CHANGE</CODE_DETAIL_DESCRIPTION>
      <CODE_DETAIL_EXPIRE_FLAG></CODE_DETAIL_EXPIRE_FLAG>
      <CODE_DETAIL_EXPIRE_USER></CODE_DETAIL_EXPIRE_USER>
	    <CODE_DETAIL_EXPIRE_EFF_DATE></CODE_DETAIL_EXPIRE_EFF_DATE>
	    <CODE_DETAIL_ID>2</CODE_DETAIL_ID>
      <CODE_DETAIL_CREATE_USER></CODE_DETAIL_CREATE_USER>
	    <CODE_DETAIL_EFF_DATE></CODE_DETAIL_EFF_DATE>
  </CODE_DETAIL>
  </CODE_DETAIL_UI>

created : 01/06/2016 dxv848 CCN Project....
changed :
**********************************************************/
    IN_XML                VARCHAR2);

PROCEDURE CODE_HEADER_INSERT(
/**********************************************************
		This procedure is a Wrapper to BANKING_PICK_LIST_PKG.CODE_HEADER_INSERT
Procedure
	This procedure will insert into the table CODE_HEADER
<CODE_HEADER_UI>
  <CODE_HEADER>
      <CODE_HEADER_NAME>SAT</CODE_HEADER_NAME>
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE>
      <CODE_HEADER_DESCRIPTION>TESTING</CODE_HEADER_DESCRIPTION>
      <CODE_HEADER_EXPIRE_FLAG></CODE_HEADER_EXPIRE_FLAG>
      <CODE_HEADER_EXPIRE_USER></CODE_HEADER_EXPIRE_USER>
	    <CODE_HEADER_EXPIRE_EFF_DATE></CODE_HEADER_EXPIRE_EFF_DATE>
	    <CODE_HEADER_DTL_VAL_SIZE>1</CODE_HEADER_DTL_VAL_SIZE>
      <CODE_HEADER_DTL_VAL_DEFAULT></CODE_HEADER_DTL_VAL_DEFAULT>
      <CODE_HEADER_CREATE_USER></CODE_HEADER_CREATE_USER>
	    <CODE_HEADER_EFF_DATE></CODE_HEADER_EFF_DATE>
  </CODE_HEADER>
</CODE_HEADER_UI>

created : 01/06/2016 dxv848 CCN Project....
changed :
**********************************************************/
    IN_XML                VARCHAR2);

PROCEDURE CODE_HEADER_UPDATE(
/**********************************************************
   This procedure is a Wrapper to BANKING_PICK_LIST_PKG.CODE_HEADER_UPDATE
Procedure
 This procedure will UPDATE into the table CODE_HEADER
<CODE_HEADER_UI>
  <CODE_HEADER>
      <CODE_HEADER_NAME>SAT</CODE_HEADER_NAME>
      <CODE_HEADER_TYPE>COD</CODE_HEADER_TYPE>
      <CODE_HEADER_DESCRIPTION>TESTING</CODE_HEADER_DESCRIPTION>
      <CODE_HEADER_EXPIRE_FLAG>Y</CODE_HEADER_EXPIRE_FLAG>
      <CODE_HEADER_EXPIRE_USER></CODE_HEADER_EXPIRE_USER>
	    <CODE_HEADER_EXPIRE_EFF_DATE></CODE_HEADER_EXPIRE_EFF_DATE>
	    <CODE_HEADER_DTL_VAL_SIZE>2</CODE_HEADER_DTL_VAL_SIZE>
      <CODE_HEADER_DTL_VAL_DEFAULT></CODE_HEADER_DTL_VAL_DEFAULT>
      <CODE_HEADER_CREATE_USER></CODE_HEADER_CREATE_USER>
	    <CODE_HEADER_EFF_DATE></CODE_HEADER_EFF_DATE>
  </CODE_HEADER>
  </CODE_HEADER_UI>

created : 01/06/2016 dxv848 CCN Project....
changed :
**********************************************************/
    IN_XML                VARCHAR2);

END BANKING_UI_INTERFACE_APP_PKG;
