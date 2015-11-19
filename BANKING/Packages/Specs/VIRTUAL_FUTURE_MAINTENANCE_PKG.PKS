CREATE OR REPLACE PACKAGE VIRTUAL_FUTURE_MAINTENANCE_PKG
AS
/**********************************************************
This Package contains all the procedures used to
maintain a virtual future

Created : 10/21/2015 jxc517 CCN Project....
Changed :
**********************************************************/
TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE VIRTUAL_FUTURE_UPSERT_SP ( 
/******************************************************************************
	This procedure performs the core insert/update process for virtual future maintenance

Created : 10/21/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_BANK_ACCOUNT_NBR         IN     BANK_ACCOUNT.BANK_ACCOUNT_NBR%TYPE,
    IN_REAL_FUTURE_BANK_ACCOUNT IN     VARCHAR2,
    IN_TRANSFER_VRTL_FTR        IN     VARCHAR2,
    IN_BANK_TYPE_CHNG_VRTL_FTR  IN     VARCHAR2);

END VIRTUAL_FUTURE_MAINTENANCE_PKG;

