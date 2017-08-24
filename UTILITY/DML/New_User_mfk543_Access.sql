/**************************************************************************************
Created : rxa457 08/23/2017
          Adding new user 'mfk543' Mary Kirkpatrick to CCN 
          Store drafts with same access credentials of
          Christopher T Greeve 'ctg355'
**************************************************************************************/
SET DEFINE OFF;
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('mfk543','mfk543','CCNUS1');
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('mfk543','mfk543','SDU');

COMMIT;
