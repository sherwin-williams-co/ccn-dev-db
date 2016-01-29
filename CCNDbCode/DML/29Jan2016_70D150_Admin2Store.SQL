/*
Below script will update the status of the cost center from Admin to Store
We won't be touching the mandatrory fields for store at this point as users have to do that through window

Until they do that through window UI wont allow to click on save button and might ask for more fields data
based on business rules

We also know that audit won't know that administration record is deleted and we are ok with that as well

Created : 01/29/2016 jxc517 CCN Project Team....
*/
--Updating category from A to S
SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '70D150';
--1 Row(s) Selected
UPDATE COST_CENTER SET CATEGORY = 'S' WHERE COST_CENTER_CODE = '70D150';
--1 Row(s) Updated
SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '70D150';
--1 Row(s) Selected

--Removing Administration record
SELECT * FROM ADMINISTRATION WHERE COST_CENTER_CODE = '70D150';
--1 Row(s) Selected
DELETE FROM ADMINISTRATION WHERE COST_CENTER_CODE = '70D150';
--1 Row(s) Deleted

--Adding Store record
INSERT INTO STORE VALUES ('70D150', 'S', NULL, NULL, NULL, NULL, NULL, NULL);
--1 Row(s) Created
SELECT * FROM STORE WHERE COST_CENTER_CODE = '70D150';
--1 Row(s) Selected

COMMIT;
