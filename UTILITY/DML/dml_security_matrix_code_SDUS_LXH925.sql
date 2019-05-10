/*
     dml_security_matrix_code_SDUS_LXH925.sql
     Created : 05/10/2019 CCN Project Team....
     This Script assigns role code SDUS for lxh925
*/



-- Check the roles for 'lxh925'
SELECT * FROM SECURITY_MATRIX WHERE UPPER(USER_ID) = 'LXH925';

-- assign newly created role code to 'lxh925'
INSERT INTO SECURITY_MATRIX VALUES ('lxh925','lxh925','SDUS');

-- Check the roles for 'lxh925'
SELECT * FROM SECURITY_MATRIX WHERE UPPER(USER_ID) = 'LXH925';

-- Commit The Transaction
COMMIT;