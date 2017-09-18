/**************************************************************************************
Created : sxh487 09/18/2017
          Adding new user Michael J. Fuchs (user ID mjf192) with the same Roles as
          Alysa Gailey 'amg626' and deleting amg626
**************************************************************************************/
SET DEFINE OFF;
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('mjf192','mjf192','CCNUS1');
Insert into SECURITY_MATRIX (USER_ID,PASSWORD,ROLE_CODE) values ('mjf192','mjf192','SDU');

DELETE FROM SECURITY_MATRIX WHERE UPPER(USER_ID) = UPPER('amg626');

COMMIT;