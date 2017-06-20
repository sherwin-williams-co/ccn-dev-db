/***************************************************************************************************
Description : This file has commands to create table FF_DPST_TCKT_POS_CNTS
Created  : 05/10/2017 gxg192 CCN Project Team.....
Modified :
****************************************************************************************************/

CREATE TABLE FF_DPST_TCKT_POS_CNTS
   (
      COST_CENTER_CODE VARCHAR2(4),
      TERMINAL_NUMBER  VARCHAR2(6),
      POS_COUNT        VARCHAR2(5),
      FILLER           VARCHAR2(6)
   )
   ORGANIZATION EXTERNAL
   (
      TYPE ORACLE_LOADER DEFAULT DIRECTORY BANKING_LOAD_FILES ACCESS
      PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
      badfile BANKING_LOAD_FILES:'FF_DPST_TCKT_POS_CNTS_STE03062.bad'
      logfile BANKING_LOAD_FILES:'FF_DPST_TCKT_POS_CNTS_STE03062.log'
      discardfile BANKING_LOAD_FILES:'FF_DPST_TCKT_POS_CNTS_STE03062.dsc'
      FIELDS MISSING FIELD VALUES ARE NULL
      (
      COST_CENTER_CODE CHAR(4),
      TERMINAL_NUMBER  CHAR(6),
      POS_COUNT        CHAR(5),
      FILLER           CHAR(6)
      )
      ) LOCATION ( 'FF_DPST_TCKT_POS_CNTS_STE03062.TXT' )
   );