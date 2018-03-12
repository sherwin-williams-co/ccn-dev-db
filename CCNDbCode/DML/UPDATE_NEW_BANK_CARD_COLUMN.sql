/**********************************************************************************
 This Update used to update field  MERCH_ID_CAN_MC with MERCHANT_ID value
which starts with "8" by replacing it with "9".

created :02/09/2018 bxa919 CCN Project..
**********************************************************************************/
UPDATE BANK_CARD 
   SET MERCH_ID_CAN_MC = '9' || SUBSTR(MERCHANT_ID,2) 
 WHERE SUBSTR(MERCHANT_ID,1,1) = '8' AND EXPIRATION_DATE IS NULL
   AND COST_CENTER_CODE 
   IN  
    (SELECT COST_CENTER_CODE 
       FROM COST_CENTER A 
      WHERE COST_CENTER_CODE = A.COST_CENTER_CODE 
        AND A.COUNTRY_CODE = 'CAN'
    ) ;

COMMIT;