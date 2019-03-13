/*##############################################################################################################
Created : 03/12/2019 sxg151 CCN Project Team..
        : This script will assign roles to Ruquia Suleman(rxs675) to acess CCN Main Window and Hierarchy Window Credit Hierarchy 

--#############################################################################################################*/

-- Run the below in lower environments (test/qa)

select * from security_matrix where user_id in ('rxs675');

insert into SECURITY_MATRIX values ('rxs675','rxs675','CCNUS3');
insert into SECURITY_MATRIX values ('rxs675','rxs675','HWCU');

COMMIT;

select * from security_matrix where user_id in ('rxs675');

-- Run the below in Production environment "HWCUS" View access only

select * from security_matrix where user_id in ('rxs675');

insert into SECURITY_MATRIX values ('rxs675','rxs675','CCNUS3');
insert into SECURITY_MATRIX values ('rxs675','rxs675','HWCUS');

COMMIT;

select * from security_matrix where user_id in ('rxs675');