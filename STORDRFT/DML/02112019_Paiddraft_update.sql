/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Lee Niedenthal
--MARK AS PAID
Store	Draft	Paid Date
0873412431 : Paid Amount = 19,793.18 and Paid Date = Jan 21, 2019 

Created: 02/11/2019 sxg151
       : ASP-1213
------------------------------------------*/

   
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0873412431';

UPDATE STORE_DRAFTS
   SET PAID_DATE = '21-JAN-2019',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = 19793.18
 WHERE CHECK_SERIAL_NUMBER = '0873412431'; 

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0873412431';

COMMIT;