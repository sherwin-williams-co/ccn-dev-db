/*********************************************************************************
   This script is for updating the deposit remaining balance and 
   originals in customer_deposit_transaction_dtl table.

   
   created : 05/22/2019  sxs484 CCN Project
*********************************************************************************/
   update customer_deposit_transaction_dtl
      set ORGNL_DEPOSIT_TRANSACTION_DATE ='01-MAR-19'
          ,ORGNL_DEPOSIT_TERMINAL_NBR =15015
          ,ORGNL_DEPOSIT_TRANSACTION_NBR =51475      
    where transaction_type ='REDEMPTION'
      and customer_account_number = '277026787'
      and CUST_DEP_TRANS_DETAIL_SEQ = 226390;

   update customer_deposit_transaction_dtl
      set DEPOSIT_REMAINING_BAL = 0
    where transaction_type ='DEPOSIT'
      and customer_account_number = '277026787'
      and CUST_DEP_TRANS_DETAIL_SEQ = 233877;
  
  
--295258420
   update customer_deposit_transaction_dtl
      set ORGNL_DEPOSIT_TRANSACTION_DATE ='22-FEB-19'
          ,ORGNL_DEPOSIT_TERMINAL_NBR =18570
          ,ORGNL_DEPOSIT_TRANSACTION_NBR =29589      
    where transaction_type ='REDEMPTION'
      and customer_account_number = '295258420'
      and CUST_DEP_TRANS_DETAIL_SEQ = 283649;

   update customer_deposit_transaction_dtl
      set DEPOSIT_REMAINING_BAL = 0
    where transaction_type ='DEPOSIT'
      and customer_account_number = '295258420'
      and CUST_DEP_TRANS_DETAIL_SEQ = 392742;  

--424371532
   update customer_deposit_transaction_dtl
      set ORGNL_DEPOSIT_TRANSACTION_DATE ='12-MAR-19' 
          ,ORGNL_DEPOSIT_TERMINAL_NBR =17769 
          ,ORGNL_DEPOSIT_TRANSACTION_NBR =6388      
    where transaction_type ='REDEMPTION'
      and customer_account_number = '424371532'
      and CUST_DEP_TRANS_DETAIL_SEQ = 810570;


   update customer_deposit_transaction_dtl
      set DEPOSIT_REMAINING_BAL = 0
    where transaction_type ='DEPOSIT'
      and customer_account_number = '424371532'
      and CUST_DEP_TRANS_DETAIL_SEQ = 239022;  

   
--531773042
   update customer_deposit_transaction_dtl
      set ORGNL_DEPOSIT_TRANSACTION_DATE ='29-MAR-19' 
          ,ORGNL_DEPOSIT_TERMINAL_NBR =11084 
          ,ORGNL_DEPOSIT_TRANSACTION_NBR =51723      
    where transaction_type ='REDEMPTION'
      and customer_account_number = '531773042'
      and CUST_DEP_TRANS_DETAIL_SEQ = 552198;

   update customer_deposit_transaction_dtl
      set DEPOSIT_REMAINING_BAL = 0
    where transaction_type ='DEPOSIT'
      and customer_account_number = '531773042'
      and CUST_DEP_TRANS_DETAIL_SEQ = 442237;  
   
   
--796650646
   update customer_deposit_transaction_dtl
      set ORGNL_DEPOSIT_TRANSACTION_DATE ='01-MAR-19' 
          ,ORGNL_DEPOSIT_TERMINAL_NBR =18106 
          ,ORGNL_DEPOSIT_TRANSACTION_NBR =96201      
    where transaction_type ='REDEMPTION'
      and customer_account_number = '796650646'
      and CUST_DEP_TRANS_DETAIL_SEQ = 227470;

   update customer_deposit_transaction_dtl
      set DEPOSIT_REMAINING_BAL = 0
    where transaction_type ='DEPOSIT'
      and customer_account_number = '796650646'
      and CUST_DEP_TRANS_DETAIL_SEQ = 284653;  
      
COMMIT;  
/    