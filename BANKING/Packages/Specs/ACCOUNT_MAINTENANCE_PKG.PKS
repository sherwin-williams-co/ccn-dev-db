CREATE OR REPLACE PACKAGE         ACCOUNT_MAINTENANCE_PKG
AS
/**********************************************************
This Package contains all the procedures used in
account maintenance window

Created : 07/09/2015 jxc517 CCN Project....
Changed :
**********************************************************/
TYPE REF_CURSOR IS REF CURSOR;

FUNCTION IS_REAL_FUTURE_BANK_ACCOUNT(
/******************************************************************************
	This procedure checks if the passed future is a virtual future or real future
  returns 'N' if it is virtual future
  returns 'Y' if it is real future

Created : 10/15/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_BANK_ACCOUNT_NBR     IN     BANK_ACCOUNT.BANK_ACCOUNT_NBR%TYPE) RETURN VARCHAR2;

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

PROCEDURE EXPIRE_PREVIOUS_BANK_ACCOUNT(
/*******************************************************************************
    This procedure is intended to check and expire previous records
    before inserting new record

Created : 07/31/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_BANK_ACCOUNT_NBR    IN     BANK_ACCOUNT.BANK_ACCOUNT_NBR%TYPE,
IN_NEW_EFFECTIVE_DATE  IN     DATE,
IN_FLAG                IN     VARCHAR2);

PROCEDURE ACCNT_MNTNC_UI_UPSERT_SP ( 
/******************************************************************************
	This procedure performs the core insert/update process for Account Maintenance Window

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
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
    IN_BANK_ACCOUNT_FTR_REC     IN     BANK_ACCOUNT_FUTURE%ROWTYPE);

PROCEDURE ACCNT_MNTNC_UI_DELETE_SP ( 
/******************************************************************************
	This procedure performs the core process for Account Maintenance Window,
  delete process

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_BANK_ACCOUNT_NUMBER  IN  VARCHAR2,
    IN_FUTURE_ID            IN  NUMBER);

PROCEDURE ACCNT_MNTNC_EXP_DELETE_SP ( 
/******************************************************************************
	This procedure performs the delete process for the MAKE_LEAD/TRANSFER,
  delete process for expired member future records

Created : 10/02/2015 sxh487 CCN Project....
Changed : 
*******************************************************************************/
    IN_BANK_ACCOUNT_NUMBER      IN  VARCHAR2,
    IN_LEAD_STORE_NBR           IN  VARCHAR2,
    IN_MEMBER_STORE_NBR         IN  VARCHAR2,
    IN_FUTURE_ID                IN  NUMBER);
    
PROCEDURE ACCNT_MNTNC_UNEXPIRE_SP ( 
/******************************************************************************
	This procedure Un-Expires the current records that have a future
  expiration date
  
Created : 09/28/2015 sxh487 CCN Project....
Changed : 
*******************************************************************************/
    IN_BANK_ACCOUNT_NUMBER  IN  VARCHAR2);

PROCEDURE ACCNT_MNTNC_TRNSFR_UNEXPIRE_SP ( 
/******************************************************************************
	This procedure Un-Expires the current records that are cost center related and
  have a future expiration date
  
Created : 09/28/2015 sxh487 CCN Project....
Changed : 
*******************************************************************************/
    IN_BANK_ACCOUNT_NUMBER  IN  VARCHAR2,
    IN_LEAD_STORE_NBR       IN  VARCHAR2,
    IN_MEMBER_STORE_NBR     IN  VARCHAR2);
    
END ACCOUNT_MAINTENANCE_PKG;

