/*
This script creates an external table that points to credit hierarchy RCM details

created : 08/23/2026 jxc517 CCN Project Team....
modified:
*/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TEMP_CREDIT_HIERARCHY_RCM_DTLS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

  CREATE TABLE TEMP_CREDIT_HIERARCHY_RCM_DTLS
   (RCM_NUMBER          VARCHAR2(10), 
    TITLE               VARCHAR2(200), 
    RCM_NAME            VARCHAR2(200)
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
          RCM_NUMBER,
          TITLE,
          RCM_NAME
        )
       )
      LOCATION
       ( 'credit_hierarchy_rcm.csv'
       )
    );

