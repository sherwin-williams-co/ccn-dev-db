/*########################################################################
CREATED : sxg151 06/20/2018
          New Developer CCN access for axs791 same as sxr128

###########################################################################*/

Insert into SECURITY_MATRIX values ('axs791','axs791','CCND');
Insert into SECURITY_MATRIX values ('axs791','axs791','HWD');
Insert into SECURITY_MATRIX values ('axs791','axs791','SDD');

commit;

select * from security_matrix where user_id = 'axs791';
select * from security_matrix where user_id = 'sxr128';