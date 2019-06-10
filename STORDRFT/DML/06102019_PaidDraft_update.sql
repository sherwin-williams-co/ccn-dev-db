/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Marissa Papas
--MARK AS PAID
Created: 06/10/2019 akj899 ASP-1276
------------------------------------------*/

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0738683499';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '16-MAY-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0738683499';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0861410355';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '20-MAY-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0861410355';
   
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0852410059';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '23-MAY-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0852410059';
 
  SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0871319398';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '07-MAY-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0871319398';
 
 SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0861410355';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '24-MAY-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0861410355';
 COMMIT;
 