-- sxt410 09/16/2015 Script to create STORE_DRAFT_INFO_VW view.
CREATE OR REPLACE VIEW STORE_DRAFTS_INFO_VW
AS 
SELECT
/*******************************************************************************
This view holds Match Store Draft Information and any relevant data.

Created  : 09/15/2015 SXT410 CCN Project Team...
Modified : 
*******************************************************************************/
       SD.*
      ,SDD.GL_PRIME_ACCOUNT_NUMBER
      ,SDD.GL_SUB_ACCOUNT_NUMBER
      ,SDD.ITEM_EXT_AMOUNT
      ,SDD.ITEM_PRICE
      ,SDD.ITEM_QUANTITY
      ,SDD.LBR_TERMINAL_NUMBER
      ,SDD.LBR_TRANSACTION_DATE
      ,SDD.LBR_TRANSACTION_NUMBER
      ,SDD.STORE_DRAFTS_DETAIL_ID
FROM  STORE_DRAFTS SD,
      STORE_DRAFTS_DETAIL SDD
WHERE SD.COST_CENTER_CODE    = SDD.COST_CENTER_CODE
  AND SD.CHECK_SERIAL_NUMBER = SDD.CHECK_SERIAL_NUMBER
  AND SD.TRANSACTION_DATE    = SDD.TRANSACTION_DATE;