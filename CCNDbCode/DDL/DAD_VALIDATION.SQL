/*
 Created : AXK326 CCN Project Team....
           1. TEMP_DAD_VALIDATION is a temp table to hold the data from the text file STFF1002.TXT from initLoad folder on DB Server 
		   2. DAD_VALIDATION is the intermediate table to hold all the data for that day
		      This is truncated and populated back from TEMP table TEMP_DAD_VALIDATION
*/
CREATE TABLE TEMP_DAD_VALIDATION 
(	
  "VALUES" VARCHAR2(15 BYTE)
) 
ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS delimited by NEWLINE
         badfile CCN_LOAD_FILES:'TEMP_VALIDATION.bad'
         logfile CCN_LOAD_FILES:'TEMP_VALIDATION.log'
         discardfile CCN_LOAD_FILES:'TEMP_VALIDATION.dsc'
          FIELDS
        (
           "VALUES" CHAR(15)
        )      
	           )
      LOCATION
      ( 
	    'STFF1002.TXT'
      )
	);

CREATE TABLE DAD_VALIDATION
(	
  "VALUE" VARCHAR2(15 BYTE)
);

