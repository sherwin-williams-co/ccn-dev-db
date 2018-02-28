/*
Script Name: TEMP_ADMIN_TYPE_CC.sql
Purpose    : For Ctreating external table to load data from admin_type_cc_init_load.csv.*/
CREATE TABLE TEMP_ADMIN_TYPE_CC
   (	COST_CENTER_CODE VARCHAR2(4), 
	ALLOCATION_CC VARCHAR2(4), 
	DIVISION_OFFSET VARCHAR2(4)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "CCN_LOAD_FILES":'TEMP_ADMIN_TYPE_CC.bad'
          logfile "CCN_LOAD_FILES":'TEMP_ADMIN_TYPE_CC.log'
          FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LDRTRIM
          MISSING FIELD VALUES ARE NULL
                              )
      LOCATION
       ( 'admin_type_cc_init_load.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;