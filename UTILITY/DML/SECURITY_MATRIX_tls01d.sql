--Created: 03/10/2016 mxr916
--This sql Script Adds the User tls01d to give the access for CCNUS
SET SCAN OFF;
REM INSERTING into security_matrix
SET DEFINE OFF;

insert into security_matrix(user_id, password, role_code) values('tls01d', 'tls01d', 'CCNUS');

COMMIT;