/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Mary F. Kirkpatrick

CHECK_SERIAL_NUMBER 0874312473 paid on 4/3/2018 for $125.00

Created: 05/08/2018 nxk927
------------------------------------------*/

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0874312473';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '03-APR-2017',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = '125'
 WHERE CHECK_SERIAL_NUMBER = '0874312473';

COMMIT;