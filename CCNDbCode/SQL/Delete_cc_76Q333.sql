/*
Created: 03/13/2018 nxk927 
         Deleting cost center 76Q333
*/

SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '76Q333';
SELECT * FROM AUDIT_LOG WHERE TRANSACTION_ID LIKE '%76Q333%';
EXEC CCN_UI_INTERFACE_APP_PKG.DELETE_COST_CENTER('76Q333');
SELECT * FROM AUDIT_LOG WHERE TRANSACTION_ID LIKE '%76Q333%';
SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '76Q333';
COMMIT; 