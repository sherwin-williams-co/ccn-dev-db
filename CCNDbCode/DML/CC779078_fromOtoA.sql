/*
Below script will change the cost center of category Other to Admin

Created : 8/20/2019 jxc517 CCN Project Team
Changed :
*/
SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '779078';
SELECT * FROM OTHER WHERE COST_CENTER_CODE = '779078';
SELECT * FROM ADMINISTRATION WHERE COST_CENTER_CODE = '779078';

UPDATE COST_CENTER SET CATEGORY = 'A' WHERE COST_CENTER_CODE = '779078';
INSERT INTO ADMINISTRATION VALUES ('779078','A',NULL,NULL,NULL,NULL);

SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '779078';
SELECT * FROM OTHER WHERE COST_CENTER_CODE = '779078';
SELECT * FROM ADMINISTRATION WHERE COST_CENTER_CODE = '779078';

COMMIT;