/*##############################################################################################################
Created : 03/12/2019 sxg151 CCN Project Team..
        : This script will assign roles to Ruquia Suleman(rxs675) to acess CCN Main Window and Hierarchy Window Credit Hierarchy 

--#############################################################################################################*/

select * from security_matrix where user_id in ('rxs675');

insert into SECURITY_MATRIX values ('rxs675','rxs675','CCNUS1');
insert into SECURITY_MATRIX values ('rxs675','rxs675','HWCU');

COMMIT;

select * from security_matrix where user_id in ('rxs675');