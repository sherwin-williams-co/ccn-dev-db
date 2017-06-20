/***************************************************************************************************
Description : This file has commands to create table DPST_TCKT_POS_CNTS_DLY
Created  : 05/10/2017 gxg192 CCN Project Team.....
Modified :
****************************************************************************************************/

CREATE TABLE DPST_TCKT_POS_CNTS_DLY
   (
      COST_CENTER_CODE VARCHAR2(4),
      TERMINAL_NUMBER  VARCHAR2(6),
      POS_COUNT        VARCHAR2(5),
      FILLER           VARCHAR2(6),
      DATA_SOURCE      VARCHAR2(20),
      LOAD_DATE        DATE,
      COMMENTS         VARCHAR2(1000)
   );