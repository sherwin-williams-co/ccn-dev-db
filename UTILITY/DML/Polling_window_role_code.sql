--adding new role code for the polling window
--nxk927 11/17/2016
INSERT INTO ROLE_DETAILS VALUES  ('CCNUS4','CCN Polling Window User Select','N','N','N','Y', NULL, NULL);

--Adding users jxa345 and nxk351 for polling window access.
INSERT INTO SECURITY_MATRIX VALUES ('jxa345', 'jxa345', 'CCNUS4');
INSERT INTO SECURITY_MATRIX VALUES ('nxk351', 'nxk351', 'CCNUS4');

COMMIT;




