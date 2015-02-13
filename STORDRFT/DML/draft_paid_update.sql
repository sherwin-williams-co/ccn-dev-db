select * from store_drafts where CHECK_SERIAL_NUMBER in ('0211251749','0240563577','0595311721','0737722173',
                                                         '0801820903','0811121557','0844418566','0215317926');
                                                         
Update store_drafts 
   set PAY_INDICATOR     = 'Y',
        PAID_DATE        = '07-JAN-2015',
        BANK_PAID_AMOUNT = '1644.44'
  where CHECK_SERIAL_NUMBER = '0211251749'
    and substr(cost_center_code,3) =  '2112';
    
Update store_drafts 
   set PAY_INDICATOR     = 'Y',
        PAID_DATE        = '02-JAN-2015',
        BANK_PAID_AMOUNT = '3010.00'
  where CHECK_SERIAL_NUMBER = '0240563577'
    and substr(cost_center_code,3) =  '2405';
    
Update store_drafts 
   set PAY_INDICATOR     = 'Y',
        PAID_DATE        = '29-JAN-2015',
        BANK_PAID_AMOUNT = '85.00'
  where CHECK_SERIAL_NUMBER = '0595311721'
    and substr(cost_center_code,3) =  '5953';
    
Update store_drafts 
   set PAY_INDICATOR     = 'Y',
        PAID_DATE        = '05-JAN-2015',
        BANK_PAID_AMOUNT = '548.79'
  where CHECK_SERIAL_NUMBER = '0737722173'
    and substr(cost_center_code,3) =  '7377';
    
Update store_drafts 
   set PAY_INDICATOR     = 'Y',
        PAID_DATE        = '08-JAN-2015',
        BANK_PAID_AMOUNT = '175.78'
  where CHECK_SERIAL_NUMBER = '0801820903'
    and substr(cost_center_code,3) =  '8018';
    
Update store_drafts 
   set PAY_INDICATOR     = 'Y',
        PAID_DATE        = '29-JAN-2015',
        BANK_PAID_AMOUNT = '6500.00'
  where CHECK_SERIAL_NUMBER = '0811121557'
    and substr(cost_center_code,3) =  '8111';
    
Update store_drafts 
   set PAY_INDICATOR     = 'Y',
        PAID_DATE        = '29-JAN-2015',
        BANK_PAID_AMOUNT = '450.00'
  where CHECK_SERIAL_NUMBER = '0844418566'
    and substr(cost_center_code,3) =  '8444';
    
Update store_drafts 
   set PAY_INDICATOR     = 'Y',
        PAID_DATE        = '03-JAN-2015',
        BANK_PAID_AMOUNT = '66403.20'
  where CHECK_SERIAL_NUMBER = '0215317926'
    and substr(cost_center_code,3) =  '2153';   

Commit;	

Select PAID_DATE,check_serial_number, substr(cost_center_code,3), BANK_PAID_AMOUNT from 
store_drafts where CHECK_SERIAL_NUMBER in ('0211251749','0240563577','0595311721','0737722173',
                                                         '0801820903','0811121557','0844418566','0215317926');
    