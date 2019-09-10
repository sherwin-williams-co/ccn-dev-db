/*****************************************************************************************
This script will be used for Correcting status history as per Pat's request

Created : 09/10/2019 akj899 CCNCC-190 CCN Project...
*****************************************************************************************/

SELECT * FROM STATUS WHERE COST_CENTER_CODE = '707263' ORDER BY EFFECTIVE_DATE;
--6 Row(s) Selected

SELECT * FROM STATUS WHERE COST_CENTER_CODE = '707263' AND STATUS_CODE = '2';
--1 Row(s) Selected
DELETE FROM STATUS WHERE COST_CENTER_CODE = '707263' AND STATUS_CODE = '2';
--1 Row(s) Deleted


SELECT * FROM STATUS WHERE COST_CENTER_CODE = '707263' AND STATUS_CODE = '1' AND EFFECTIVE_DATE = '27-AUG-2019';
--1 Row(s) Selected
DELETE FROM STATUS WHERE COST_CENTER_CODE = '707263' AND STATUS_CODE = '1' AND EFFECTIVE_DATE = '27-AUG-2019';
--1 Row(s) Deleted


SELECT * FROM STATUS WHERE COST_CENTER_CODE = '707263' AND STATUS_CODE = '1' AND EFFECTIVE_DATE = '08-JUL-1997';
--1 Row(s) Selected
UPDATE STATUS SET EXPIRATION_DATE = NULL WHERE COST_CENTER_CODE = '707263' AND STATUS_CODE = '1' AND EFFECTIVE_DATE = '08-JUL-1997';
--1 Row(s) Updated


SELECT * FROM STATUS WHERE COST_CENTER_CODE = '707263' ORDER BY EFFECTIVE_DATE;
--4 Row(s) Selected

COMMIT;