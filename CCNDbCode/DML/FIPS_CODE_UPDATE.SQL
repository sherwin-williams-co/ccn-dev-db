--Place the file given by mainframes onto the corresponding server, after renaming it to CCN09000_FIPS_CODE.TXT
  CREATE TABLE TEMP_FIPS_CODE 
   (	
      FIPS_CODE VARCHAR(10),
      FILLER VARCHAR(6),
      STORE_PEF VARCHAR(1),
      COST_CENTER_CODE VARCHAR(4),
      STORE_SUF VARCHAR(1),
      COUNTY VARCHAR(16),
      CITY VARCHAR(16),
      STATE VARCHAR(2),
      FILLER1 VARCHAR(6),
      ZIP_CODE VARCHAR(10),
      FILLER2 VARCHAR(6)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile CCN_LOAD_FILES:'TEMP_FIPS_CODE.bad'
        logfile CCN_LOAD_FILES:'TEMP_FIPS_CODE.log'
        discardfile CCN_LOAD_FILES:'TEMP_FIPS_CODE.dsc'
          FIELDS
          missing field values are null
      (FIPS_CODE CHAR(10),
       FILLER CHAR(6),
       STORE_PEF CHAR(1),
       COST_CENTER_CODE CHAR(4),
       STORE_SUF CHAR(1),
       COUNTY CHAR(16),
       CITY (16),
       STATE CHAR(2),
       FILLER1 CHAR(6),
       ZIP_CODE CHAR(10),
       FILLER2 CHAR(6)
       )
     )
     LOCATION ('CCN09000_FIPS_CODE.TXT')
    );

BEGIN
    --Audit has to go, so just locking is enough
    CCN_BATCH_PKG.LOCK_DATABASE_SP(); --lock the database
    
    FOR rec IN (SELECT A.COST_CENTER_CODE,
                       B.FIPS_CODE
                  FROM ADDRESS_USA A,
                       TEMP_FIPS_CODE B
                 WHERE SUBSTR(A.COST_CENTER_CODE, 3) = B.COST_CENTER_CODE
                   AND A.EXPIRATION_DATE IS NULL
                   AND A.FIPS_CODE <> B.FIPS_CODE) LOOP
        UPDATE ADDRESS_USA
           SET FIPS_CODE = rec.FIPS_CODE
          WHERE COST_CENTER_CODE = rec.COST_CENTER_CODE
            AND EXPIRATION_DATE IS NULL;
    END LOOP;
    COMMIT;
    
    DBMS_MVIEW.REFRESH('ADDRESS_ALL'); --Refresh the materialized view that is using this view
    
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP(); --unlock the database
END;
/

--drop the temporary table as the process is completed
DROP TABLE TEMP_FIPS_CODE;
