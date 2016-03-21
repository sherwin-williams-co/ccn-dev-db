CREATE OR REPLACE PACKAGE ACC_MEM_MAIN_COMMONTOOLS AS
/**********************************************************
This Package contains all the procedures used commonly in
account maintenance window and concentration transfer window

Created : 12/10/2015 dxv848 CCN Project....
Changed :
**********************************************************/

FUNCTION IS_REAL_FUTURE_BANK_ACCOUNT(
/******************************************************************************
	This procedure checks if the passed future is a virtual future or real future
  returns 'N' if it is virtual future
  returns 'Y' if it is real future

Created : 10/15/2015 jxc517 CCN Project....
Changed :
*******************************************************************************/
    IN_BANK_ACCOUNT_NBR     IN     BANK_ACCOUNT.BANK_ACCOUNT_NBR%TYPE) RETURN VARCHAR2;
  
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

PROCEDURE UNEXPR_REAL_MBRS(
/******************************************************************************
	This procedure unexpire the transferred from leads members as that transfer is
  obsolete as part of this current data updates for the virtual future

Created : 12/18/2015 dxv848 CCN Project....
Changed :
*******************************************************************************/
    IN_BANK_ACCOUNT_NBR         IN     BANK_ACCOUNT.BANK_ACCOUNT_NBR%TYPE);

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

PROCEDURE ACCNT_MNTNC_UI_DELETE_SP (
/******************************************************************************
	This procedure performs the core process for Account Maintenance Window,
  delete process

Created : 07/13/2015 jxc517 CCN Project....
Changed :
*******************************************************************************/
    IN_BANK_ACCOUNT_NUMBER  IN  VARCHAR2,
    IN_FUTURE_ID            IN  NUMBER);

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

PROCEDURE EXPIRE_PREV_CURR_MEM(
/*******************************************************************************
    This procedure is intended to check and expire previous current records
    before inserting new record

Created : 10/21/2015 dxv848 CCN Project....
Changed :
*******************************************************************************/
IN_BANK_ACCOUNT_NBR    IN     BANK_ACCOUNT.BANK_ACCOUNT_NBR%TYPE,
IN_LEAD_STORE_NBR      IN     LEAD_BANK_CC.LEAD_STORE_NBR%TYPE,
IN_MEMBER_STORE_NBR    IN     MEMBER_BANK_CC.MEMBER_STORE_NBR%TYPE,
IN_NEW_EFFECTIVE_DATE  IN     DATE);

END ACC_MEM_MAIN_COMMONTOOLS;