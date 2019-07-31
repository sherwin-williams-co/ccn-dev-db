/*****************************************************************
Below script will add new field DISPATCH_SERVICES_TYPE_CODE to CCN

CREATED  : 06/12/2019 akj899 ASP-1274 CCN Project...
Modified : 07/30/2019 akj899 ASP-1274 CCN Project...
           Invoke RECREATE_MISMTCH_ARCHV_TBL_SP to alter 
           archive table and add columns as per order 
           in base table.
******************************************************************/

ALTER TABLE STORE     ADD (DISPATCH_SERVICES_TYPE_CODE  VARCHAR2(1));
ALTER TABLE STORE_HST ADD (DISPATCH_SERVICES_TYPE_CODE  VARCHAR2(1));

BEGIN
    CC_ARCHIVE_DELET_RECREATE_PKG.RECREATE_MISMTCH_ARCHV_TBL_SP();
END;