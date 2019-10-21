/*****************************************************************
This script will insert the data into BULK_LOAD_PROCESSES table.
Created : 10/08/2019 akj899 CCNA2-55 CCN Project...
******************************************************************/
INSERT INTO BULK_LOAD_PROCESSES (BULK_LOAD_PROCESS_ID,BULK_LOAD_PROCESS_NAME,BULK_LOAD_PROCESS_DESCRIPTION,BULK_LOAD_EXT_TBL_NAME,BULK_LOAD_PORCESS_EFFCTV_DT,BULK_LOAD_PORCESS_EXPRTN_DT,CREATED_BY_USER_ID) VALUES( 16,'Bulk Upload Store Dispatch Service Field Values', 'This process will bulk update the store dispatch service related multiple field values into CCN', 'TEMP_STORE_DISPATCH_SERVICES_UPD',SYSDATE,NULL, 'INITLOAD');

SELECT * FROM BULK_LOAD_PROCESSES ORDER BY 1;

COMMIT;