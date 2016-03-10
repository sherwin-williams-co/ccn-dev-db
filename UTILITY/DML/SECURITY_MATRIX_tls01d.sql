--This sql Script Adds the User tls01d to give the access for CCNUS1
SET SCAN OFF;
REM INSERTING into security_matrix
SET DEFINE OFF;

insert into ccn_utility.security_matrix(user_id, password, role_code) values('tls01d', 'tls01d', 'CCNUS1');

COMMIT;