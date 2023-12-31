/*
This script will mark the cost center as non-polling cost center for new store load

Created : 01/08/2018 jxc517 CCN Project Team....
Changed :
*/
ALTER TRIGGER TR_COST_CENTER_UPD DISABLE;

SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '728013';
UPDATE COST_CENTER SET POS_DOWNLOAD_CC_IND = NULL WHERE COST_CENTER_CODE = '728013';
SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '728013';
COMMIT;

ALTER TRIGGER TR_COST_CENTER_UPD ENABLE;
