--Below script will manually mark the drafts as paid as per email sent by Christopher T. Greve
--sxh487 04/13/2016 
/*---------------------------------------
Store	Draft	Amount		Date
703325	1000-7	1400		2/5/2016
707428	7877-0	1316.8		2/10/2016
707345	1619-8	571.6		2/16/2016
701552	1014-9	400		2/16/2016
708292	1078-0	398		2/5/2016
707099	1708-2	215.42		2/4/2016
707264	3398-0	186.73		2/5/2016
701515	1015-3	40		2/16/2016
701117	1002-6	25		2/4/2016
702976	1048-7	8811.87		1/11/2016
708241	2207-1	2671.76		2/12/2016
705881	1005-6	75		1/27/2016
702976	1047-9	17623.74	1/5/2016
708200	9189-0	3142.36		12/23/2015
701680	1113-8	41.97		12/4/2015
701680	1112-0	26.56		12/4/2015
------------------------------------------*/

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0332510007'; 
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '05-FEB-2016',
       BANK_PAID_AMOUNT = 1400
 WHERE CHECK_SERIAL_NUMBER = '0332510007';

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0742878770';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '10-FEB-2016',
       BANK_PAID_AMOUNT = 1316.8
 WHERE CHECK_SERIAL_NUMBER = '0742878770';

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0734516198';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '16-FEB-2016',
       BANK_PAID_AMOUNT = 571.6
 WHERE CHECK_SERIAL_NUMBER = '0734516198';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0155210149';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '16-FEB-2016',
       BANK_PAID_AMOUNT = 400
 WHERE CHECK_SERIAL_NUMBER = '0155210149';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0829210780';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '05-FEB-2016',
       BANK_PAID_AMOUNT = 398
 WHERE CHECK_SERIAL_NUMBER = '0829210780';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0709917082';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '04-FEB-2016',
       BANK_PAID_AMOUNT = 215.42
 WHERE CHECK_SERIAL_NUMBER = '0709917082';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0726433980';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '05-FEB-2016',
       BANK_PAID_AMOUNT = 186.73
 WHERE CHECK_SERIAL_NUMBER = '0726433980';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0151510153';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '16-FEB-2016',
       BANK_PAID_AMOUNT = 40
 WHERE CHECK_SERIAL_NUMBER = '0151510153';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0111710026';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '04-FEB-2016',
       BANK_PAID_AMOUNT = 25
 WHERE CHECK_SERIAL_NUMBER = '0111710026';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0297610487';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '11-JAN-2016',
       BANK_PAID_AMOUNT = 8811.87
 WHERE CHECK_SERIAL_NUMBER = '0297610487';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0824122071';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '12-FEB-2016',
       BANK_PAID_AMOUNT = 2671.76
 WHERE CHECK_SERIAL_NUMBER = '0824122071';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0588110056';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '27-JAN-2016',
       BANK_PAID_AMOUNT = 75
 WHERE CHECK_SERIAL_NUMBER = '0588110056';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0297610479';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '05-JAN-2016',
       BANK_PAID_AMOUNT = 17623.74
 WHERE CHECK_SERIAL_NUMBER = '0297610479';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0820091890';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '23-DEC-2015',
       BANK_PAID_AMOUNT = 3142.36
 WHERE CHECK_SERIAL_NUMBER = '0820091890';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0168011138';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '04-DEC-2015',
       BANK_PAID_AMOUNT = 41.97
 WHERE CHECK_SERIAL_NUMBER = '0168011138';
 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0168011120';
UPDATE STORE_DRAFTS 
   SET PAY_INDICATOR = 'Y', 
       PAID_DATE = '04-DEC-2015',
       BANK_PAID_AMOUNT = 26.56
 WHERE CHECK_SERIAL_NUMBER = '0168011120';
 
COMMIT;
