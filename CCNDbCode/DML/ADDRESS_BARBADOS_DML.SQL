/*
created : 05/24/2016 jxc517 CCN Project Team....
          Below script will insert the new country code as well as update the insert_order table to consider this new countries address table
*/
INSERT INTO CODE_DETAIL VALUES ('COUNTRY_CODE', 'COD', 'BRB', 'BARBADOS', 'N', NULL, NULL, 12, 'jxc517', NULL);

UPDATE INSERTORDER SET TABLE_ORDER = TABLE_ORDER + 1 WHERE TABLE_ORDER >= 2;
INSERT INTO INSERTORDER VALUES ('ADDRESS_BRB',2);
COMMIT;
