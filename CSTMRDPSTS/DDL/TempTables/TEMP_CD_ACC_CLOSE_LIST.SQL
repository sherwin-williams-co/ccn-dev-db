/*
Script Name : TEMP_CD_ACC_CLOSE_LIST.sql
Purpose     : For creating TEMP_SD_ORDER_DETAILS  table.
              This is an external table which is used for closing the customer account from CD_ACC_CLOSE_LIST.csv

Created     : 08/29/2019 akj899  CCNCd-14 CCN Project....
*/

CREATE TABLE TEMP_CD_ACC_CLOSE_LIST
   (CUSTOMER_NUMBER VARCHAR2(10)
   )
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CSTMR_DPSTS_DATA_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "CSTMR_DPSTS_DATA_FILES":'CD_ACC_CLOSE_LIST.bad'
          logfile "CSTMR_DPSTS_DATA_FILES":'CD_ACC_CLOSE_LIST.log'
             FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
             LRTRIM
             MISSING FIELD VALUES ARE NULL
             (CUSTOMER_NUMBER
              )
               )
      LOCATION
       ( 'CD_ACC_CLOSE_LIST.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;