CREATE OR REPLACE VIEW STORE_DRAFTS_DETAIL_VW
AS
SELECT
/*******************************************************************************
This view is used to get all the draft item details for a store draft

Created  : 04/26/2016 jxc517 CCN Project Team....
Modified : 
*******************************************************************************/
       COST_CENTER_CODE,
       CHECK_SERIAL_NUMBER,
       TRANSACTION_DATE,
       TERMINAL_NUMBER,
       TRANSACTION_NUMBER,
       CUSTOMER_ACCOUNT_NUMBER,
       CUSTOMER_JOB_NUMBER,
       GL_PRIME_ACCOUNT_NUMBER,
       GL_SUB_ACCOUNT_NUMBER,
       ITEM_QUANTITY,
       ITEM_PRICE,
       ITEM_EXT_AMOUNT,
       BOOK_DATE_SEQUENCE,
       LBR_TRANSACTION_DATE,
       LBR_TERMINAL_NUMBER,
       LBR_TRANSACTION_NUMBER
  FROM STORE_DRAFTS_DETAIL;