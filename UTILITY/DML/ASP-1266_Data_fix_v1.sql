/*******************************************************************************
Script to insert roles for users to access customer_deposits screen on the application.
users 'twb393','jpz381','bxk368' given roles 'CCNUS1','CSDU'
Created : 05/17/2019 sxc403
*******************************************************************************/

SELECT * 
  FROM security_matrix
 WHERE user_id IN ('twb393','jpz381','bxk368')
   AND role_code IN ('CCNUS1','CSDU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('twb393','twb393','CCNUS1');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('jpz381','jpz381','CCNUS1');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('bxk368','bxk368','CCNUS1');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('twb393','twb393','CSDU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('jpz381','jpz381','CSDU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('bxk368','bxk368','CSDU');

COMMIT;

SELECT * 
  FROM security_matrix
 WHERE user_id IN ('twb393','jpz381','bxk368')
   AND role_code IN ('CCNUS1','CSDU')
 order by 1;