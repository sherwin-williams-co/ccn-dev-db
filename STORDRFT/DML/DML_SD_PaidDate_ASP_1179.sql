/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Marissa Papas

Store	Draft	Paid Date
707535	1909-7	11/30/2018  - Mark AS Paid.  
702845	6919-1	11/7/2018   - Mark AS Paid.  
703126	1460-5	11/5/2018  - Mark AS Paid.  
 
Created: 12/17/2018 kxm302
------------------------------------------*/

--change amount as per Mary


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0753619097';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '30-NOV-2018',
       PAY_INDICATOR = 'Y',
       NET_AMOUNT = 5534.2,
       BANK_PAID_AMOUNT = 5534.2,
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='0753619097';
--1 Row(s) Updated


--change amount as per Mary


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0284569191';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '07-NOV-2018',
       PAY_INDICATOR = 'Y',
       NET_AMOUNT = 3936,
       BANK_PAID_AMOUNT = 3936,
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='0284569191';
--1 Row(s) Updated


--change amount as per Mary


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0312614605';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '05-NOV-2018',
       PAY_INDICATOR = 'Y',
       NET_AMOUNT = 195,
       BANK_PAID_AMOUNT = 195,
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='0312614605';
--1 Row(s) Updated

COMMIT;

