/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Marissa Papas

Store	Draft	Paid Date
708200	1914-9	10/28/2018  - Mark AS Paid.
702270	3603-5	10/29/2018  - Mark AS Paid.
707385	4186-1	10/28/2018  - Mark AS Paid.
702822	1642-3	10/28/2018  - Mark AS Paid.
705272	5272-0	10/27/2018  - Mark AS Paid.
701222	2139-3	11/1/2018   - Mark AS Paid.
702816	1002-2	10/29/2018  - Mark AS Paid.
702816	1003-0	11/1/2018   - Mark AS Paid.
708577	1069-3	10/28/2018  - Mark AS Paid.

Created: 11/15/2018 kxm302
------------------------------------------*/
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='820019149';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '28-OCT-18',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='820019149';
--1 Row(s) Updated


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='227036035';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '29-OCT-18',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='227036035';
--1 Row(s) Updated


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='738541861';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '28-OCT-18',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='738541861';
--1 Row(s) Updated


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='282216423';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '28-OCT-18',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='282216423';
--1 Row(s) Updated


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='527252720';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '27-OCT-18',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='527252720';
--1 Row(s) Updated


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='122221393';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '01-NOV-18',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='122221393';
--1 Row(s) Updated


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='281610022';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '29-OCT-18',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='281610022';
--1 Row(s) Updated


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='281610030';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '01-NOV-18',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='281610030';
--1 Row(s) Updated


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='857710693';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '28-OCT-18',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT   = NVL(NET_AMOUNT,ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER ='857710693';
--1 Row(s) Updated

COMMIT;