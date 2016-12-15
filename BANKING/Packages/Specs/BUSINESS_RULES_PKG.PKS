create or replace PACKAGE BUSINESS_RULES_PKG
AS
/**********************************************************
  This Package performs all the business rules that are applicable
  for banking application

created : 05/26/2015 jxc517 CCN Project....
changed :
**********************************************************/

FUNCTION IS_BNK_ACCNT_EXPRTN_INVALID(
/******************************************************************************
  This function will return "Y" if the passed bank account contains active
  MICR Format or Lead as of the date it is being expired

Created : 07/30/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_BANK_ACCOUNT_NBR   IN     VARCHAR2,
IN_EXPIRATION_DATE    IN     DATE,
IN_FUTURE_ID          IN     NUMBER) RETURN VARCHAR2;

FUNCTION IS_MICR_EXPIRATION_INVALID(
/*******************************************************************************
  This function will return "Y" if the passed MICR-bank account combination
  contains active stores using it as of the date it is being expired

Created : 08/18/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_BANK_ACCOUNT_NBR   IN     VARCHAR2,
IN_MICR_FORMAT_ID     IN     NUMBER,
IN_EXPIRATION_DATE    IN     DATE,
IN_FUTURE_ID          IN     NUMBER) RETURN VARCHAR2;

FUNCTION IS_LEAD_EXPIRATION_INVALID(
/*******************************************************************************
  This function will return "Y" if the passed lead-bank account combination
  contains active members as of the date it is being expired

Created : 07/14/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE   IN     VARCHAR2,
IN_BANK_ACCOUNT_NBR   IN     VARCHAR2,
IN_EXPIRATION_DATE    IN     DATE,
IN_FUTURE_ID          IN     NUMBER) RETURN VARCHAR2;

PROCEDURE ACCOUNT_MAINTENANCE_BR_SP(
/******************************************************************************
    This procedure validates the business rules for Account Maintenance Window 

created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_BANK_ACCOUNT_REC                IN BANK_ACCOUNT%ROWTYPE,
    IN_BANK_ACCOUNT_FUTURE_REC         IN BANK_ACCOUNT_FUTURE%ROWTYPE,
    IN_LEAD_BANK_CC_REC                IN LEAD_BANK_CC%ROWTYPE,
    IN_LEAD_BANK_CC_FUTURE_REC         IN LEAD_BANK_CC_FUTURE%ROWTYPE,
    IN_BANK_MICR_FORMAT_TAB            IN TABLE_IU_PKG.BANK_MICR_FORMAT_TAB_TYPE,
    IN_BANK_MICR_FORMAT_FUTURE_TAB     IN TABLE_IU_PKG.BANK_MICR_FORMAT_FTR_TAB_TYPE);

PROCEDURE MEMBER_MAINTENANCE_BR_SP(
/******************************************************************************
    This procedure validates the business rules for Member Maintenance Window 

Created : 07/10/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_MBR_BANK_CC_TAB                IN TABLE_IU_PKG.MEMBER_BANK_CC_TAB_TYPE,
    IN_MBR_BANK_CC_FUTURE_TAB         IN TABLE_IU_PKG.MEMBER_BANK_CC_FUTURE_TAB_TYPE);

PROCEDURE LEAD_TRANSFER_BR_SP(
/******************************************************************************
    This procedure validates the business rules for Lead Transfer process of Concentration Window 

Created : 07/28/2015 jxc517 CCN Project....
Changed :
*******************************************************************************/
IN_XML           CLOB);

PROCEDURE MAKE_LEAD_BR_SP(
/******************************************************************************
    This procedure validates the business rules for Make Lead process of Concentration Window 

Created : 07/31/2015 nxk927/jxc517 CCN Project....
Changed :
*******************************************************************************/
IN_FROM_LEAD_CC   IN     VARCHAR2,
IN_EFFECTIVE_DATE IN     DATE);

PROCEDURE DEPOSIT_TICKET_MNTNC_BR_SP(
/******************************************************************************
    This procedure validates the business rules for Deposit Ticket Window

Created : 07/15/2015 jxc517 CCN Project Team....
Changed : 
*******************************************************************************/
    IN_BANK_DEP_TICK_REC        IN BANK_DEP_TICK%ROWTYPE,
    IN_BANK_DEP_TICK_FUTURE_REC IN BANK_DEP_TICK_FUTURE%ROWTYPE);

PROCEDURE DEPOSIT_BAG_TICKET_MNTNC_BR_SP(
/******************************************************************************
    This procedure validates the business rules for Deposit Bag TIcket Window

Created : 07/15/2015 axk326 CCN Project Team....
Changed : 10/20/2015 jxc517 CCN Project Team....
          Code has been changed to deal with Deposit Bag futures
*******************************************************************************/
    IN_BANK_DEP_BAG_TICK_REC     IN BANK_DEP_BAG_TICK%ROWTYPE,
    IN_BANK_DEP_BAG_TICK_FTR_REC IN BANK_DEP_BAG_TICK_FUTURE%ROWTYPE);

PROCEDURE PLACE_TCKT_ORDER_BR_SP(
/******************************************************************************
    This procedure validates the business rules for placing order from Deposit Bag TIcket Window

Created : 11/19/2015 nxk927 CCN Project Team....
Changed : 12/13/2016 nxk927 CCN Project Team....
          Signature changed to removed order date as it is not needed anymore
*******************************************************************************/
   IN_COST_CENTER        IN VARCHAR2,
   IN_FUTURE_ID          IN NUMBER);

PROCEDURE PLACE_BAG_ORDER_BR_SP(
/******************************************************************************
    This procedure validates the business rules for placing order from Deposit Bag TIcket Window

Created : 11/19/2015 nxk927 CCN Project Team....
Changed : 12/13/2016 nxk927 CCN Project Team....
          Signature changed to removed order date as it is not needed anymore
*******************************************************************************/
   IN_COST_CENTER        IN VARCHAR2,
   IN_FUTURE_ID          IN NUMBER);

PROCEDURE ACCOUNT_MAINTEN_CHECK_FUTURE(
/******************************************************************************
    This procedure validates the business rules for Make Lead process of Account Maintenance Window
    This procedure get the current and future store number and bank account number and checks the business rule
Created :  01/15/2016 dxv848 CCN Project ....
Changed :
*******************************************************************************/
IN_ROW_DATA               IN  CLOB,
IN_LEAD_FLAG              IN VARCHAR2);

FUNCTION GET_SNZ_SAM_CODE(
/******************************************************************************
  This function returns exception code defined by mainframe as CODE1(Exception code)
  for the cost center and bank account number passed
  as SNZ, SAM or null depending on the criteria below  for the UAR POS FILE generation
  1) SNZ  := item was loaded without a valid store number
  2) SAM  := item does not match account number shown on serial file
  3) NULL := no issue

Created : 02/08/2015 nxk927/dxv848 CCN Project....
Changed : 04/28/2016 nxk927 CCN Project....
          changed the function name from VALIDATE_CC_BNK_NBR to GET_SNZ_SAM_CODE
*******************************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2,
IN_BANK_ACCT_NBR    IN VARCHAR2) RETURN VARCHAR2;

FUNCTION IS_PLACING_DPT_TKT_BAG_ORD_OK(
/******************************************************************************
   This function returns Y or N depending on the cost center closed date and open date
   as of 01-Jan-2099
   
Created : 09/27/2016 nxk927 
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2) RETURN VARCHAR2;

END BUSINESS_RULES_PKG;