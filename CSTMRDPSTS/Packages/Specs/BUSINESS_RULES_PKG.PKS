create or replace PACKAGE BUSINESS_RULES_PKG
AS
/**********************************************************
  This Package performs all the business rules that are applicable
  for Costomer Deposits application

created : 10/24/2018 sxg151 c517 CCN Project....
changed :
**********************************************************/

PROCEDURE CHECK_ACCOUNT_NBR(
/******************************************************************************
This procedure is intended to check if any record's sales amount changed from UI

Created : 10/30/2018 sxg151  CCN Project....
        : ASP-1150 : Add business rule to check account number is provided or not..
*******************************************************************************/
    IN_CUSTOMER_ACCOUNT_NUMBER   IN     CUSTOMER_DEPOSIT_HEADER.CUSTOMER_ACCOUNT_NUMBER%TYPE);

PROCEDURE VALIDATE_HDR_DET_ACCT_NBR(
/******************************************************************************
This procedure is intended to check if any record's sales amount changed from UI

Created : 10/30/2018 sxg151  CCN Project....
        : ASP-1150 : Add business rule to check account number is provided or not..
        : 02/14/2019 pxa852 CCN Project Team...
          Modified code to replace old table with new table CUSTOMER_DEPOSIT_TRANSACTION_DTL
          that was created as part of new data model
*******************************************************************************/
    IN_HDR_CUST_ACNT_NBR   IN     CUSTOMER_DEPOSIT_HEADER.CUSTOMER_ACCOUNT_NUMBER%TYPE,
    IN_DTL_CUST_ACNT_NBR   IN     CUSTOMER_DEPOSIT_TRANSACTION_DTL.CUSTOMER_ACCOUNT_NUMBER%TYPE);

END BUSINESS_RULES_PKG;