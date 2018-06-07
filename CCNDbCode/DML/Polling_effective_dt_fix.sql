/*
Created : nxk927 CCN Project....
          Correcting the effective date for the cost centers that changed due to code issue in the polling update
*/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '701816' AND STATUS_CODE = 'Q';
UPDATE POLLING SET EFFECTIVE_DATE = '08-MAY-2018' WHERE COST_CENTER_CODE = '701816' AND STATUS_CODE = 'Q';
/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '722307' AND STATUS_CODE = 'Q';
UPDATE POLLING SET EFFECTIVE_DATE = '31-MAY-2018' WHERE COST_CENTER_CODE = '722307' AND STATUS_CODE = 'Q';
/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '725140' AND STATUS_CODE = 'Q';
UPDATE POLLING SET EFFECTIVE_DATE = '16-MAY-2018' WHERE COST_CENTER_CODE = '725140' AND STATUS_CODE = 'Q';
/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '725189' AND STATUS_CODE = 'P';
UPDATE POLLING SET EFFECTIVE_DATE = '30-MAY-2018' WHERE COST_CENTER_CODE = '725189' AND STATUS_CODE = 'P';

/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '725193' AND STATUS_CODE = 'Q';
UPDATE POLLING SET EFFECTIVE_DATE = '16-MAY-2018' WHERE COST_CENTER_CODE = '725193' AND STATUS_CODE = 'Q';

/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '725195' AND STATUS_CODE = 'Q';
UPDATE POLLING SET EFFECTIVE_DATE = '20-MAR-2018' WHERE COST_CENTER_CODE = '725195' AND STATUS_CODE = 'Q';

/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '725409' AND STATUS_CODE = 'P';
UPDATE POLLING SET EFFECTIVE_DATE = '01-JUN-2018' WHERE COST_CENTER_CODE = '725409' AND STATUS_CODE = 'P';
/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '725409' AND STATUS_CODE = 'Q';
UPDATE POLLING SET EFFECTIVE_DATE = '25-MAY-2018' WHERE COST_CENTER_CODE = '725409' AND STATUS_CODE = 'Q';

/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '725673' AND STATUS_CODE = 'Q';
UPDATE POLLING SET EFFECTIVE_DATE = '16-MAY-2018' WHERE COST_CENTER_CODE = '725673' AND STATUS_CODE = 'Q';

/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '767668' AND STATUS_CODE = 'Q';
UPDATE POLLING SET EFFECTIVE_DATE = '08-MAY-2018' WHERE COST_CENTER_CODE = '767668' AND STATUS_CODE = 'Q';

/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '767673' AND STATUS_CODE = 'Q';
UPDATE POLLING SET EFFECTIVE_DATE = '15-MAY-2018' WHERE COST_CENTER_CODE = '767673' AND STATUS_CODE = 'Q';

/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '767691' AND STATUS_CODE = 'Q';
UPDATE POLLING SET EFFECTIVE_DATE = '15-MAY-2018' WHERE COST_CENTER_CODE = '767691' AND STATUS_CODE = 'Q';

/
SELECT * FROM POLLING WHERE COST_CENTER_CODE = '768831' AND STATUS_CODE = 'P';
UPDATE POLLING SET EFFECTIVE_DATE = '20-FEB-2018' WHERE COST_CENTER_CODE = '768831' AND STATUS_CODE = 'P';
/

COMMIT;