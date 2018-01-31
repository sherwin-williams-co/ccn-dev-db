/*
     delete_ccn_users_20180130.sql
     Created : 01/30/2018 CCN Project Team....
     This Script deletes the following users from CCN
     'CCR88D','CTG355','GXN983','KBG893','LAS841','LTK464','NCJ812','TPF441','TXS130'
*/
-- Take back up of users
SELECT *
  FROM SECURITY_MATRIX 
 WHERE UPPER(USER_ID) IN ('CCR88D','CTG355','GXN983','KBG893','LAS841','LTK464','NCJ812','TPF441','TXS130')
 ORDER BY USER_ID;
 
-- delete the users
DELETE 
  FROM SECURITY_MATRIX 
 WHERE UPPER(USER_ID) IN ('CCR88D','CTG355','GXN983','KBG893','LAS841','LTK464','NCJ812','TPF441','TXS130');

-- Check if the users have been deleted
SELECT *
  FROM SECURITY_MATRIX 
 WHERE UPPER(USER_ID) IN ('CCR88D','CTG355','GXN983','KBG893','LAS841','LTK464','NCJ812','TPF441','TXS130')
 ORDER BY USER_ID;
 
-- Commit the transaction
COMMIT;