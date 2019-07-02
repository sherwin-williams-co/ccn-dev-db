/*******************************************************************************
CCNSD-4: Script to update roles for users 'daf328','otp173' from SDUS to SDU
Created : 07/01/2019 sxc403
*******************************************************************************/

SELECT * 
  FROM security_matrix
 WHERE user_id IN ('daf328','otp173')
   AND role_code IN ('SDUS','SDU')
ORDER BY 1;

UPDATE security_matrix
  set role_code = 'SDU'
WHERE user_id IN ('daf328','otp173')
   AND role_code IN ('SDUS');

COMMIT;
   
SELECT * 
  FROM security_matrix
 WHERE user_id IN ('daf328','otp173')
   AND role_code IN ('SDUS','SDU')
ORDER BY 1;
