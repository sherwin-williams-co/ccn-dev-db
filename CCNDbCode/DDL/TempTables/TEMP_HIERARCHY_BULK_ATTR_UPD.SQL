
/*
Script Name: HIERARCHY_BULK_ATTR_UPDATE.SQL
Purpose    : For dropping and creating the TEMP_HIERARCHY_BULK_ATTR table.
             This is an external table which is used for storing data from HIERARCHY_BULK_ATTR.csv
             loaded through batch process.

Created : 12/05/2018 mxs216, CCN Project.... ASP-1169

*/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TEMP_HIERARCHY_BULK_ATTR_UPD';
EXCEPTION 
    WHEN OTHERS THEN 
        NULL;
END;
/

  CREATE TABLE "COSTCNTR"."TEMP_HIERARCHY_BULK_ATTR_UPD" 
   ("HRCHY_HDR_NAME" VARCHAR2(100 BYTE), 
	"HRCHY_DTL_LEVEL" VARCHAR2(2 BYTE), 
	"HRCHY_DTL_CURR_LVL_VAL" VARCHAR2(100 BYTE),
	"ATTR_NAME" VARCHAR2(100 BYTE), 
	"ATTR_VALUE" VARCHAR2(100 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "CCN_LOAD_FILES":'TEMP_HIERARCHY_BULK_ATTR.bad'
          logfile "CCN_LOAD_FILES":'TEMP_HIERARCHY_BULK_ATTR.log'
          FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LRTRIM
          MISSING FIELD VALUES ARE NULL
          REJECT ROWS WITH ALL NULL FIELDS
                                       (HRCHY_HDR_NAME,
                                        HRCHY_DTL_LEVEL,
                                        HRCHY_DTL_CURR_LVL_VAL,
                                        ATTR_NAME,
                                        ATTR_VALUE)
                             )
      LOCATION
       ( 'HIERARCHY_BULK_ATTR_UPDATE.csv'
       )
    )
   REJECT LIMIT UNLIMITED;