/*
     dml_security_matrix_code_LXH925.sql
     Created : 04/30/2019 CCN Project Team sxs484....
     This Script assigns role code CCNUS1 for lxh925
*/


-- Check the roles for 'lxh925'
SELECT * FROM SECURITY_MATRIX WHERE UPPER(USER_ID) = 'LXH925';

-- assign newly created role code to 'lxh925'
INSERT INTO SECURITY_MATRIX VALUES ('lxh925','lxh925','CCNUS1');

-- Check the roles for 'lxh925'
SELECT * FROM SECURITY_MATRIX WHERE UPPER(USER_ID) = 'LXH925';

-- Commit The Transaction
COMMIT;