/*##############################################################################################################
Created : 07/06/2018 sxg151 CCN Project Team..
          This script creates a new role 'HWUAOS' and assign to Andrew's Team
          Mary Kirkpatrick (MFK543) and Jessica Dell'Aquila (jld570)

--#############################################################################################################*/

select * from security_matrix where user_id in ('ajl964','mfk543','jld570');

insert into SECURITY_MATRIX values ('mfk543','mfk543','HWUAGS');
insert into SECURITY_MATRIX values ('jld570','jld570','CCNUS1');
insert into SECURITY_MATRIX values ('jld570','jld570','HWUAGS');

COMMIT;

select * from security_matrix where user_id in ('ajl964','mfk543','jld570');