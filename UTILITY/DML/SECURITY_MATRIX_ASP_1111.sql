/*########################################################################
CREATED : sxg151 08/03/2018
          Give Marissa (map497) same access as Mary (mfk543) on CCN application.

###########################################################################*/

select * from security_matrix where user_id = 'mfk543';
select * from security_matrix where user_id = 'map497';

Insert into SECURITY_MATRIX values ('map497','map497','CCNUS1');
Insert into SECURITY_MATRIX values ('map497','map497','HWUAGS');
Insert into SECURITY_MATRIX values ('map497','map497','SDU');

commit;

select * from security_matrix where user_id = 'mfk543';
select * from security_matrix where user_id = 'map497';