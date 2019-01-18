/*********************************************************************************
   This script is for updating the transaction timestamp to SYSTIMESTAMP after creating manual entries
   
   created : 01/18/2019  pxa852 CCN Project
*********************************************************************************/
SELECT COUNT(*) FROM customer_deposit_details WHERE NOTES = 'Offset of original transaction number' AND TRANSACTION_TYPE='MANUAL';

UPDATE customer_deposit_details
  SET TRAN_TIMESTAMP = SYSTIMESTAMP
 WHERE NOTES = 'Offset of original transaction number'
   AND TRANSACTION_TYPE='MANUAL';

SELECT COUNT(*) FROM customer_deposit_details WHERE NOTES = 'Offset of original transaction number' AND TRANSACTION_TYPE='MANUAL';