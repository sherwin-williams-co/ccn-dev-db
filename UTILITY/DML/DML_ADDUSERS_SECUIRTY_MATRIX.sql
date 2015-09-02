/*
Created :dxv848 09/02/2015 Adding USERS in SECURITY_MATRIX table.(cost_center application read only access).
*/


Insert into SECURITY_MATRIX values ('rab54r','rab54r','CCNUS1');
Insert into SECURITY_MATRIX values ('rae4gr','rae4gr','CCNUS1');
Insert into SECURITY_MATRIX values ('jmk01r','jmk01r','CCNUS1');
Insert into SECURITY_MATRIX values ('ems17r','ems17r','CCNUS1');

COMMIT;


select * from SECURITY_MATRIX where USER_ID in ('rab54r','rae4gr','jmk01r','ems17r');
