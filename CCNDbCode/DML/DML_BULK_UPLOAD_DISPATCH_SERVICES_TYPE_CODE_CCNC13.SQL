/***************************************************************************************
Bulk Upload process to add and update for new field DISPATCH_SERVICES_TYPE_CODE
Created : 06/14/2019 akj899 CCNCC-13 

***************************************************************************************/
INSERT INTO BULK_LOAD_PROCESSES VALUES(14, 'DISPATCH_SERVICES_TYPE_CODE_UPD','This process allows user to bulk update DISPATCH SERVICES TYPE CODE details into CCN.', 'TEMP_STR_DSPTH_SRV_TYP_CD_UPD', SYSDATE, NULL, 'INITLOAD');
INSERT INTO BULK_LOAD_PRCS_CLM_MPING VALUES('STORE', 'DISPATCH_SERVICES_TYPE_CODE', 'DISPATCH_SERVICES_TYPE_CODE', NULL, NULL);

COMMIT;