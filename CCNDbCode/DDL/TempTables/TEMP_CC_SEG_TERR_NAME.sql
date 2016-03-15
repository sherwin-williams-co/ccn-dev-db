/****************************
Created : nxk927 03/15/2016 
          creating the temp table to load the data and update the  
          TERRITORY_TYPE_BUSN_CODE in TERRITORY table
          and cost center name in the cost center table
		  
		  check the external file
          place it in the server
		  this table will be dropped after the update
*******************************/

CREATE TABLE TEMP_CC_SEG_TERR_NAME
   (COST_CENTER_CODE VARCHAR2(6 BYTE), 
	  COST_CENTER_NAME VARCHAR2(50 BYTE), 
	  SEG_TYPE VARCHAR2(2 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS delimited by NEWLINE
        badfile CCN_LOAD_FILES:'TEMP_CC_SEG_TERR_NAME.bad'
        logfile CCN_LOAD_FILES:'TEMP_CC_SEG_TERR_NAME.log'
        discardfile CCN_LOAD_FILES:'TEMP_CC_SEG_TERR_NAME.dsc'
        skip 1
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (
           COST_CENTER_CODE CHAR(6), 
           COST_CENTER_NAME CHAR(50), 
           SEG_TYPE CHAR(2)
        )                          )
      LOCATION
       ( 'COST_CENTER_TERR_NAME CHANGE_MAR14.csv'
       )
    );
 