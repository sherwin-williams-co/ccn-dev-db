/***************************************************************************************************
Description : This file has commands to create table as POS_CCN_LOAD_STATUS for 
              storing details about POS Load status on Banking schema
Created  : 06/12/2017 gxg192 CCN Project Team.....
Modified :
****************************************************************************************************/

CREATE TABLE POS_CCN_LOAD_STATUS
   (
      RLS_RUN_CYCLE   NUMBER NOT NULL,
      END_TS          TIMESTAMP (6) WITH TIME ZONE,
      START_TS        TIMESTAMP (6) WITH TIME ZONE,
      ORIGIN_DB       VARCHAR2(50),
      STATUS_CODE     VARCHAR2(1),
      RECORD_COUNT    NUMBER(*,0),
      CONTROL_TOTAL   NUMBER(12,2),
      LOAD_DATE       DATE
   );