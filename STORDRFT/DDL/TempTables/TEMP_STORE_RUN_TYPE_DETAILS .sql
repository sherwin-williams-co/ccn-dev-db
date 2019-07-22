/*
Script Name : TEMP_STORE_RUN_TYPE_DETAILS.sql
Purpose     : For creating TEMP_STORE_RUN_TYP_THRSHLD_DTLS table.
              This is an external table which is used for storing data from STORE_RUN_TYPE_DETAILS.csv
              loaded through batch process.

Created : 07/12/2019 akj899  ASP-1274 CCN SD Project....
*/

DROP TABLE TEMP_STORE_RUN_TYE_DTLS ;

  CREATE TABLE TEMP_STORE_RUN_TYPE_DETAILS
   (COST_CENTER_CODE VARCHAR2(6), 
    RUN_TYPE VARCHAR2(1)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "STORDRFT_LOAD_FILES":'STORE_RUN_TYPE_DETAILS.bad'
          logfile "STORDRFT_LOAD_FILES":'STORE_RUN_TYPE_DETAILS.log'
             FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
             LRTRIM
             MISSING FIELD VALUES ARE NULL
             (COST_CENTER_CODE,
              RUN_TYPE
              )
               )
      LOCATION
       ( 'STORE_RUN_TYPE_DETAILS.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;