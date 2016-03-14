/****************************************************************************************************************************************
CREATED: 03/14/2016 axk326  
         This DML script updates the User amg626 to have the same role codes that User ctg355 has been assigned with in CCN production.
****************************************************************************************************************************************/

UPDATE SECURITY_MATRIX
   SET ROLE_CODE = 'SDU'
 WHERE USER_ID = 'amg626'
   AND ROLE_CODE = 'SDU1';

COMMIT;

SELECT * FROM SECURITY_MATRIX WHERE USER_ID IN ('amg626', 'ctg355');