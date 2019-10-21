/*
Script Name : TEMP_STR_DESCARTES_NEW_WINDOW_INITLOAD.sql
Purpose     : For creating TEMP_STR_DESCARTES_NEW_WINDOW_INITLOAD table.
              This is an external table which is used for storing data from STORE_DESCARTES_INITLOAD_UPDATE.csv
              loaded through batch process.

Created     : 09/05/2019 akj899 CCNA2-55 CCN Project....
*/

DROP TABLE TEMP_STR_DESCARTES_NEW_WINDOW_INITLOAD;

CREATE TABLE TEMP_STR_DESCARTES_NEW_WINDOW_INITLOAD
   (COST_CENTER_CODE         VARCHAR2(6),
    GO_LIVE_DATE             VARCHAR2(20),
    PICKUP_BUFFER            VARCHAR2(10),
    MIN_RMNG_DLVRY_TIME      VARCHAR2(10)
   )
   ORGANIZATION EXTERNAL
    (TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      (RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "CCN_LOAD_FILES":'STORE_DESCARTES_INITLOAD_UPDATE.bad'
          logfile "CCN_LOAD_FILES":'STORE_DESCARTES_INITLOAD_UPDATE.log'
             FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
             LRTRIM
             MISSING FIELD VALUES ARE NULL
             REJECT ROWS WITH ALL NULL FIELDS
             (COST_CENTER_CODE,
              GO_LIVE_DATE,
              PICKUP_BUFFER,
              MIN_RMNG_DLVRY_TIME
              )
       )
      LOCATION
       ( 'STORE_DESCARTES_INITLOAD_UPDATE.csv'
       )
    ) REJECT LIMIT UNLIMITED;