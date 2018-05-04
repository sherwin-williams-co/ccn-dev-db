/********************************************************************************
Below script will insert into SECURITY_MATRIX Table
Adding new users Lisa(lms66r) to Have access same like Joan

Created : 04/04/2018 sxg151 CCN Project Team

********************************************************************************/

Insert into SECURITY_MATRIX values ('lms66r','lms66r','CCNPHS');
Insert into SECURITY_MATRIX values ('lms66r','lms66r','CCNUPB');
Insert into SECURITY_MATRIX values ('lms66r','lms66r','CCNUS1');
Insert into SECURITY_MATRIX values ('lms66r','lms66r','CCNUS4');
Insert into SECURITY_MATRIX values ('lms66r','lms66r','HWU2');

COMMIT;

select * from security_matrix where user_id = 'jmk01r';
select * from security_matrix where user_id = 'lms66r';