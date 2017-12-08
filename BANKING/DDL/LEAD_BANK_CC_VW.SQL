CREATE OR REPLACE VIEW LEAD_BANK_CC_VW 
AS
  SELECT 
/*******************************************************************************
This view will provide the LEAD_BANK_CC information.

Created  : 11/16/2017 bxa919 CCN Project
Modified :
*******************************************************************************/    
	LEAD_BANK_ACCOUNT_NBR
    ,LEAD_STORE_NBR          
    ,EFFECTIVE_DATE       
    ,EXPIRATION_DATE      
    ,BANK_BRANCH_NBR      
    ,BANK_TYPE_CODE       
    ,UPDATE_DATE          
    ,LAST_UPD_USER_ID 
  FROM LEAD_BANK_CC;