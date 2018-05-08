create or replace PACKAGE CUSTOMER_DEPOSIT_MAINT_PKG AS 
/*********************************************************** 
This package BODY is intended to hold reuseable objects that are 
available to be used by the entire schema

created : 09/27/2017 sxh487 CCN project.....
************************************************************/
PROCEDURE ORIG_DEP_REM_BAL_UPD(
/**********************************************************
This function updates the original references for a Redemption
and updates the Deposit with remaining balance

Created : 03/26/2018 SXH487
**********************************************************/
IN_TOTAL_SALES             IN     CUSTOMER_DEPOSIT_DETAILS.TOTAL_SALES%TYPE, 
IN_CUSTOMER_ACCOUNT_NUMBER IN     CUSTOMER_DEPOSIT_DETAILS.CUSTOMER_ACCOUNT_NUMBER%TYPE, 
IN_TRANSACTION_DATE        IN     CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_DATE%TYPE,
OUT_TRANSACTION_NUMBER        OUT CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_NUMBER%TYPE,
OUT_TERMINAL_NUMBER           OUT CUSTOMER_DEPOSIT_DETAILS.TERMINAL_NUMBER%TYPE,
OUT_TRANSACTION_DATE          OUT CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_DATE%TYPE
);

PROCEDURE CUSTOMER_DEPOSIT_UPSERT_SP(
/******************************************************************************
This is a wrapper for the upsert procedure
created : 05/04/2018 sxh487 -- CCN Project Team
******************************************************************************/
IN_CUST_HEADERXML   IN CLOB,
IN_CUST_DETAIL_XML  IN CLOB);

END CUSTOMER_DEPOSIT_MAINT_PKG;