/*
Below script will update the date back to its original value as the batch is complete
*/
SELECT *
  FROM STORE_DRAFTS
 WHERE CHECK_SERIAL_NUMBER  IN ('0746571447', '0820084036', '0523965267', '0122415250');
--4 Row(s) Selected

UPDATE STORE_DRAFTS
   SET CHANGE_DATE = '12-MAY-2015'
 WHERE CHECK_SERIAL_NUMBER  IN ('0746571447', '0820084036', '0523965267', '0122415250');
--4 Row(s) Updated

COMMIT;

