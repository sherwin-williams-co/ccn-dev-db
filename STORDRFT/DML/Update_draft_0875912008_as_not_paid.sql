--Below scripts will manually update the Paid date,and bank Paid amount to null and the paid indicator to 'N'.
--nxk927 03/01/2016 
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0875912008';          
UPDATE STORE_DRAFTS
   SET PAID_DATE = NULL,
       BANK_PAID_AMOUNT = NULL,
       PAY_INDICATOR = 'N'
  WHERE CHECK_SERIAL_NUMBER = '0875912008';

COMMIT;  