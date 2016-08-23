/*
This script creates an external table that points to credit hierarchy DCM details

created : 08/23/2026 jxc517 CCN Project Team....
modified:
*/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TEMP_CREDIT_HIERARCHY_DCM_DTLS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

  CREATE TABLE TEMP_CREDIT_HIERARCHY_DCM_DTLS
   (DCM_NUMBER          VARCHAR2(10), 
    DCM_CITY            VARCHAR2(200), 
    DCM_NAME            VARCHAR2(200)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_DATAFILES"
      ACCESS PARAMETERS
      ( records delimited by newline 
        FIELDS TERMINATED BY ',' 
        LRTRIM
        missing field values are null 
        ( 
          DCM_NUMBER,
          DCM_CITY,
          DCM_NAME
        )
       )
      LOCATION
       ( 'credit_hierarchy_dcm.csv'
       )
    );

