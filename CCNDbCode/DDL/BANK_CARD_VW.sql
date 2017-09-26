CREATE OR REPLACE VIEW BANK_CARD_VW 
  SELECT
/*******************************************************************************
This view will provide the BANK_CARD information.

Created  : 09/06/2017 axt754 CCN Project
Modified :
*******************************************************************************/
    COST_CENTER_CODE
    ,AMEX_SE_ID
    ,MERCHANT_ID
    ,PCI_MERCHANT_ID
    ,DISCOVER_ID
    ,PCI_DISCOVER_ID
    ,QUALITY_CODE
  FROM BANK_CARD
 WHERE EXPIRATION_DATE IS NULL;