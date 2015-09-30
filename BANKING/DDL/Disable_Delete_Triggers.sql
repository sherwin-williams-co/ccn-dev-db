/*******************************************************************************
This script will disable all the delete triggers
Not dropping yet, as we are not sure when we need these back

SELECT 'ALTER TRIGGER '|| OBJECT_NAME ||' DISABLE;'
  FROM USER_OBJECTS
 WHERE OBJECT_TYPE = 'TRIGGER'
   AND OBJECT_NAME LIKE '%DEL';

Created : 09/30/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
ALTER TRIGGER TR_BANK_ACCOUNT_DEL DISABLE;                                                                                                              
ALTER TRIGGER TR_BANK_ACCOUNT_FTR_DEL DISABLE;                                                                                                          
ALTER TRIGGER TR_BANK_DEP_BAG_TICK_DEL DISABLE;                                                                                                         
ALTER TRIGGER TR_BANK_DEP_BAG_TICK_FTR_DEL DISABLE;                                                                                                     
ALTER TRIGGER TR_BANK_DEP_TICKORD_DEL DISABLE;                                                                                                          
ALTER TRIGGER TR_BANK_DEP_TICKORD_FTR_DEL DISABLE;                                                                                                      
ALTER TRIGGER TR_BANK_DEP_TICK_DEL DISABLE;                                                                                                             
ALTER TRIGGER TR_BANK_DEP_TICK_FTR_DEL DISABLE;                                                                                                         
ALTER TRIGGER TR_BANK_MICR_FORMAT_DEL DISABLE;                                                                                                          
ALTER TRIGGER TR_BANK_MICR_FORMAT_FTR_DEL DISABLE;                                                                                                      
ALTER TRIGGER TR_LEAD_BANK_CC_DEL DISABLE;                                                                                                              
ALTER TRIGGER TR_LEAD_BANK_CC_FTR_DEL DISABLE;                                                                                                          
ALTER TRIGGER TR_MEMBER_BANK_CC_DEL DISABLE;                                                                                                            
ALTER TRIGGER TR_MEMBER_BANK_CC_FTR_DEL DISABLE;                                                                                                        
ALTER TRIGGER TR_STORE_MICR_FMT_DTLS_FTR_DEL DISABLE;                                                                                                   
ALTER TRIGGER TR_STORE_MICR_FORMAT_DTLS_DEL DISABLE;
