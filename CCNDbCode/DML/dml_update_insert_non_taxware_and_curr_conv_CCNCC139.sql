/********************************************************************************************
This script is created to update the Barbados non tax ware and currency conversion details.

Created : 07/18/2019 axm868 CCN Project CCNCC-139....
          Run these scripts in COSTCNTR
Modified: 
********************************************************************************************/
SET DEFINE OFF;

SELECT * FROM NON_TAXWARE_RATES WHERE COUNTRY_CODE = 'BRB' AND EXPIRATION_DATE IS NULL;
--1 Row(s) Selected
SELECT * FROM CURRENCY_CONVERSION WHERE COUNTRY_CODE = 'BRB' AND EXPIRATION_DATE IS NULL;
--1 Row(s) Selected

UPDATE NON_TAXWARE_RATES SET EXPIRATION_DATE = '30-JUN-2019' WHERE COUNTRY_CODE = 'BRB' AND EXPIRATION_DATE IS NULL;
--1 Row(s) Updated
INSERT INTO NON_TAXWARE_RATES VALUES ('BRB','BB','TIN','84002',17.5,'17.50%','1000001642848','01-JUL-2019',NULL,'pmm4br');
--1 Row(s) Inserted
UPDATE CURRENCY_CONVERSION SET EXPIRATION_DATE = '30-JUN-2019' WHERE COUNTRY_CODE = 'BRB' AND EXPIRATION_DATE IS NULL;
--1 Row(s) Updated
INSERT INTO CURRENCY_CONVERSION VALUES ('BRB','01-JUL-2019',NULL,2,'yes','BBD','1000001642848','TIN#','TIN','pmm4br');
--1 Row(s) Inserted

COMMIT;

SELECT * FROM NON_TAXWARE_RATES WHERE COUNTRY_CODE = 'BRB' AND EXPIRATION_DATE IS NULL;
--1 Row(s) Selected
SELECT * FROM CURRENCY_CONVERSION WHERE COUNTRY_CODE = 'BRB' AND EXPIRATION_DATE IS NULL;
--1 Row(s) Selected