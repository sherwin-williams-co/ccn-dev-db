/********************************************************************************
Below script will update Credit Hierarchy roles for gxm577 and kaftzr

Created : 10/25/2016 vxv336 CCN Project Team.
Modified: 

NOTE: This script applies only to TEST and QA. Need to modify the user list when migrating to PROD. 
********************************************************************************/
SET DEFINE OFF;

UPDATE SECURITY_MATRIX SET ROLE_CODE = 'HWCU' WHERE USER_ID IN ('gxm577', 'kaftzr') AND ROLE_CODE = 'HWCUS';

COMMIT;