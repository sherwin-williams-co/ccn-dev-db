/*******************************************************
These scripts will insert data into the  table that holds the data for audit
suppressed field

Created : 03/14/2018 nxk927 CCN Project Team. . . .
Changed :
*******************************************************/
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('POLLING', 'POLLING_START_DATE', 'Y');
INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('POLLING', 'POLLING_STOP_DATE', 'Y');

COMMIT;