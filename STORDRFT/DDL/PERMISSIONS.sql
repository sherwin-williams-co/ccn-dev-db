GRANT EXECUTE ON SD_UI_INTERFACE_APP_PKG TO STDRFTUSR;
GRANT EXECUTE ON SD_UI_REPORTS_PKG TO STDRFTUSR;
GRANT EXECUTE ON SD_PICK_LIST_PKG TO STDRFTUSR;
GRANT SELECT ON CCN_UTILITY.BATCH_JOB TO STORDRFT;

/* These Grants belongs to STOREDRFT_JV_VW View */
GRANT SELECT ON STOREDRFT_JV_VW TO SHW_DSERV_CP2D11E_DBLU;
GRANT SELECT ON STOREDRFT_JV_VW TO SHW_DSERV_CP5P11I_DBLU;
GRANT SELECT ON STOREDRFT_JV_VW TO STDRFTUSR;