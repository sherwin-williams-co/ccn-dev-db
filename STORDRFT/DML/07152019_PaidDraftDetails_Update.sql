/*---------------------------------------------------------------------------------------
Below script will remove paid details for the drafts 0771524204, 0438121501,0110629748,
0174311266,0893611509,0874312515,0264711292 and 0565723590

Created: 07/15/2019 akj899 CCNSD-20
-----------------------------------------------------------------------------------------*/

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0771524204';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '20-MAY-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0771524204';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0438121501';

UPDATE STORE_DRAFTS 
   SET STOP_INDICATOR = 'N',
       STOP_PAY_DATE = NULL,
       OPEN_INDICATOR = 'Y',
       PAY_INDICATOR = 'Y',
       PAID_DATE = '30-MAR-2019',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0438121501';


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0110629748';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '30-APR-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0110629748';
 
 SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0174311266';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '27-MAY-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0174311266';
 
 SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0893611509';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '07-JUN-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0893611509';
 
  SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0874312515';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '07-JUN-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0874312515';

  SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0264711292';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '27-JUN-2019', 
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = 264.43, 
       GROSS_AMOUNT = 264.43, 
       NET_AMOUNT = 264.43,
       AMOUNT_CHANGE_DATE = TRUNC(SYSDATE)
 WHERE CHECK_SERIAL_NUMBER = '0264711292';

 SELECT * FROM UNATTACHED_MNL_DRFT_DTL WHERE CHECK_SERIAL_NUMBER ='0565723590';
UPDATE UNATTACHED_MNL_DRFT_DTL    
  SET PAID_DATE = '04-JUN-2019', 
      NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT),
      PAY_INDICATOR = 'Y',
      BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
      GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT)
WHERE CHECK_SERIAL_NUMBER = '0565723590';

 COMMIT;
 