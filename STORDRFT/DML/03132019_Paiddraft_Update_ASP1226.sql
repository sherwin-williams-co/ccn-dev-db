/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Lee Niedenthal
--MARK AS PAID
Store : 768734
Paid Amount = 4,012.96
Paid Date = Feb 7, 2019

Created: 03/13/2019 sxg151
------------------------------------------*/

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0873412449';

UPDATE STORE_DRAFTS
   SET PAID_DATE = '07-FEB-2019',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = 4012.96
 WHERE CHECK_SERIAL_NUMBER = '0873412449';
 
 SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0873412449';
 
 COMMIT;