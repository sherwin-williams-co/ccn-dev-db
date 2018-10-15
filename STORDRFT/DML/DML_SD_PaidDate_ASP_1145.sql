/*
CREATED : 10/15/2018 kxm302 Script to update the PAID_DATE for the check numbers 0875311631 and 0357710227
*/

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0875311631';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '5-SEP-2018', 
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0875311631';
 --1 Row(s) Updated

 SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0357710227';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y',
       PAID_DATE = '14-SEP-2018',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0357710227';

COMMIT;