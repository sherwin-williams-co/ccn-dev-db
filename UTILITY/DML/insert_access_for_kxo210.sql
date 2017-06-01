/*
     Created: 06/01/2017 axt754 CCN Project Team..
     This script do the inserts to security matrix for role
     codes that are for user 'jep01r' to user 'kxo210'
*/
-- check the role codes assigned for given users
SELECT *
  FROM SECURITY_MATRIX
 WHERE USER_ID IN ('kxo210', 'jep01r')
 ORDER BY 1, 3;
-- Begin Inserts for the given role codes for user 'kxo210', which are same as 'jep01r'
BEGIN
   FOR rec IN ( SELECT ROLE_CODE
                  FROM SECURITY_MATRIX
                 WHERE USER_ID = 'jep01r' ) LOOP
               
       INSERT INTO SECURITY_MATRIX
            VALUES ('kxo210','kxo210',rec.ROLE_CODE);
            
   END LOOP;
   -- Commit the transaction
   COMMIT;
END;
/
-- Check the users and the role codes to confirm that the inserts are valid, and compare with given user 'jep01r'
SELECT *
  FROM SECURITY_MATRIX
 WHERE USER_ID IN ('kxo210', 'jep01r')
 ORDER BY 1, 3;

