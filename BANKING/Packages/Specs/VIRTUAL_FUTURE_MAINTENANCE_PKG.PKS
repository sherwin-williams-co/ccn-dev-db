create or replace PACKAGE VIRTUAL_FUTURE_MAINTENANCE_PKG
AS
/**********************************************************
This Package contains all the procedures used to
maintain a virtual future

Created : 10/21/2015 jxc517 CCN Project....
Changed : rxa457 07/31/2017 CCN Project...
          added new functions / procedures ...IS_TRANSFER_VRTL_FTR;  IS_REAL_FUTURE_BANK_ACCOUNT; 
           IS_VIRTUAL_FTR_MBR_STR; VRTL_FTR_MBR_BANK_CC_UPDT; IS_BANK_TYPE_CHNG_VRTL_FTR
**********************************************************/
TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE VIRTUAL_FUTURE_UPSERT_SP ( 
/******************************************************************************
	This procedure performs the core insert/update process for virtual future maintenance

Created : 10/21/2015 jxc517 CCN Project....
Changed : rxa457 07/18/2017 CCN Project Team...
             Removed unused IN parameter IN_BANK_TYPE_CHNG_VRTL_FTR
*******************************************************************************/
    IN_BANK_ACCOUNT_NBR         IN     BANK_ACCOUNT.BANK_ACCOUNT_NBR%TYPE,
    IN_REAL_FUTURE_BANK_ACCOUNT IN     VARCHAR2,
    IN_TRANSFER_VRTL_FTR        IN     VARCHAR2);

PROCEDURE VRTL_FTR_MBR_BANK_CC_UPDT(
/******************************************************************************
    This procedure will update the virtual future member details with the current records
    updated details
    Note: Previously this Procedure was named as UPDT_VIRTUAL_FTR_MBR_STR_DTLS and 
           was part of member_maintenance_pkg

Created : 07/31/2017 RXA457 CCN Project....
*******************************************************************************/
IN_MBR_BANK_CC_REC        IN     MEMBER_BANK_CC%ROWTYPE);

FUNCTION IS_VIRTUAL_FTR_MBR_STR(
/******************************************************************************
    This function will determine if this is a virtual future store member or 
    a real future store member
    Note: - Function moved from MEMBER_MAINTENANCE_PKG
Created : 07/31/2017 rxa457 CCN Project....
*******************************************************************************/
IN_MBR_BANK_CC_REC        IN     MEMBER_BANK_CC%ROWTYPE) RETURN VARCHAR2;

FUNCTION IS_REAL_FUTURE_BANK_ACCOUNT(
/******************************************************************************
  This procedure checks if the passed future is a virtual future or real future
  returns 'N' if it is virtual future
  returns 'Y' if it is real future
  Note: - This function was Previously part of ACC_MEM_MAIN_COMMONTOOLS Package
Created : 07/31/2017 rxa457 CCN Project....
Changed :
*******************************************************************************/
    IN_BANK_ACCOUNT_NBR     IN     BANK_ACCOUNT.BANK_ACCOUNT_NBR%TYPE) RETURN VARCHAR2;

FUNCTION IS_TRANSFER_VRTL_FTR(
/*******************************************************************************
This procedure is intended to check if virtual future is created as part
of transfer process or bank type change

Returns 'Y' if it is part of transfer
  note: - Moved from ACCOUNT_MAINTENANCE_PKG 
Created : rxa457 07/31/2017 CCN Project....
*******************************************************************************/
IN_BANK_ACCOUNT_NBR    IN      BANK_ACCOUNT.BANK_ACCOUNT_NBR%TYPE) RETURN VARCHAR2;

FUNCTION IS_BANK_TYPE_CHNG_VRTL_FTR(
/*******************************************************************************
This procedure is intended to check if virtual future is created as part
of transfer process or bank type change

Returns 'Y' if it is part of bank type change
Note:  - This function was previously part of ACCOUNT_MAINTEANNCE_PKG
Created : 10/10/2017 rxa457 CCN project Team...
*******************************************************************************/
IN_BANK_ACCOUNT_NBR    IN      BANK_ACCOUNT.BANK_ACCOUNT_NBR%TYPE) RETURN VARCHAR2;

END VIRTUAL_FUTURE_MAINTENANCE_PKG;