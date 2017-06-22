/*
This temp table will hold data for the interim deposit tickets/bag
which will be loaded into FF_INTERIM_DEPST table.
Created : nxk927 09/12/2016
Changed : gxg192 06/22/2017 Modified datasize for RLSE_RUN field.
*/

CREATE TABLE TEMP_INTERIM_DEPST
    (REGION            VARCHAR2(2),
     CTLCLK            VARCHAR2(2),
     DIV_NO            VARCHAR2(2),
     COST_CENTER_CODE  VARCHAR2(4),
     TERMINAL_NUMBER   VARCHAR2(5),
     TRAN_NO           VARCHAR2(6),
     RLSE_RUN          VARCHAR2(10),
     TRAN_DATE         VARCHAR2(6),
     TRAN_TIME         VARCHAR2(4),
     FILLER            VARCHAR2(1),
     TRAN_NO1          VARCHAR2(5),
     EMP_NO            VARCHAR2(2),
     DEPST_AMOUNT      VARCHAR2(9)
   )
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY BANKING_LOAD_FILES
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile BANKING_LOAD_FILES:'TEMP_INTERIM_DEPST.bad'
        logfile BANKING_LOAD_FILES:'TEMP_INTERIM_DEPST.log'
        discardfile BANKING_LOAD_FILES:'TEMP_INTERIM_DEPST.dsc'
        FIELDS
        (REGION            CHAR(2),
         CTLCLK            CHAR(2),
         DIV_NO            CHAR(2),
         COST_CENTER_CODE CHAR(4),
         TERMINAL_NUMBER   CHAR(5),
         TRAN_NO           CHAR(6),
         RLSE_RUN          CHAR(3),
         TRAN_DATE         CHAR(6),
         TRAN_TIME         CHAR(4),
         FILLER            CHAR(1),
         TRAN_NO1          CHAR(5),
         EMP_NO            CHAR(2),
         DEPST_AMOUNT      CHAR(9)))
      LOCATION
       ('STE03064_DEPST.TXT'
       )
    );
/
