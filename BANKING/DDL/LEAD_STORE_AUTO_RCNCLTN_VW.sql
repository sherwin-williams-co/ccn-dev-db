CREATE OR REPLACE VIEW LEAD_STORE_AUTO_RCNCLTN_VW
AS
   SELECT 
   /************************************************************************
    The view will give all the records from LEAD_STORE_AUTO_RCNCLTN_DATA
    table which stores the data for the leads/independent stores that are having
    auto-reconciliation set to "Y".
    
    Created  : 01/23/2017 gxg192 CCN Project..
    Modified :
   *************************************************************************/
          LEAD_BANK_ACCOUNT_NBR,
          LEAD_STORE_NBR,
          EFFECTIVE_DATE,
          EXPIRATION_DATE,
          BANK_BRANCH_NBR,
          BANK_TYPE_CODE
     FROM LEAD_STORE_AUTO_RCNCLTN_DATA;