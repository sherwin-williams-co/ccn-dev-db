/*
Below script will move the terminal 20066 from 799835 to OO9838

We have to let the audit go through as the old as well as new terminal details needs to be updated in POS

Created : 03/31/2016 jxc517 CCN Project Team....
*/
SELECT * FROM TERMINAL WHERE COST_CENTER_CODE = '799835' AND TERMINAL_NUMBER = '20066';
--1 Row(s) Selected
DELETE FROM TERMINAL WHERE COST_CENTER_CODE = '799835' AND TERMINAL_NUMBER = '20066';
--1 Row(s) Deleted

INSERT INTO TERMINAL VALUES ('OO9838', 'I', '20066', '29-MAR-2016', NULL, NULL, NULL);
--1 Row(s) Created
SELECT * FROM TERMINAL WHERE COST_CENTER_CODE = 'OO9838' AND TERMINAL_NUMBER = '20066';
--1 Row(s) Selected

COMMIT;
