create or replace PACKAGE CUSTOMER_DEPOSITS_INITLOAD
/****************************************************************
This package will load the Customer Deposits from PNP
created : 08/10/2017 sxp130 CCN Project....
changed :
*****************************************************************/
IS

PROCEDURE CCN_CD_INITLOAD_SP
/******************************************************************
This Procedure is a wrapper for the Initial Load of the customer deposit tables
    * Deletes all the customer deposit tables
    * Loads all the customer deposit tables

created : 08/10/2017 sxp130 CCN Project....
changed :
******************************************************************/
;

END CUSTOMER_DEPOSITS_INITLOAD;