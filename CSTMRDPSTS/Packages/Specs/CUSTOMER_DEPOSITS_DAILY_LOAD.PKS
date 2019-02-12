create or replace PACKAGE CUSTOMER_DEPOSITS_DAILY_LOAD
/****************************************************************
This package will load the Customer Deposits from PNP
created : 09/26/2017 sxh487 CCN Project....
changed :
*****************************************************************/
IS

PROCEDURE CSTMR_DEPOSIT_DLY_LOAD_SP
/******************************************************************
CSTMR_DEPOSIT_DLY_LOAD_SP

This procedure is a wrapper for the daily load of the customer deposit tables
   * loads all the customer deposit tables

created : 09/08/2017 sxh487 ccn project....
changed :
******************************************************************/
;

PROCEDURE LOAD_CUSTOMER_DEPOSIT_HDR(
/*****************************************************************************
LOAD_CUSTOMER_DEPOSIT_HDR

This procedure will load the customer_deposit_header table from pnp legacy idms database.

created : 03/05/2018 sxh487 ccn project....
changed : 05/29/2018 sxh487 Added NON_MERCH_CODE ='05' for line item amount
******************************************************************************/
IN_RLS_RUN_CYCLE POS_CCN_LOAD_STATUS.RLS_RUN_CYCLE%TYPE);

PROCEDURE LOAD_CUSTOMER_DEPOSIT_TRANSACTION_HDR(
/*****************************************************************************
LOAD_CUSTOMER_DEPOSIT_TRANSACTION_HDR

This procedure will load the customer_deposit_transaction_hdr table from pnp legacy idms database.

created : 02/06/2019 pxa852 ccn project....
changed :
******************************************************************************/
IN_RLS_RUN_CYCLE POS_CCN_LOAD_STATUS.RLS_RUN_CYCLE%TYPE);

PROCEDURE LOAD_CUSTOMER_DEPOSIT_DETAILS(
/*****************************************************************************
LOAD_CUSTOMER_DEPOSIT_DETAILS

This procedure will load the customer_deposit_details table from pnp legacy idms database.

created : 09/08/2017 sxh487 ccn project....
changed : 01/26/2018 sxh487 Added logic to get the last cumulative total for calculating the 
          net balance
        : 03/20/2018 sxh487 Added logic to add records in CUST_DEP_CREDIT_DETAILS and CUST_DEP_REDEMPTION_DETAILS 
        : 05/29/2018 sxh487 Added NON_MERCH_CODE ='05' for line item amount
******************************************************************************/
IN_RLS_RUN_CYCLE POS_CCN_LOAD_STATUS.RLS_RUN_CYCLE%TYPE);

PROCEDURE CUST_DEP_RED_ORIGINAL_DTLS_UPD(
/*****************************************************************************
This procedure will find if there are any Redemptions with out deposits then tie back that redemption to the deposit.

created : 01/17/2019 pxa852 ccn project....
changed :
******************************************************************************/
IN_CUSTOMER_ACCOUNT_NUMBER IN CUSTOMER_DEPOSIT_TRANSACTION_DTL.CUSTOMER_ACCOUNT_NUMBER%TYPE,
IN_TRANSACTION_DATE        IN CUSTOMER_DEPOSIT_TRANSACTION_DTL.TRANSACTION_DATE%TYPE);

END CUSTOMER_DEPOSITS_DAILY_LOAD;