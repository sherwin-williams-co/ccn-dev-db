/***************************************************************************************************
Description : This file has commands to create table POS_INTERIM_DEPST
Created  : 05/10/2017 gxg192 CCN Project Team.....
Modified :
****************************************************************************************************/

CREATE TABLE POS_INTERIM_DEPST
   (
      REGION           VARCHAR2(2),
      CTLCLK           VARCHAR2(2),
      DIV_NO           VARCHAR2(2),
      COST_CENTER_CODE VARCHAR2(4),
      TERMINAL_NUMBER  VARCHAR2(5),
      TRAN_NO          VARCHAR2(6),
      RLSE_RUN         VARCHAR2(100),
      TRAN_DATE        VARCHAR2(6),
      TRAN_TIME        VARCHAR2(4),
      FILLER           VARCHAR2(1),
      TRAN_NO1         VARCHAR2(5),
      EMP_NO           VARCHAR2(2),
      DEPST_AMOUNT     VARCHAR2(9),
      DATA_SOURCE      VARCHAR2(20),
      LOAD_DATE        DATE
   );