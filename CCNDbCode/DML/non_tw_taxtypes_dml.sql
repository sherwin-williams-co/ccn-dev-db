/*
This script inserts data into code Header and code Detail tables to handle non taxware tax types

Created : 11/15/2017 axt754 CCN Project Team....
Changed :
*/

--Create a new code header : NON_TW_TAXTYPE 
INSERT INTO CODE_HEADER VALUES('NON_TW_TAXTYPE','COD','NON TAXWARE TAX TYPES',NULL,NULL,NULL,20,NULL,NULL,NULL,NULL); 

--Create a new code details for header NON_TW_TAXTYPE 
INSERT INTO CODE_DETAIL VALUES('NON_TW_TAXTYPE','COD','Excise Tax','Excise Tax',NULL,NULL,NULL,1,NULL,NULL); 
INSERT INTO CODE_DETAIL VALUES('NON_TW_TAXTYPE','COD','Health Care','Health Tax',NULL,NULL,NULL,2,NULL,NULL); 
INSERT INTO CODE_DETAIL VALUES('NON_TW_TAXTYPE','COD','Sales Tax','Sales Tax',NULL,NULL,NULL,3,NULL,NULL); 
INSERT INTO CODE_DETAIL VALUES('NON_TW_TAXTYPE','COD','VAT','VAT',NULL,NULL,NULL,4,NULL,NULL); 

COMMIT;
