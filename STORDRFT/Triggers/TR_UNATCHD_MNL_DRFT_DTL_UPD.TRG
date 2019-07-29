create or replace TRIGGER TR_UNATCHD_MNL_DRFT_DTL_UPD
/**********************************************************************************
TR_UNATCHD_MNL_DRFT_DTL_UPD.TRG

This trigger will update SD_CHECK_NBR_PRNT_EXTRCT_DTLS to mark the check as used

created : 07/29/2019 akj899 ASP-1193 CCNSD-8 CCN Project Team
Modified: 
***********************************************************************************/
AFTER INSERT ON UNATTACHED_MNL_DRFT_DTL
FOR EACH ROW
DECLARE
    --No declarations
BEGIN

    SD_TABLE_IU_PKG.CHECK_NBR_TRCKNG_DTLS_U_SP(:NEW.CHECK_SERIAL_NUMBER,:NEW.TRANSACTION_DATE);
EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE, 'TR_UNATCHD_MNL_DRFT_DTL_UPD', SQLERRM, :NEW.COST_CENTER_CODE, :NEW.CHECK_SERIAL_NUMBER);
END TR_UNATCHD_MNL_DRFT_DTL_UPD;