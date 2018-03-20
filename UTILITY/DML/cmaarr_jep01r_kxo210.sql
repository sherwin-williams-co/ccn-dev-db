/*
Created : nxk927 03/20/2018
          Giving polling window "VIEW" access to users cmaarr, jep01r, kxo210
*/

SELECT * FROM SECURITY_MATRIX WHERE USER_ID IN ('cmaarr','jep01r','kxo210');

INSERT INTO SECURITY_MATRIX VALUES ('cmaarr','cmaarr','CCNUS4');
INSERT INTO SECURITY_MATRIX VALUES ('jep01r','jep01r','CCNUS4');
INSERT INTO SECURITY_MATRIX VALUES ('kxo210','kxo210','CCNUS4');
COMMIT;

SELECT * FROM SECURITY_MATRIX WHERE USER_ID IN ('cmaarr','jep01r','kxo210');