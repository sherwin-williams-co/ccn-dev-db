/*******************************************************
These scripts will insert data into the  table that holds the data for audit
suppressed field

Created : 02/28/2018 nxk927 CCN Project Team. . . .
Changed : 03/05/2018 nxk927 CCN Project Team. . . .
          Removing the inactive field
*******************************************************/
DELETE FROM CCN_AUDIT_EXCLUDED_FIELDS
 WHERE COLUMN_NAME = 'INACTIVE_DATE';

COMMIT;

