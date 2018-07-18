
Below script is to update the Net amount and bank paid amount of storedraft #0745574194.

Created : pxa852 7/18/2018 CCN Project Team....

UPDATE STORE_DRAFTS
   SET AMOUNT_CHANGE_DATE = '18-JUL-2018',
       NET_AMOUNT = 13460.25,
       BANK_PAID_AMOUNT = 13460.25,
       CHANGE_DATE = '18-JUL-2018'
 WHERE CHECK_SERIAL_NUMBER = '0745574194';

COMMIT;
