create or replace PACKAGE CUSTOMER_DEPOSIT_MAINT_PKG AS 
/*********************************************************** 
This package BODY is intended to hold reuseable objects that are 
available to be used by the entire schema

created : 09/27/2017 sxh487 CCN project.....
************************************************************/

FUNCTION  GET_LAST_VALUE_NET_BAL(
/*******************************************************************************
GET_LAST_VALUE_NET_BAL

This procedure is intended to update customer_deposit_details records
created : 09/05/2018 sxh487 -- ccn coding project....
changed : 02/12/2019 pxa852 CCN Project Team...
          Modified code to replace the old table with new table CUSTOMER_DEPOSIT_TRANSACTION_DTL
          that was created as part of new data model
*******************************************************************************/
    IN_CUSTOMER_ACCOUNT_NUMBER    IN     CUSTOMER_DEPOSIT_TRANSACTION_DTL.CUSTOMER_ACCOUNT_NUMBER%TYPE)
RETURN NUMBER;

FUNCTION CHECK_IF_HEADER_RECORD_EXISTS(
/*******************************************************************************
This procedure is intended to check if the record present in header table before inserting into
detail table.
created : 03/12/2019 pxa852 CCN Project Team...
changed :
*******************************************************************************/
    IN_CUST_DEP_DET_ROW    IN     CUSTOMER_DEPOSIT_TRANSACTION_DTL%ROWTYPE)
RETURN VARCHAR2;

PROCEDURE ORIG_DEP_REM_BAL_UPD(
/**********************************************************
This function updates the original references for a Redemption
and updates the Deposit with remaining balance

Created : 03/26/2018 SXH487
Changed : 11/26/2018 sxg151 ASP-1150 : Renamed input variable name( TOTAL_SALES to CSTMR_DPST_SALES_LN_ITM_AMT)
        : 02/12/2019 pxa852 CCN Project Team...
          Modified code to replace the old table with new table CUSTOMER_DEPOSIT_TRANSACTION_DTL
          that was created as part of new data model
**********************************************************/
    IN_CSTMR_DPST_SALES_LN_ITM_AMT    IN       CUSTOMER_DEPOSIT_TRANSACTION_DTL.CSTMR_DPST_SALES_LN_ITM_AMT%TYPE,
    IN_CUSTOMER_ACCOUNT_NUMBER        IN       CUSTOMER_DEPOSIT_TRANSACTION_DTL.CUSTOMER_ACCOUNT_NUMBER%TYPE,
    IN_TRANSACTION_DATE               IN       CUSTOMER_DEPOSIT_TRANSACTION_DTL.TRANSACTION_DATE%TYPE,
    OUT_TRANSACTION_NUMBER               OUT   CUSTOMER_DEPOSIT_TRANSACTION_DTL.TRANSACTION_NUMBER%TYPE,
    OUT_TERMINAL_NUMBER                  OUT   CUSTOMER_DEPOSIT_TRANSACTION_DTL.TERMINAL_NUMBER%TYPE,
    OUT_TRANSACTION_DATE                 OUT   CUSTOMER_DEPOSIT_TRANSACTION_DTL.TRANSACTION_DATE%TYPE
);

PROCEDURE CUSTOMER_DEPOSIT_UPSERT_SP(
/******************************************************************************
This is a wrapper for the upsert procedure
created : 05/04/2018 sxh487 -- CCN Project Team
Modified: 02/07/2019 pxa852 CCN Project Team...
          Modified code to remove header xml input parameter
******************************************************************************/
    IN_CUST_DETAIL_XML   IN     CLOB);

END CUSTOMER_DEPOSIT_MAINT_PKG;