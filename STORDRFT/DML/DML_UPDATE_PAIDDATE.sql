/*
Below scripts will manually update the paid details with the details provided by Christopher T. Greve
Created : 03/07/2016 dxv848  CCN Project team.... 

CC	Draft	Date Paid
701151	8520-9 	1/25/2016
701151	8521-7	1/11/2016
702112	6130-0 	1/11/2016
702112	6131-8	1/11/2016
701121	3576-9 	1/7/2016
701121	3577-7	1/7/2016
705283	7625-4	1/6/2016
702232	3941-9	1/8/2016
707428	7790-5	1/11/2016
701560	1012-6	1/5/2016
708155	1899-8	1/7/2016
708584	1011-1	1/7/2016
701249	2717-9	1/8/2016
702604	1103-8	1/11/2016
701273	1215-5	1/8/2016
705153	1503-4	1/8/2016
705890	1673-2	1/11/2016
703459	1026-9	1/4/2016
703459	1027-7	1/4/2016
702650	1161-9	1/12/2016
708969	1000-7	1/7/2016
703039	2061-5	1/11/2016
703075	1452-1	1/11/2016
701228	2156-4	1/11/2016

*/

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0112135769';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '07-JAN-2016', BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0112135769';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0112135777';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '07-JAN-2016', BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0112135777';
--1 Row(s) Updated  
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0115185209';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '25-JAN-16', BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0115185209';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0115185217';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '11-JAN-2016', BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0115185217';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0122821564';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '11-JAN-2016', BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0122821564';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0124927179';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '08-JAN-2016', BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0124927179';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0127312155';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '08-JAN-2016', BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0127312155';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0156010126';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '05-JAN-2016', BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0156010126';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0211261300';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '11-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0211261300';
--1 Row(s) Updated 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0211261318' ;
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '11-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0211261318';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0223239419';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '08-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0223239419';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0260411038';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '11-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0260411038';
--1 Row(s) Updated 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0265011619';
--1 Row(s) SELECTed
--This is draft is already void, so update void details and open indicator.
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '12-JAN-2016',VOID_DATE = NULL , VOID_INDICATOR = 'N', OPEN_INDICATOR = 'Y' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0265011619';
--1 Row(s) Updated 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0303920615' ;
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '11-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0303920615';
--1 Row(s) Updated 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0307514521';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '11-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0307514521';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0345910269';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '04-JAN-2016', BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0345910269';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0345910277';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '04-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0345910277';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0515315034';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '08-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0515315034';
--1 Row(s) Updated 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0528376254';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '06-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
  WHERE CHECK_SERIAL_NUMBER = '0528376254';
--1 Row(s) Updated 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0589016732';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '11-JAN-2016', BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0589016732';
--1 Row(s) Updated
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0742877905';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '11-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0742877905';
--1 Row(s) Updated 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0815518998';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '07-JAN-2016', BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0815518998';
--1 Row(s) Updated  
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0858410111';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '07-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0858410111';
--1 Row(s) Updated  
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER ='0896910007';
--1 Row(s) SELECTed
UPDATE STORE_DRAFTS
   SET PAY_INDICATOR = 'Y', PAID_DATE = '07-JAN-2016' , BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT,NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0896910007';
--1 Row(s) Updated  
COMMIT;