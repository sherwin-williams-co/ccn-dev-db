/********************************************************************************
Below script will delete the ROLE CCNUS3 as it conflicts with their other role codes

Created : 04/07/2016 sxh487 CCN Project Team....
Modified:
********************************************************************************/
--DELETING from SECURITY_MATRIX
DELETE FROM SECURITY_MATRIX 
 WHERE user_id IN ('pmm4br', 'jep01r', 'cmaarr')
   AND ROLE_CODE ='CCNUS3';

COMMIT;