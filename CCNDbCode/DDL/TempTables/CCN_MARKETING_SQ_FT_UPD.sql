/*
Script Name: CCN_MARKETING_SQ_FT_UPD.sql
Purpose    : For dropping and creating the TEMP_MARKETING_SQ_FT_UPD table.
             This is an external table which is used for storing data from CCN_MARKETING_SQ_FT_UPD.csv
             loaded through bulk process.

Created : 12/05/2017 axt754 CCN Project....
Changed :
*/
DROP TABLE TEMP_MARKETING_SQ_FT_UPD;
  
   CREATE TABLE TEMP_MARKETING_SQ_FT_UPD
   (   COST_CENTER_CODE VARCHAR2(6), 
       TOTAL_SQ_FT     VARCHAR2(10),
       SALES_SQ_FT     VARCHAR2(10),
       LEASE_OWN_CODE  VARCHAR2(1)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "CCN_LOAD_FILES":'CCN_MARKETING_SQ_FT.bad'
          logfile "CCN_LOAD_FILES":'CCN_MARKETING_SQ_FT.log'
          FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LDRTRIM
          MISSING FIELD VALUES ARE NULL
                      )
       LOCATION 
       ( 'CCN_MARKETING_SQ_FT_UPD.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;
