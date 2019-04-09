CREATE OR REPLACE VIEW CUSTOMER_DEPOSIT_VW
AS
  SELECT
/*******************************************************************************
This view will provide the CUSTOMER_DEPOSIT information.

Created  : 03/23/2018 sxh487 CCN Project
Modified : 05/29/2018 sxh487 Added CSTMR_DPST_SALES_LN_ITM_AMT
         : 11/19/2017 kxm302 Removed filter on CUSTOMER_ACCOUNT_NUMBER to include all customers
         : 01/22/2019 pxa852 CCN Project team...
           Added customer account number in order by clause.
         : 02/26/2019 pxa852 CCN Project Team...
           Modified this view to take the data from CUSTOMER_DEPOSIT_TRANSACTION_DTL table.
           Removed reference number, tran_timestamp columns as requested by Marissa
*******************************************************************************/
         CUSTOMER_ACCOUNT_NUMBER AS CUSTOMER_NUMBER,
         COST_CENTER_CODE AS STORE,
         TRANSACTION_TYPE TRAN_TYPE,
         TRANSACTION_NUMBER TRANS_NBR,
         TERMINAL_NUMBER,
         POS_TRANSACTION_CODE,
         TRANSACTION_DATE TRAN_DATE,
         TRAN_TIMESTAMP,
         CSTMR_DPST_SALES_LN_ITM_AMT,
         CUSTOMER_NET_BALANCE AS CUST_REM_BALANCE,
         ORGNL_DEPOSIT_TRANSACTION_NBR,
         ORGNL_DEPOSIT_TERMINAL_NBR,
         ORGNL_DEPOSIT_TRANSACTION_DATE,
         CLEARED_REASON,
         NOTES,
         CLOSED_DATE,
         GL_DIVISION
  FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL
 ORDER BY CUSTOMER_ACCOUNT_NUMBER;