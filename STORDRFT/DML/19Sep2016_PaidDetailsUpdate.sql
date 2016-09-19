/*
Below script will manually update the paid details with the details provided below
Created : 09/19/2016 sxh487  CCN Project team.... 

CC	Draft	Date Paid
768849  1001    03/31/2016

all the indicators are N besides Open indicator which is 'Y'
*/

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0884910019';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '31-MAR-2016', 
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0884910019';
--1 Row(s) Updated

COMMIT;