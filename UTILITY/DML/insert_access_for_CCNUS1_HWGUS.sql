/*
     Created: 05/31/2017 axt754 CCN Project Team..
     This script do the inserts to security matrix for role
     codes 'CCNUS1','HWGUS' for users 'jam01s','jap203',
     'ajl964','cxh987','jls657'
*/
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