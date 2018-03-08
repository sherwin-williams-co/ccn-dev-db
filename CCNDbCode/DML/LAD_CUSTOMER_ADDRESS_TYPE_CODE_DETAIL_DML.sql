/*
Created : 02/13/2018 mxv711 CCN Project Team....
          Below script will insert a new address type for LATIN AMERICAN COST CENTERS
*/

INSERT INTO CODE_DETAIL VALUES ('CATEGORY', 'COD', 'C', 'LAD CUSTOMER', 'N', NULL, NULL, 8, NULL, NULL);
            
UPDATE INSERTORDER SET TABLE_ORDER = TABLE_ORDER + 1 WHERE TABLE_ORDER > 21;
INSERT INTO INSERTORDER SELECT 'LAD_CUSTOMER', 22 FROM DUAL;

COMMIT;