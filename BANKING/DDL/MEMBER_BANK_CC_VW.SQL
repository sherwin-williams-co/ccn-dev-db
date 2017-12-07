SELECT 
/*******************************************************************************
This view will provide the MEMBER_BANK_CC information.

Created  : 11/16/2017 bxa919 CCN Project
Modified :
*******************************************************************************/    
	  LEAD_BANK_ACCOUNT_NBR  
    ,LEAD_STORE_NBR         
    ,MEMBER_STORE_NBR       
    ,EFFECTIVE_DATE         
    ,EXPIRATION_DATE        
    ,MEMBER_BANK_ACCOUNT_NBR
    ,BANK_BRANCH_NBR        
    ,UPDATE_DATE            
    ,LAST_UPD_USER_ID 
  FROM MEMBER_BANK_CC