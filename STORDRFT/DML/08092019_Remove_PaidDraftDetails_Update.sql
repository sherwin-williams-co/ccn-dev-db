/*----------------------------------------------------------------------------
Below script will remove paid details for the drafts 0893611517 

Created: 08/09/2019 akj899 CCNSD-28
------------------------------------------------------------------------------*/

 SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER IN ('0893611517');
 
 UPDATE STORE_DRAFTS 
    SET PAID_DATE = NULL, 
        PAY_INDICATOR = 'N',
        BANK_PAID_AMOUNT = NULL
  WHERE CHECK_SERIAL_NUMBER IN ('0893611517');
 
 COMMIT;

