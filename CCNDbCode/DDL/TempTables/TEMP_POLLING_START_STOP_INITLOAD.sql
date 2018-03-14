/*
Script Name: TEMP_POLLING_START_STOP_INITLOAD.sql

Created : 03/13/2018 nxk927 CCN Project....
Changed : 
*/
  DROP TABLE TMP_POLLING_START_STOP_INTLOAD;
  CREATE TABLE TMP_POLLING_START_STOP_INTLOAD
   (  COST_CENTER_CODE                 VARCHAR2(6),
      POLLING_START_DATE               VARCHAR2(10),
      POLLING_STOP_DATE                VARCHAR2(10)
      
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
          badfile "CCN_LOAD_FILES":'POLLING_START_STOP_INITLOAD.bad'
          logfile "CCN_LOAD_FILES":'POLLING_START_STOP_INITLOAD.log'
          FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LDRTRIM
          MISSING FIELD VALUES ARE NULL
          REJECT ROWS WITH ALL NULL FIELDS
                                       (COST_CENTER_CODE,
                                        POLLING_START_DATE,
                                        POLLING_STOP_DATE)
                     )
      LOCATION
       ( 'equip.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;
