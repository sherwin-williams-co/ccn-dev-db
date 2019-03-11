/*
Script Name : TEMP_POLLING_ON_DEMAND_DOWNLOADS.sql
Purpose     : For creating TEMP_POLLING_ON_DEMAND_DOWNLOADS table.
              This is an external table which is used for storing data from POLLING_ON_DEMAND_DOWNLOADS.csv
              loaded through upload process.

Created : 03/08/2019 pxa852 CCN Project Team....
*/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE TEMP_POLLING_ON_DEMAND_DOWNLOADS';
EXCEPTION WHEN OTHERS THEN
          NULL;
END;

CREATE TABLE TEMP_POLLING_ON_DEMAND_DOWNLOADS
   (COST_CENTER_CODE    VARCHAR2(6),
    DOWNLOAD_TYPE       VARCHAR2(30),
    REQUESTED_USER      VARCHAR2(6),
    REASON_FOR_DOWNLOAD VARCHAR2(100)
   ) 
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "CCN_LOAD_FILES":'POLLING_ON_DEMAND_DOWNLOADS.bad'
          logfile "CCN_LOAD_FILES":'POLLING_ON_DEMAND_DOWNLOADS.log'
             FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
             LRTRIM
             MISSING FIELD VALUES ARE NULL
             (COST_CENTER_CODE,
              DOWNLOAD_TYPE,
              REQUESTED_USER,
              REASON_FOR_DOWNLOAD
              )
           )
      LOCATION
       ( 'POLLING_ON_DEMAND_DOWNLOADS.csv'
       )
    )
   REJECT LIMIT UNLIMITED;