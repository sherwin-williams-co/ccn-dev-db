/*
Created by nxk927 on 04/02/2018
This script will
1) Update Primary/Standard cost identifier field values from null to "01" for all cost centers of category "S" with polling status as "P"/"Q" for USA cost centers
2) Update Primary/Standard cost identifier field values from null to "08" for all cost centers of category "S" with polling status as "P"/"Q" for Canadian cost centers (Statement Type CN or AC)
3) We are updating details for closed cost centers as well 
*/



SELECT COST_CENTER_CODE, PRIM_COST_IDENTIFIER, STD_COST_IDENTIFIER
  FROM COST_CENTER
 WHERE COUNTRY_CODE = 'USA'
   AND (PRIM_COST_IDENTIFIER IS NULL OR  STD_COST_IDENTIFIER IS NULL)
   AND CATEGORY = 'S'
   AND COST_CENTER_CODE IN (SELECT COST_CENTER_CODE 
                              FROM POLLING P
                             WHERE P.POLLING_STATUS_CODE IN ('P', 'Q')
                               AND P.EXPIRATION_DATE IS NULL
                               AND P.CURRENT_FLAG = 'Y');

UPDATE COST_CENTER
   SET PRIM_COST_IDENTIFIER = '01',
       STD_COST_IDENTIFIER  = '01'
 WHERE CATEGORY = 'S'                           
   AND (PRIM_COST_IDENTIFIER IS NULL
         OR STD_COST_IDENTIFIER IS NULL)
   AND COUNTRY_CODE = 'USA'
   AND COST_CENTER_CODE IN (SELECT COST_CENTER_CODE 
                              FROM POLLING P
                             WHERE P.POLLING_STATUS_CODE IN ('P', 'Q')
                               AND P.EXPIRATION_DATE IS NULL
                               AND P.CURRENT_FLAG = 'Y');

SELECT COST_CENTER_CODE, PRIM_COST_IDENTIFIER, STD_COST_IDENTIFIER 
  FROM COST_CENTER
 WHERE CATEGORY = 'S'                           
   AND (PRIM_COST_IDENTIFIER IS NULL
         OR  STD_COST_IDENTIFIER IS NULL)
   AND COUNTRY_CODE = 'CAN'
   AND STATEMENT_TYPE IN ('CN', 'AC')
   AND COST_CENTER_CODE IN (SELECT COST_CENTER_CODE 
                              FROM POLLING P
                             WHERE P.POLLING_STATUS_CODE IN ('P', 'Q')
                               AND P.EXPIRATION_DATE IS NULL
                               AND P.CURRENT_FLAG = 'Y');

UPDATE COST_CENTER
   SET PRIM_COST_IDENTIFIER = '08',
       STD_COST_IDENTIFIER  = '08'
 WHERE CATEGORY = 'S'                           
   AND (PRIM_COST_IDENTIFIER IS NULL
         OR  STD_COST_IDENTIFIER IS NULL)
   AND COUNTRY_CODE = 'CAN'
   AND STATEMENT_TYPE IN ('CN', 'AC')
   AND COST_CENTER_CODE IN (SELECT COST_CENTER_CODE 
                              FROM POLLING P
                             WHERE P.POLLING_STATUS_CODE IN ('P', 'Q')
                               AND P.EXPIRATION_DATE IS NULL
                               AND P.CURRENT_FLAG = 'Y');


COMMIT;
