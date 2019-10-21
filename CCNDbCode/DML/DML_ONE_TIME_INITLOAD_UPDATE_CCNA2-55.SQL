/*****************************************************************************************
This script will be used for one time update of DESCARTES NEW WINDOW fields GO_LIVE_DATE, 
PICKUP_BUFFER and MIN_RMNG_DLVRY_TIME in STORE table 
if its null.

Created : 09/05/2019 akj899 CCNA2-55 CCN Project...
*****************************************************************************************/
DECLARE
    V_BULK_UPD_ID NUMBER;
BEGIN
    POS_DATA_GENERATION.SET_FLAG_POLLING_BULK_LOADS('CCNCC-161_DSCRTS_NEW_WNDW_INITLD_UPD', V_BULK_UPD_ID);
    DBMS_OUTPUT.PUT_LINE(V_BULK_UPD_ID);
    FOR rec IN (SELECT * FROM TEMP_STR_DESCARTES_NEW_WINDOW_INITLOAD) LOOP
        UPDATE STORE s
           SET s.GO_LIVE_DATE         = rec.GO_LIVE_DATE,
               s.PICKUP_BUFFER        = rec.PICKUP_BUFFER,
               s.MIN_RMNG_DLVRY_TIME  = rec.MIN_RMNG_DLVRY_TIME
         WHERE s.COST_CENTER_CODE = rec.COST_CENTER_CODE;
    END LOOP;
    POS_DATA_GENERATION.RESET_FLAG_POLLING_BULK_LOADS(V_BULK_UPD_ID);
    COMMIT;
END;