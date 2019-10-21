/*****************************************************************
Below script will add new field GO_LIVE_DATE, PICKUP_BUFFER and 
MIN_RMNG_DLVRY_TIME  to STORE table

CREATED  : 09/05/2019 akj899 CCNA2-55 CCN Project...
Modified : 
******************************************************************/

ALTER TABLE STORE ADD (GO_LIVE_DATE           DATE,
                       PICKUP_BUFFER          VARCHAR2(10),
                       MIN_RMNG_DLVRY_TIME    VARCHAR2(10)
                      );

ALTER TABLE STORE_HST ADD (GO_LIVE_DATE           DATE,
                           PICKUP_BUFFER          VARCHAR2(10),
                           MIN_RMNG_DLVRY_TIME    VARCHAR2(10)
                          );
BEGIN
    CC_ARCHIVE_DELET_RECREATE_PKG.RECREATE_MISMTCH_ARCHV_TBL_SP();
END;