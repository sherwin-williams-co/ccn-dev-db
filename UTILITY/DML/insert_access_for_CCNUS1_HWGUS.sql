/*
     Created: 05/31/2017 axt754 CCN Project Team..
     This script do the inserts to security matrix for role
     codes 'CCNUS1','HWGUS' for users 'jam01s','jap203',
     'ajl964','cxh987','jls657'
*/
-- check the role codes assigned for given users
SELECT *
  FROM SECURITY_MATRIX
 WHERE USER_ID IN ('jam01s', 'jap203', 'ajl964', 'cxh987', 'jls657' )
 ORDER BY 1, 3;
-- Begin inserts for the given role codes
BEGIN
   FOR rec IN (SELECT 'jam01s' AS user_id FROM DUAL UNION
               SELECT 'jap203' AS user_id FROM DUAL UNION
               SELECT 'ajl964' AS user_id FROM DUAL UNION
               SELECT 'cxh987' AS user_id FROM DUAL UNION
               SELECT 'jls657' AS user_id FROM DUAL) LOOP
               
       INSERT INTO SECURITY_MATRIX
            VALUES (rec.user_id,rec.user_id,'CCNUS1');
            
       INSERT INTO SECURITY_MATRIX
            VALUES (rec.user_id,rec.user_id,'HWGUS');
       
   END LOOP;
   -- Commit the transaction
   COMMIT;
END;
/
-- Check the users and the role codes to confirm that the inserts are valid
SELECT *
  FROM SECURITY_MATRIX
 WHERE USER_ID IN ('jam01s', 'jap203', 'ajl964', 'cxh987', 'jls657' )
 ORDER BY 1, 3;