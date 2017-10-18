/*
Giving access to CCN application to cvs187
created : nxk927 10/17/2017
changed : nxk927 10/17/2017 removed the old role codes and added new role code as per Pat
*/

--deleting previously given role codes
DELETE
  FROM SECURITY_MATRIX
 WHERE USER_ID = 'cvs187';
/
--Inserting into security matrix with new role codes
INSERT INTO SECURITY_MATRIX VALUES ('cvs187','cvs187','CCNUS1');
INSERT INTO SECURITY_MATRIX VALUES ('cvs187','cvs187','HWGUS');

COMMIT;