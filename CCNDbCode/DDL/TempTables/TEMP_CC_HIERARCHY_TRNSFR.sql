CREATE TABLE TEMP_CC_HIERARCHY_TRNSFR
(COST_CENTER_CODE VARCHAR2(6), 
	MANAGER_ID       VARCHAR2(20), 
	HIERARCHY_NAME   VARCHAR2(100), 
	FROM_HIERARCHY   VARCHAR2(100), 
	TO_HIERARCHY     VARCHAR2(100)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1 
      badfile CCN_LOAD_FILES:'TEMP_CC_HIERARCHY_TRNSFR.bad' 
      logfile CCN_LOAD_FILES:'TEMP_CC_HIERARCHY_TRNSFR.log' 
      FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
      LDRTRIM MISSING FIELD VALUES ARE NULL
      REJECT ROWS WITH ALL NULL FIELDS
      (COST_CENTER_CODE,
       MANAGER_ID,
       HIERARCHY_NAME,
       FROM_HIERARCHY,
       TO_HIERARCHY)
                          )
      LOCATION
       ( 'COST_CENTER_HIERARCHY_TRNSFR.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;