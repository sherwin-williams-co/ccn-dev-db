/*########################################################################
CREATED : sxg151 05/24/2018
          New Developer CCN access for sxm540 same as sxr128

###########################################################################*/

Insert into SECURITY_MATRIX values ('sxm540','sxm540','CCND');
Insert into SECURITY_MATRIX values ('sxm540','sxm540','HWD');
Insert into SECURITY_MATRIX values ('sxm540','sxm540','SDD');

commit;

select * from security_matrix where user_id = 'sxm540';
select * from security_matrix where user_id = 'sxr128';