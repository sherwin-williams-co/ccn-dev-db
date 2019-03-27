/*
This script will archive/delete the cost centers as per the list provided by Pat

Created : 3/27/2019 dxp896 CCN Project Team....
Changed
*/

-- Execute this only till QA
ALTER TABLE ARC_POLLING RENAME COLUMN effective_date to poll_status_eff_dt;
ALTER TABLE ARC_POLLING RENAME COLUMN expiration_date to poll_status_exp_dt;
EXEC CC_ARCHIVE_DELET_RECREATE_PKG.RECREATE_MISMTCH_ARCHV_TBL_SP();

-- Check if /app/ccn/xxx/datafiles/COST_CENTER_DELETE.csv already exists, if so rename it (for history purpose)
-- Make sure the cost centers are properly applied on database server /app/ccn/xxx/datafiles/COST_CENTER_DELETE.csv file
-- Execute below code in all environments
SELECT * FROM TEMP_COST_CENTER_DELETE; --Make sure the query results are proper as per the list provided by user

EXEC CC_ARCHIVE_DELET_RECREATE_PKG.PROCESS();

--Validation Script
SELECT * FROM ARC_COST_CENTER WHERE COST_CENTER_CODE IN (SELECT COST_CENTER_CODE FROM TEMP_COST_CENTER_DELETE);
SELECT * FROM CC_DELETION_GUIDS WHERE ARCHIVE_COST_CENTER_CODE IN (SELECT COST_CENTER_CODE FROM TEMP_COST_CENTER_DELETE);
SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE IN (SELECT COST_CENTER_CODE FROM CC_DELETION_GUIDS WHERE ARCHIVE_COST_CENTER_CODE IN (SELECT COST_CENTER_CODE FROM TEMP_COST_CENTER_DELETE));