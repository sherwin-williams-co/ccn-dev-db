/*
This script inserts data into code Header and code Detail tables to handle non taxware tax types.

Created : 01/05/2018 axt754 CCN Project Team....
Changed :
*/

--Create a new code header : NON_TAXWARE_TYPES
INSERT INTO CODE_HEADER VALUES('NON_TAXWARE_TYPES','COD','NON TAXWARE TAX TYPES',NULL,NULL,NULL,20,NULL,NULL,NULL,NULL);

--Create a new code details for header NON_TAXWARE_TYPES
INSERT INTO CODE_DETAIL VALUES('NON_TAXWARE_TYPES','COD','Excise Tax','Excise Tax',NULL,NULL,NULL,1,NULL,NULL);
INSERT INTO CODE_DETAIL VALUES('NON_TAXWARE_TYPES','COD','Health Care','Health Tax',NULL,NULL,NULL,2,NULL,NULL);
INSERT INTO CODE_DETAIL VALUES('NON_TAXWARE_TYPES','COD','Sales Tax','Sales Tax',NULL,NULL,NULL,3,NULL,NULL);
INSERT INTO CODE_DETAIL VALUES('NON_TAXWARE_TYPES','COD','VAT','VAT',NULL,NULL,NULL,4,NULL,NULL);

COMMIT;