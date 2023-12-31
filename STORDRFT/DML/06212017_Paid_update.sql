SET DEFINE OFF;
/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Christopher T. Greve

Created: 06/21/2017 nxk927
------------------------------------------*/

   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '701396' AND CHECK_SERIAL_NUMBER = '0139651350';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '13-APR-2017',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT) 
 WHERE COST_CENTER_CODE = '701396' 
   AND CHECK_SERIAL_NUMBER = '0139651350';

COMMIT;
