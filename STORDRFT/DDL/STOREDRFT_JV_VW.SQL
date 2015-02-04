CREATE OR REPLACE VIEW STOREDRFT_JV_VW
AS 
SELECT
/*******************************************************************************
This view holds all the required monthly Paid_JV data for the cost center.

Created  : 07/30/2014 SXT410 CCN Project Team...
Modified : 
*******************************************************************************/
       COST_CENTER_CODE,
       NET_AMOUNT,
       UPDATE_DATE,
       JV_TYPE
  FROM STOREDRFT_JV;