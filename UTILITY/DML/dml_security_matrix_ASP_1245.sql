/*##############################################################################################################
Created : 04/12/2019 sxg151 CCN Project Team..
          ASP-1245 : This script will provide CCNUS1 and HWGUS access to user "cgs934"
--#############################################################################################################*/

select * from security_matrix where user_id = 'cgs934';

insert into SECURITY_MATRIX values ('cgs934','cgs934','CCNUS1');
insert into SECURITY_MATRIX values ('cgs934','cgs934','HWGUS');

COMMIT;

select * from security_matrix where user_id = 'cgs934';
