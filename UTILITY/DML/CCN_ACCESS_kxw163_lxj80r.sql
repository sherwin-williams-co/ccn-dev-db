/*
This script inserts data into SECURITY_MATRIX, to give Read access
of CCN Application to 
Kevin Welsh:
kxw163
kevin.welsh@sherwin.com

La'Kesha Johnson:
lxj80r
Lakesha.johnson@sherwin.com 

Created : 11/16/2017 axt754 CCN Project Team....
Changed :
*/

-- INSERT CCNUS ROLE_CODE to the users into SECURITY_MATRIX
INSERT into SECURITY_MATRIX Values ('kxw163','kxw163','CCNUS');
INSERT into SECURITY_MATRIX Values ('lxj80r','lxj80r','CCNUS');

-- Check if the role_code is assigned
SELECT * FROM SECURITY_MATRIX WHERE USER_ID IN ('kxw163','lxj80r');

-- COMMIT the Transaction
COMMIT;