/*
Below script will grant access to mec994
Milan Campbell: mec994 

Created : 08/20/2019 sxs484 CCN Project Team....
Changed :
*/

select * 
  from security_matrix
 where USER_ID = 'mec994';
 
 
SET DEFINE OFF;
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('mec994','mec994','HWUAGS');
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('mec994','mec994','CCNUS1');
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('mec994','mec994','SDU');

select * 
  from security_matrix
 where USER_ID = 'mec994';

COMMIT;