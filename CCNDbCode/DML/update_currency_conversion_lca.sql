/*
This script updates CURRENCY_CONVERSION to have TAXID_NUMBER from "1489249" to "1628219" for "LCA" country code

Created : 01/04/2018 axt754 CCN Project Team....
Changed :
*/

-- UPDATE 
UPDATE CURRENCY_CONVERSION
   SET TAXID_NUMBER = '1628219'
  WHERE COUNTRY_CODE = 'LCA';
  
-- RUN SELECT to check if the value updated correctly
SELECT * FROM CURRENCY_CONVERSION WHERE COUNTRY_CODE = 'LCA';

-- COMMIT THE TRANSACTION
COMMIT;