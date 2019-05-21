/*******************************************************************************
ASP-1268: Script to insert roles for users to access customer_deposits screen on the application.
users 'axh707','san760' given roles 'CCNUS1','CSDU'
Created : 05/21/2019 sxc403
*******************************************************************************/
 
SELECT * 
  FROM security_matrix
 WHERE user_id IN ('axh707','san760')
   AND role_code IN ('CCNUS1','CSDU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('axh707','axh707','CCNUS1');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('san760','san760','CCNUS1');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('axh707','axh707','CSDU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('san760','san760','CSDU');

COMMIT;

SELECT * 
  FROM security_matrix
 WHERE user_id IN ('axh707','san760')
   AND role_code IN ('CCNUS1','CSDU')
 order by 1;