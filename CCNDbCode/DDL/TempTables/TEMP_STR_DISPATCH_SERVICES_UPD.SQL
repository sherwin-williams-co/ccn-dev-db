/*
Script Name : TEMP_STR_DISPATCH_SERVICES_UPD.sql
Purpose     : For creating TEMP_STR_DISPATCH_SERVICES_UPD table.
              This is an external table which is used for storing data from STORE_DISPATCH_SERVICES_UPDATE.csv
              loaded through batch process.

Created     : 10/08/2019 akj899 CCNA2-55 CCN Project....
*/

  DROP TABLE TEMP_STR_DISPATCH_SERVICES_UPD;
  
  CREATE TABLE TEMP_STR_DISPATCH_SERVICES_UPD
   (COST_CENTER_CODE            VARCHAR2(10), 
    DESCARTES_DELIVERY_CODE     VARCHAR2(1), 
    DISPATCH_SERVICES_TYPE_CODE VARCHAR2(1), 
    GO_LIVE_DATE                VARCHAR2(50), 
    PICKUP_BUFFER               VARCHAR2(10), 
    MIN_RMNG_DLVRY_TIME         VARCHAR2(10)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "CCN_LOAD_FILES":'STORE_DISPATCH_SERVICES_UPDATE.bad'
          logfile "CCN_LOAD_FILES":'STORE_DISPATCH_SERVICES_UPDATE.log'
             FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
             LRTRIM
             MISSING FIELD VALUES ARE NULL
             (COST_CENTER_CODE,
              DESCARTES_DELIVERY_CODE,
              DISPATCH_SERVICES_TYPE_CODE, 
              GO_LIVE_DATE,
              PICKUP_BUFFER,
              MIN_RMNG_DLVRY_TIME 
              )
               )
      LOCATION
       ( 'STORE_DISPATCH_SERVICES_UPDATE.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;