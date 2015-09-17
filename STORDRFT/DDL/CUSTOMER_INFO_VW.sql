-- sxt410 09/16/2015 Script to create CUSTOMER_INFO_VW view.

CREATE OR REPLACE VIEW CUSTOMER_INFO_VW
AS 
SELECT 
/*******************************************************************************
This view holds required information about Customer.

Created  : 09/15/2015 SXT410 CCN Project Team...
Modified : 
*******************************************************************************/
        C.*
       ,CD.CUSTOMER_DETAIL_ID
       ,CD.GL_PRIME_ACCOUNT_NUMBER
       ,CD.GL_SUB_ACCOUNT_NUMBER
       ,CD.ITEM_DISCOUNT_AMOUNT
       ,CD.ITEM_DISCOUNT_CODE
       ,CD.ITEM_DISCOUNT_TYPE
       ,CD.ITEM_EXT_AMOUNT
       ,CD.ITEM_PRICE
       ,CD.ITEM_QUANTITY
       ,CD.ITEM_SALES_TAX_IND
       ,CD.PERCENT_OFF_LEVEL
       ,CD.PRICE_LEVEL_CODE
       ,CD.PROD_DESC_SRCE
       ,CD.SALES_NUMBER
       ,CD.SALES_PROMO_CODE
       ,CD.SCHEDULE_TYPE
       ,CD.SCHEDULE_VERSION
       ,CD.SEGMENT_CODE
  FROM CUSTOMER C,
       CUSTOMER_DETAILS CD
 WHERE C.COST_CENTER_CODE   = CD.COST_CENTER_CODE
   AND C.TRANSACTION_DATE   = CD.TRANSACTION_DATE
   AND C.TERMINAL_NUMBER    = CD.TERMINAL_NUMBER
   AND C.TRANSACTION_NUMBER = CD.TRANSACTION_NUMBER;
