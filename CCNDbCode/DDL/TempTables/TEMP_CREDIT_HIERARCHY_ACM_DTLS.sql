/*
This script creates an external table that points to credit hierarchy ACM details

created : 08/23/2026 jxc517 CCN Project Team....
modified:
*/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TEMP_CREDIT_HIERARCHY_ACM_DTLS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

  CREATE TABLE TEMP_CREDIT_HIERARCHY_ACM_DTLS
   (ACM_NUMBER          VARCHAR2(10), 
    AREA_NAME           VARCHAR2(200), 
    ACM_NAME            VARCHAR2(200)
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
          ACM_NUMBER,
          AREA_NAME,
          ACM_NAME
        )
       )
      LOCATION
       ( 'credit_hierarchy_acm.csv'
       )
    );

