/*
Below script is used to change the original statement type that gets set in Acquisition code
Created : sxh487 05/21/2018 CCN Project Team....
*/
SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '75R353';
UPDATE COST_CENTER SET ACQUISITION_CODE = 'US' WHERE COST_CENTER_CODE = '75R353';
SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '75R353';
COMMIT;