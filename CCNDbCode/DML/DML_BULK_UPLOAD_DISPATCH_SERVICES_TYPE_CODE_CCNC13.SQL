/***************************************************************************************
Bulk Upload process to add and update for new field DISPATCH_SERVICES_TYPE_CODE
Created : 06/14/2019 akj899 CCNCC-13 

***************************************************************************************/
INSERT INTO BULK_LOAD_PROCESSES VALUES(14, 'Bulk Dispatch Services Type Code Update','This process allows user to bulk update DISPATCH SERVICES TYPE CODE details into CCN.', 'TEMP_STR_DSPTH_SRV_TYP_CD_UPD', SYSDATE, NULL, 'INITLOAD');

COMMIT;