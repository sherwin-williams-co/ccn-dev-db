
/*
Script Name : TEMP_MKT_SALES_UPD.sql
Purpose     : For creating TEMP_MKT_SALES_UPD table.
              This is an external table which is used for    storing the Square footage information for initial load.
Created : 10/16/2018 pxa852 CCN Project....
*/

BEGIN
EXECUTE IMMEDIATE 'DROP TABLE TEMP_MKT_SALES_UPD';
EXCEPTION WHEN OTHERS THEN
          NULL;
END;

CREATE TABLE TEMP_MKT_SALES_UPD 
    (COST_CENTER VARCHAR2(6), 
	 TOTAL_SQ_FT NUMBER, 
	 SALES_SQ_FT NUMBER
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "CCN_LOAD_FILES":'MARKETING_SALES_UPD.bad'
          logfile "CCN_LOAD_FILES":'MARKETING_SALES_UPD.log'
          FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LDRTRIM
          MISSING FIELD VALUES ARE NULL
                              )
      LOCATION
       ( 'MARKETING_SALES_UPD.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;