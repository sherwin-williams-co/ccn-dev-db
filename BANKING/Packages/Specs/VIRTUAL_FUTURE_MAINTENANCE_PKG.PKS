create or replace PACKAGE VIRTUAL_FUTURE_MAINTENANCE_PKG
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

PROCEDURE INSRT_BNK_DP_BG_DTL_VIR_CURR(
/*******************************************************************************
This procedure is intended GET THE BANK_DEP_BAG_TICK FUTURE 
records if the lead we are transfering the member to is a virtual lead and 
insert the same as a virtual member in current table

Created : 11/12/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
      IN_COST_CENTER_CODE     IN    VARCHAR2,
      IN_BANK_ACCOUNT_NBR     IN    VARCHAR2,
      IN_FUTURE_ID            IN    NUMBER,
      IN_FLAG                 IN    VARCHAR2);
      
PROCEDURE INSERT_BANK_DPST_DTLS_VIR_CUR(
/*******************************************************************************
This procedure is intended GET THE BANK_DEP_TICK FUTURE 
records if the lead we are transfering the member to is a virtual lead and  
insert the same as a virtual member in current table

Created : 11/12/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
      IN_COST_CENTER_CODE     IN    VARCHAR2,
      IN_BANK_ACCOUNT_NBR     IN    VARCHAR2,
      IN_FUTURE_ID            IN    NUMBER,
      IN_FLAG                 IN    VARCHAR2);      

PROCEDURE CRTE_VIR_TRSFR_MBR_BAK_CC_REC(
/***********************************************************
This procedure is used to insert member information for transfer process
in current table for the lead that is a virtual lead in future where the 
member is being transferred. So we will have record in virtual current and future

Created : 11/12/2015 nxk927 CCN Project....
Changed : 
************************************************************/
IN_FUTURE_ID           IN     NUMBER,
IN_MBR_BANK_CC_REC     IN     MEMBER_BANK_CC%ROWTYPE,
IN_FLAG                IN     VARCHAR2);

END VIRTUAL_FUTURE_MAINTENANCE_PKG;