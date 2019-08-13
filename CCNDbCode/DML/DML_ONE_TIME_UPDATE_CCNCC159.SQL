/*****************************************************************************************
This script will be used for one time update of DESCARTES_DELIVERY_CODE to B in STORE table 
if its null.

Created : 08/13/2019 akj899 CCNCC-159 CCN Project...
*****************************************************************************************/
DECLARE
    V_BULK_UPD_ID NUMBER;
BEGIN
    POS_DATA_GENERATION.SET_FLAG_POLLING_BULK_LOADS('CCNCC-159_DSCRTS_DLVRY_CD_UPD', V_BULK_UPD_ID);
    DBMS_OUTPUT.PUT_LINE(V_BULK_UPD_ID);
    UPDATE STORE SET DESCARTES_DELIVERY_CODE = 'B' WHERE DESCARTES_DELIVERY_CODE IS NULL;
    POS_DATA_GENERATION.RESET_FLAG_POLLING_BULK_LOADS(V_BULK_UPD_ID);
    COMMIT;
END;