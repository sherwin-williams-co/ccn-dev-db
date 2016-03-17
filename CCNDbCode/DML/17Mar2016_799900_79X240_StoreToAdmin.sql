/*
Below script will update the status of the cost center from Store to Admin
We won't be touching the mandatrory fields for admin at this point as users have to do that through window

Until they do that through window UI wont allow to click on save button and might ask for more fields data
based on business rules

We also know that audit won't know that store record is deleted and we are ok with that as well

Created : 03/17/2016 jxc517 CCN Project Team....
*/
--Updating category from A to S
SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE IN ('799900','79X240');
--2 Row(s) Selected
UPDATE COST_CENTER SET CATEGORY = 'A' WHERE COST_CENTER_CODE IN ('799900','79X240');
--2 Row(s) Updated
SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE IN ('799900','79X240');
--2 Row(s) Selected

--Removing Administration record
SELECT * FROM STORE WHERE COST_CENTER_CODE IN ('799900','79X240');
--2 Row(s) Selected
DELETE FROM STORE WHERE COST_CENTER_CODE IN ('799900','79X240');
--2 Row(s) Deleted

--Adding Store record
INSERT INTO ADMINISTRATION VALUES ('799900', 'A', NULL, NULL);
--1 Row(s) Created
INSERT INTO ADMINISTRATION VALUES ('79X240', 'A', NULL, NULL);
--1 Row(s) Created
SELECT * FROM ADMINISTRATION WHERE COST_CENTER_CODE IN ('799900','79X240');
--2 Row(s) Selected

COMMIT;
