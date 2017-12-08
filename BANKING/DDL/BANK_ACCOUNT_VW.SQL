CREATE OR REPLACE VIEW BANK_ACCOUNT_VW AS
  SELECT 
/*******************************************************************************
This view will provide the BANK_ACCOUNT information.

Created  : 11/16/2017 bxa919 CCN Project
Modified :
*******************************************************************************/        
    BANK_ACCOUNT_NBR      
    ,EFFECTIVE_DATE          
    ,EXPIRATION_DATE       
    ,BANK_NAME             
    ,BOOK_KEEPER_NBR       
    ,BANK_AUTO_RECON_IND   
    ,RECON_START_DATE      
    ,RECON_BANK_ACCOUNT_NBR
    ,JV_BOOK_KEEPER_REF    
    ,JV_BANK_SHORT_NAME    
    ,IDI_BOOKKEEPER_REF    
    ,IDI_BANK_SHORT_NAME   
    ,ROUTING_NBR           
    ,UPDATE_DATE           
    ,LAST_UPD_USER_ID  
  FROM  BANK_ACCOUNT;