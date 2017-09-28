/*
Created : 09/28/2017 jxc517 CCN Project Team
Changed :

Mail from Adam:
Keith,

We recently had an amount discrepancy with Royal Bank on one of the drafts. They returned the check, and now we need to void it. CCN shows a paid date and amount, so when I try to void the draft, it gives me the error below.

We need the paid date and amount removed, and the draft voided.

Store is 8732, and the draft is 8732-1579-2 for $530.32
*/
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0873215792';
--1 Row(s) Selected

UPDATE STORE_DRAFTS
   SET PAID_DATE = NULL,
       BANK_PAID_AMOUNT = NULL,
       PAY_INDICATOR = 'N',
       VOID_DATE = '27-SEP-2017',
       VOID_INDICATOR = 'Y',
       OPEN_INDICATOR = 'N'
 WHERE CHECK_SERIAL_NUMBER = '0873215792';
--1 Row(s) Updated

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0873215792';
--1 Row(s) Selected

COMMIT;
