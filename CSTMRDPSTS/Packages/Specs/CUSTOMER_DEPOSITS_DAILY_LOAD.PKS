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

END CUSTOMER_DEPOSITS_DAILY_LOAD;