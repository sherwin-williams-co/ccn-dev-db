/*
Created :
Changed : 4/21/2017 jxc517 CCN Project Team ....
          Added Effective date field for credit and price district hierarchies
*/
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TEMP_COST_CENTER_HIERARCHY';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

  CREATE TABLE TEMP_COST_CENTER_HIERARCHY
   (	COST_CENTER_CODE VARCHAR2(6), 
	MANAGER_ID       VARCHAR2(20), 
	HIERARCHY_NAME   VARCHAR2(100), 
	HIERARCHY_VALUE  VARCHAR2(100),
	EFFECTIVE_DATE   VARCHAR2(12)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1 
        badfile CCN_LOAD_FILES:'TEMP_COST_CENTER_HIERARCHY.bad' 
        logfile CCN_LOAD_FILES:'TEMP_COST_CENTER_HIERARCHY.log' 
        FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
        LDRTRIM MISSING FIELD VALUES ARE NULL
        REJECT ROWS WITH ALL NULL FIELDS
          (COST_CENTER_CODE,
           MANAGER_ID,
           HIERARCHY_NAME,
           HIERARCHY_VALUE,
           EFFECTIVE_DATE)
      )
      LOCATION ('COST_CENTER_HIERARCHY.csv')
    )
   REJECT LIMIT UNLIMITED;
