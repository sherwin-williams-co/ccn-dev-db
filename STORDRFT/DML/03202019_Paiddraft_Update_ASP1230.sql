/*---------------------------------------
Below script will remove Paids details and add stop pay details for the draft requested as per email sent by Marissa Papas

Please remove the paid date on this draft and add a Stop Pay Date of 3/20/2019
draft# 0366521953

Created: 03/20/2019 sxg151
------------------------------------------*/

    
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0366521953';

UPDATE STORE_DRAFTS
   SET PAID_DATE        = NULL,
       STOP_PAY_DATE    = '20-MAR-2019',
       BANK_PAID_AMOUNT = NULL,
       STOP_INDICATOR   = 'Y',
       OPEN_INDICATOR   = 'N',
       STOP_PAY_MARKED_BY_CCN_IND = 'Y'
 WHERE CHECK_SERIAL_NUMBER = '0366521953';
 
 COMMIT;