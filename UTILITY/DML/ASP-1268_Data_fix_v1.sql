/*******************************************************************************
ASP-1268: Script to insert roles for users to access customer_deposits screen on the application.
users 'axh707','san760' given roles CCNU, HWU, SDU, HWCU, CCNPUS
Created : 05/21/2019 sxc403
*******************************************************************************/
   
SELECT * 
  FROM security_matrix
 WHERE user_id IN ('axh707','san760')
   AND role_code IN ('CCNU', 'HWU', 'SDU', 'HWCU', 'CCNPUS');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('axh707','axh707','CCNU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('san760','san760','CCNU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('axh707','axh707','HWU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('san760','san760','HWU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('axh707','axh707','SDU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('san760','san760','SDU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('axh707','axh707','HWCU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('san760','san760','HWCU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('axh707','axh707','CCNPUS');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('san760','san760','CCNPUS');

COMMIT;

SELECT * 
  FROM security_matrix
 WHERE user_id IN ('axh707','san760')
    AND role_code IN ('CCNU', 'HWU', 'SDU', 'HWCU', 'CCNPUS')
 order by 1;
 