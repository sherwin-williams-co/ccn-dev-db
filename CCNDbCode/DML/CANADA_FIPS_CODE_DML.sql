/*
Created : 06/09/2017 rxv940/jxc517 CCN Project Team....
          insert scripts for default canadian province fips codes
*/
REM INSERTING into CANADA_FIPS_CODE
SET DEFINE OFF;
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63010','AB','ALBERTA');
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63020','BC','BRITISH COLUMBIA');
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63030','MB','MANITOBA');
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63040','NB','NEW BRUNSWICK');
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63050','NL','NEWFOUNDLAND');
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63060','NT','NORTHWEST TERRITORIE');
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63070','NS','NOVA SCOTIA');
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63080','ON','ONTARIO');
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63090','PE','PRINCE EDWARD ISLAND');
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63100','QC','QUEBEC');
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63110','SK','SASKATCHEWAN');
INSERT INTO CANADA_FIPS_CODE (FIPS_CODE,PROVINCE_CODE,PROVINCE_NAME) values ('63120','YT','YUKON TERRITORIES');

COMMIT;