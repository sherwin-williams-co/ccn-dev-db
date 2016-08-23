/*
This script creates an external table that points to credit hierarchy details

created : 08/23/2026 jxc517 CCN Project Team....
modified:
*/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TEMP_CREDIT_HIERARCHY_DETAIL';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

  CREATE TABLE TEMP_CREDIT_HIERARCHY_DETAIL
   (HRCHY_HDR_NAME          VARCHAR2(100), 
    HRCHY_DTL_LEVEL         VARCHAR2(2), 
    HRCHY_DTL_PREV_LVL_VAL  VARCHAR2(1000), 
    HRCHY_DTL_CURR_LVL_VAL  VARCHAR2(1000), 
    HRCHY_DTL_NEXT_LVL_VAL  VARCHAR2(1000), 
    HRCHY_DTL_EFF_DATE      DATE, 
    HRCHY_DTL_EXP_DATE      DATE, 
    HRCHY_DTL_DESC          VARCHAR2(100), 
    ATTRIB1                 VARCHAR2(1000), 
    ATTRIB2                 VARCHAR2(1000)
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
          HRCHY_HDR_NAME,
          HRCHY_DTL_LEVEL,
          HRCHY_DTL_PREV_LVL_VAL,
          HRCHY_DTL_CURR_LVL_VAL,
          HRCHY_DTL_NEXT_LVL_VAL,
          HRCHY_DTL_EFF_DATE DATE 'YYYYMMDD',
          HRCHY_DTL_EXP_DATE DATE 'YYYYMMDD',
          HRCHY_DTL_DESC,
          ATTRIB1,
          ATTRIB2
        )
       )
      LOCATION
       ( 'credit_hierarchy.csv'
       )
    );
