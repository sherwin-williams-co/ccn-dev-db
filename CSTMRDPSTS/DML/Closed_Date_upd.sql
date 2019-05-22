/*********************************************************************************
   This script is for updating the closed date for the two Accounts 
   982824047 and 985288919 
   
   created : 05/14/2018  SXS484/SXH487 CCN Project
*********************************************************************************/
SELECT * 
  FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL
 WHERE CUSTOMER_ACCOUNT_NUMBER IN ('982824047','985288919') 
 ORDER BY CUSTOMER_ACCOUNT_NUMBER, TRAN_TIMESTAMP;
 
UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL
   SET CLOSED_DATE = '17-APR-2019'
 WHERE CUSTOMER_ACCOUNT_NUMBER IN ('982824047','985288919') 
   AND CLOSED_DATE IS NULL;

COMMIT;
/