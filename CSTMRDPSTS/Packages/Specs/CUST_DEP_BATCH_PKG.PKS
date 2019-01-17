create or replace PACKAGE CUST_DEP_BATCH_PKG AS
/*********************************************************** 
This package spec has procedures and functions related to the batch
job table

created : 09/27/2017 sxh487 CCN project
revisions: 
************************************************************/

PROCEDURE DAILY_NET_BAL_CLOSE_DATE_UPD
/******************************************************************************
DAILY_NET_BAL_CLOSE_DATE_UPD -  This procedure is intended to update the record in the CUSTOMER_DEPOSIT_DETAILS which net Balance is zero.

Created  : 01/15/2019 sxg151 CCN Team....
         : ASP-1187.
Modified :
*******************************************************************************/
;
END CUST_DEP_BATCH_PKG;