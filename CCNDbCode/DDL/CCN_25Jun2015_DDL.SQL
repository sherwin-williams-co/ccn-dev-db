/*
1. This DDL consitututes the new columns added to cost_center table
2. DDL for temp table to have the initload for PCC and PCL program type values
Created: AXK326 CCN Project Team
Revised: 
*/

ALTER TABLE COST_CENTER
  ADD
    (
     COLOR_CONSULTANT_TYPE "SYS"."XMLTYPE",  
     PCC_PCL_STORE "SYS"."XMLTYPE"
    );
	
-- Temp table for storing PCC, PCL data

CREATE TABLE TEMP_PCL_PCC_CCN 
   (	
    "COST_CENTER" VARCHAR2(6 BYTE), 
	"TYPE" VARCHAR2(3 BYTE), 
	"TO_BE_ALLO" VARCHAR2(7 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS delimited by NEWLINE
        badfile CCN_LOAD_FILES:'TEMP_PCL_PCC_CCN.bad'
        logfile CCN_LOAD_FILES:'TEMP_PCL_PCC_CCN.log'
        discardfile CCN_LOAD_FILES:'TEMP_PCL_PCC_CCN.dsc'
        FIELDS TERMINATED BY ','
        LRTRIM
        MISSING FIELD VALUES ARE NULL
        (
           COST_CENTER CHAR(6), 
           "TYPE" CHAR(3), 
           TO_BE_ALLO CHAR(10)
        )              )
      LOCATION
       ( "CCN_LOAD_FILES":'PCL_PCC_CCN.csv'
       )
    );
