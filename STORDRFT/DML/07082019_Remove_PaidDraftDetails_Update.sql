/*----------------------------------------------------------------------------
Below script will remove paid details for the drafts 0874312515 and 0893611509

Created: 07/09/2019 akj899 CCNSD-10
------------------------------------------------------------------------------*/

 SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER IN ('0874312515','0893611509');
 
 UPDATE STORE_DRAFTS 
    SET PAID_DATE = NULL, 
        PAY_INDICATOR = 'N',
        BANK_PAID_AMOUNT = NULL
  WHERE CHECK_SERIAL_NUMBER IN ('0874312515','0893611509');
 
 COMMIT;

