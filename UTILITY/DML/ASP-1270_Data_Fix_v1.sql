/*******************************************************************************
ASP-1270: Script to insert roles for users to access  users access to the Customer Deposit Applicatin component;
users 'axh707','san760' given roles CCNUS1, CSDU
and for users 'pmm4br','lxb8vr' only role given is CSDU
Created : 05/22/2019 sxc403
*******************************************************************************/

SELECT * 
  FROM security_matrix
 WHERE user_id IN ('pmm4br','lxb8vr','axh707','san760')
   AND role_code IN ('CCNUS1', 'CSDU')
ORDER BY 1;

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('pmm4br','pmm4br','CSDU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('lxb8vr','lxb8vr','CSDU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('axh707','axh707','CCNUS1');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('axh707','axh707','CSDU');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('san760','san760','CCNUS1');

INSERT INTO security_matrix(USER_ID, PASSWORD, ROLE_CODE)
VALUES('san760','san760','CSDU');

COMMIT;

SELECT * 
  FROM security_matrix
 WHERE user_id IN ('pmm4br','lxb8vr','axh707','san760')
order by 1;
   
