--Adding new user mxz518. Giving mxz518 same access as christopher T. Greve
--05/24/2016 nxk927 CCN Project...
Insert into SECURITY_MATRIX values ('mxz518','mxz518','CCNUS1');
Insert into SECURITY_MATRIX values ('mxz518','mxz518','SDU1');

COMMIT;

SELECT * FROM SECURITY_MATRIX where USER_ID in ('mxz518', 'ctg355');
