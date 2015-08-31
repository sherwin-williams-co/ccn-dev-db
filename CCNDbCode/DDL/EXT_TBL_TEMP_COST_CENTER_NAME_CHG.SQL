/*******************************************************************************
This external table is used to update the cost center name and statement type 

Created  : 08/31/2015 axk326 CCN Project....
Modified : 
*******************************************************************************/
CREATE TABLE TEMP_COST_CENTER_NAME_CHG 
   (	
    "COST_CENTER_CODE" VARCHAR2(6 BYTE), 
	"COST_CENTER_NAME" VARCHAR2(35 BYTE), 
	"CATEGORY" VARCHAR2(1 BYTE), 
	"ENTITY_TYPE" VARCHAR2(2 BYTE), 
	"STATEMENT_TYPE" VARCHAR2(2 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS delimited by NEWLINE
        badfile CCN_LOAD_FILES:'TEMP_COST_CENTER_NAME_CHG.bad'
        logfile CCN_LOAD_FILES:'TEMP_COST_CENTER_NAME_CHG.log'
        discardfile CCN_LOAD_FILES:'TEMP_COST_CENTER_NAME_CHG.dsc'
        FIELDS TERMINATED BY ','
        LRTRIM
        MISSING FIELD VALUES ARE NULL
        (
           COST_CENTER_CODE CHAR(6), 
           COST_CENTER_NAME CHAR(35), 
           "CATEGORY" CHAR(1),
           ENTITY_TYPE CHAR(2),
           STATEMENT_TYPE CHAR(2)
        )                          )
      LOCATION
       ( "CCN_LOAD_FILES":'COST_CENTER_TERR_NAME_CHANGE.csv'
       )
    );
