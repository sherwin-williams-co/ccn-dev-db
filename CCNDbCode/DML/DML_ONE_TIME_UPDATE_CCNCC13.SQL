/***************************************************************************************
This script will be used for onetime update of DISPATCH_SERVICES_TYPE_CODE in STORE table 
to default value 1.

Created : 07/05/2019 akj899 CCNCC-13 CCN Project...
***************************************************************************************/
DECLARE
V_BULK_UPD_ID NUMBER;
BEGIN
    POS_DATA_GENERATION.SET_FLAG_POLLING_BULK_LOADS('CCNCC13_ONE_TIME_DSPTCH_SRVC_TYP_UPD', V_BULK_UPD_ID);

    UPDATE STORE
       SET DISPATCH_SERVICES_TYPE_CODE = 1;

    POS_DATA_GENERATION.RESET_FLAG_POLLING_BULK_LOADS(V_BULK_UPD_ID);
   
    COMMIT;
END;