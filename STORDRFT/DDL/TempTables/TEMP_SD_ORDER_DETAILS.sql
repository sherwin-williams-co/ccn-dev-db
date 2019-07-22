/*
Script Name : TEMP_SD_ORDER_DETAILS.sql
Purpose     : For creating TEMP_SD_ORDER_DETAILS  table.
              This is an external table which is used for storing data from SD_ORDER_DETAILS .csv
              loaded through batch process.

Created : 07/12/2019 akj899  ASP-1274 CCN Project....
*/

DROP TABLE TEMP_SD_ORDER_DETAILS ;

CREATE TABLE TEMP_SD_ORDER_DETAILS
   (COST_CENTER_CODE VARCHAR2(6),
    END_DRFT_NBR VARCHAR2(10),
    LAST_ORDER_DATE VARCHAR2(10)
   )
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "STORDRFT_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "STORDRFT_LOAD_FILES":'SD_ORDER_DETAILS.bad'
          logfile "STORDRFT_LOAD_FILES":'SD_ORDER_DETAILS.log'
             FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
             LRTRIM
             MISSING FIELD VALUES ARE NULL
             (COST_CENTER_CODE,
              END_DRFT_NBR,
              LAST_ORDER_DATE
              )
               )
      LOCATION
       ( 'SD_ORDER_DETAILS.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;
