/***************************************************************************************************
Description : This file has commands to create table as POS_CCN_LOAD_STATUS for 
              storing details about POS Load status on Banking schema
Created  : 06/12/2017 gxg192 CCN Project Team.....
Modified : 06/23/2017 gxg192 Added index on load_date field.
         : 06/27/2017 gxg192 Changes in data type.
****************************************************************************************************/

CREATE TABLE POS_CCN_LOAD_STATUS
   (
      RLS_RUN_CYCLE   NUMBER NOT NULL,
      END_TS          TIMESTAMP (6) WITH TIME ZONE,
      START_TS        TIMESTAMP (6) WITH TIME ZONE,
      ORIGIN_DB       VARCHAR2(50),
      STATUS_CODE     VARCHAR2(1),
      RECORD_COUNT    NUMBER,
      CONTROL_TOTAL   NUMBER,
      LOAD_DATE       DATE
   );

CREATE INDEX POS_CCN_LOAD_STATUS_INDX_LD ON POS_CCN_LOAD_STATUS (LOAD_DATE);