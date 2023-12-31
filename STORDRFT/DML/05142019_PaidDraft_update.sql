/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Marissa Papas
--MARK AS PAID

Created: 05/13/2019 sxg151 ASP-1262
------------------------------------------*/

-- reverse Stop Payment and Mark as paid.

/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Marissa Papas
--MARK AS PAID

Created: 05/13/2019 sxg151 ASP-1262
------------------------------------------*/

-- reverse Stop Payment and Mark as paid.


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0189173495';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '30-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0189173495';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0774513543';

UPDATE STORE_DRAFTS 
   SET PAID_DATE = '18-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0774513543';
   
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0273912139';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '02-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0273912139';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0263771511';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '03-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0263771511';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0738546118';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '23-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0738546118';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0121466775';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '02-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0121466775';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0225112689';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '30-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0225112689';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0897838991';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '30-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0897838991';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0897838983';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '30-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0897838983';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0775126626';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '23-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0775126626';
 
 SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0720715184';
 UPDATE STORE_DRAFTS 
   SET PAID_DATE = '01-APR-2019', 
       PAY_INDICATOR = 'Y', 
       STOP_INDICATOR = 'N',
       OPEN_INDICATOR = 'Y',
       STOP_PAY_MARKED_BY_CCN_IND = NULL,
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT),
       STOP_PAY_DATE = NULL
 WHERE CHECK_SERIAL_NUMBER = '0720715184';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0223627670';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '23-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0223627670';
 
 -- update in UNATTACHED_MNL_DRFT_DTL table
 
SELECT * FROM UNATTACHED_MNL_DRFT_DTL WHERE CHECK_SERIAL_NUMBER = '0122113624';

UPDATE UNATTACHED_MNL_DRFT_DTL    
  SET PAID_DATE = '18-APR-2019',
      NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT),
      PAY_INDICATOR = 'Y',
      BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
      GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT)
WHERE CHECK_SERIAL_NUMBER = '0122113624';

SELECT * FROM UNATTACHED_MNL_DRFT_DTL WHERE CHECK_SERIAL_NUMBER = '0393428008';

UPDATE UNATTACHED_MNL_DRFT_DTL    
  SET PAID_DATE = '23-APR-2019',
      NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT),
      PAY_INDICATOR = 'Y',
      BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
      GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT)
WHERE CHECK_SERIAL_NUMBER = '0393428008';

SELECT * FROM UNATTACHED_MNL_DRFT_DTL WHERE CHECK_SERIAL_NUMBER = '0520914649';

UPDATE UNATTACHED_MNL_DRFT_DTL    
  SET PAID_DATE = '01-APR-2019',
      NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT),
      PAY_INDICATOR = 'Y',
      BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
      GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT)
WHERE CHECK_SERIAL_NUMBER = '0520914649';

SELECT * FROM UNATTACHED_MNL_DRFT_DTL WHERE CHECK_SERIAL_NUMBER = '0528947609';

UPDATE UNATTACHED_MNL_DRFT_DTL    
  SET PAID_DATE = '18-APR-2019',
      NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT),
      PAY_INDICATOR = 'Y',
      BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
      GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT)
WHERE CHECK_SERIAL_NUMBER = '0528947609';
 
SELECT * FROM UNATTACHED_MNL_DRFT_DTL WHERE CHECK_SERIAL_NUMBER = '0758870224';

UPDATE UNATTACHED_MNL_DRFT_DTL    
  SET PAID_DATE = '18-APR-2019',
      NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT),
      PAY_INDICATOR = 'Y',
      BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
      GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT)
WHERE CHECK_SERIAL_NUMBER = '0758870224'; 

--
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0223266362';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '30-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0223266362';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0107517179';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '09-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0107517179';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0223422361';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '18-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0223422361';
 
 --Remove paid details from 0874312507
 
 SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0874312507';
 UPDATE STORE_DRAFTS 
   SET PAID_DATE = NULL, 
       PAY_INDICATOR = 'N',
       BANK_PAID_AMOUNT = NULL
 WHERE CHECK_SERIAL_NUMBER = '0874312507';
 
 COMMIT;
 
