/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Marissa Papas
--MARK AS PAID
Store                 Draft         Amount                 Paid Date
728078                1013-0        $80.81                 2/15/2019
707068                1623-8        $175.00                2/15/2019
705290                1305-4        $400.00                2/21/2019--unattached
707469                1026-4        $450.00                2/28/2019
701544                1101-1        $527.40                2/26/2019--unattached
703226                1161-7        $964.76                2/11/2019

Created: 03/18/2019 sxg151
------------------------------------------*/

-- Mark as paid   
   
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0807810130';

UPDATE STORE_DRAFTS
   SET PAID_DATE = '15-FEB-2019',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0807810130'; 
   
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0706816238';

UPDATE STORE_DRAFTS
   SET PAID_DATE = '15-FEB-2019',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0706816238';   

-- update in UNATTACHED_MNL_DRFT_DTL table
SELECT * FROM UNATTACHED_MNL_DRFT_DTL WHERE CHECK_SERIAL_NUMBER = '0529013054';

UPDATE UNATTACHED_MNL_DRFT_DTL    
  SET PAID_DATE = '21-FEB-2019',
      NET_AMOUNT = 400.00,
      PAY_INDICATOR = 'Y',
      BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
      GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT)
WHERE CHECK_SERIAL_NUMBER = '0529013054';

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0746910264';

UPDATE STORE_DRAFTS
   SET PAID_DATE = '28-FEB-2019',
       PAY_INDICATOR = 'Y',
       OPEN_INDICATOR = 'Y',
       VOID_INDICATOR = 'N',
       VOID_DATE      = NULL,
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0746910264';
   
-- update in UNATTACHED_MNL_DRFT_DTL table
SELECT * FROM UNATTACHED_MNL_DRFT_DTL WHERE CHECK_SERIAL_NUMBER = '0154411011';

UPDATE UNATTACHED_MNL_DRFT_DTL
  SET PAID_DATE = '26-FEB-2019',
      NET_AMOUNT = 527.40,
      PAY_INDICATOR = 'Y',
      BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
      GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT)
WHERE CHECK_SERIAL_NUMBER = '0154411011';

 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0322611617';
UPDATE STORE_DRAFTS
   SET PAID_DATE = '11-FEB-2019',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0322611617';

COMMIT;