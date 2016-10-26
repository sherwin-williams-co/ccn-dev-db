/*
This script contains the DDLs for loading the prime sub header/details reference data

Created : 10/10/2016 jxc517 CCN Project Team....
Changed : 10/26/2016 jxc517 CCN Project Team....
          Modified the names for the log/err/dsc files
*/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE TEMP_PRIME_SUB_HEADER_SRA13003';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

  CREATE TABLE TEMP_PRIME_SUB_HEADER_SRA13003
   (	A         VARCHAR2(10),
      FILLER    VARCHAR2(2),
      CODE      VARCHAR2(4),
      FILLER1   VARCHAR2(26),
      B         VARCHAR2(3),
      C         VARCHAR2(9),
      NAME      VARCHAR2(100)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "BANKING_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile BANKING_LOAD_FILES:'TEMP_PRIME_SUB_HEADER_SRA13003.bad'
        logfile BANKING_LOAD_FILES:'TEMP_PRIME_SUB_HEADER_SRA13003.log'
        discardfile BANKING_LOAD_FILES:'TEMP_PRIME_SUB_HEADER_SRA13003.dsc'
        LOAD WHEN ((43:44) = 'JV' OR (43:45) = 'IDI')
        FIELDS(
      A         CHAR(10),
      FILLER    CHAR(2),
      CODE      CHAR(4),
      FILLER1   CHAR(26),
      B         CHAR(3),
      C         CHAR(9),
      NAME      CHAR(100)
                               )
                  )
      LOCATION
       ( 'drafts-subprime.txt'
       )
    );
/


BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE TEMP_PRIME_SUB_DETAIL_SRA13003';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

  CREATE TABLE TEMP_PRIME_SUB_DETAIL_SRA13003
   (	A            VARCHAR2(10),
      FILLER       VARCHAR2(2),
      CODE         VARCHAR2(4),
      DR_CR        VARCHAR2(7),
      FILLER1      VARCHAR2(19),
      DIVISION     VARCHAR2(3),
      PRIME_SUB    VARCHAR2(7),
      PRIME_SUB_CC VARCHAR2(4)
   )
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "BANKING_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile BANKING_LOAD_FILES:'TEMP_PRIME_SUB_DETAIL_SRA13003.bad'
        logfile BANKING_LOAD_FILES:'TEMP_PRIME_SUB_DETAIL_SRA13003.log'
        discardfile BANKING_LOAD_FILES:'TEMP_PRIME_SUB_DETAIL_SRA13003.dsc'
        LOAD WHEN ((22:23) = 'CR' OR (22:23) = 'DR')
        FIELDS(
      A            CHAR(10),
      FILLER       CHAR(2),
      CODE         CHAR(4),
      DR_CR        CHAR(7),
      FILLER1      CHAR(19),
      DIVISION     CHAR(3),
      PRIME_SUB    CHAR(7),
      PRIME_SUB_CC CHAR(4)
                               )
                  )
      LOCATION
       ( 'drafts-subprime.txt'
       )
    );
/

/*
SELECT * FROM TEMP_PRIME_SUB_HEADER_SRA13003;
SELECT * FROM TEMP_PRIME_SUB_DETAIL_SRA13003;
*/
