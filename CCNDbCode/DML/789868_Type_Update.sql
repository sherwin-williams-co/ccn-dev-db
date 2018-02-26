/*
Below script is a temporary fix to allow user to access cost center 789868, until UI issue is fixed

Created : jxc517 2/23/2018 CCN Project Team....
*/
SELECT * FROM TYPE WHERE COST_CENTER_CODE = '789868';
UPDATE TYPE SET EXPIRATION_DATE = NULL WHERE COST_CENTER_CODE = '789868' AND EFFECTIVE_DATE = '28-FEB-2007';
SELECT * FROM TYPE WHERE COST_CENTER_CODE = '789868';

COMMIT;
