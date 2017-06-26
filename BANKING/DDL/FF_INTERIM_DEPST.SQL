/***************************************************************************************************
Description : This file has commands to create table FF_INTERIM_DEPST
Created  : 05/10/2017 gxg192 CCN Project Team.....
Modified : 06/21/2017 gxg192 Changes to make this table as hostorical table and not external table
                             Data from TEMP_INTERIM_DEPST table (which stores data from main frame file)
                             will be loaded in this table daily. We need to store all the historical data
                             in this table thus added load_date column.
         : 06/23/2017 gxg192 Changed datasize of a column and added index on load_date field.
****************************************************************************************************/

CREATE TABLE FF_INTERIM_DEPST
   (
      REGION           VARCHAR2(2),
      CTLCLK           VARCHAR2(2),
      DIV_NO           VARCHAR2(2),
      COST_CENTER_CODE VARCHAR2(4),
      TERMINAL_NUMBER  VARCHAR2(5),
      TRAN_NO          VARCHAR2(6),
      RLSE_RUN         VARCHAR2(3),
      TRAN_DATE        VARCHAR2(6),
      TRAN_TIME        VARCHAR2(4),
      FILLER           VARCHAR2(1),
      TRAN_NO1         VARCHAR2(5),
      EMP_NO           VARCHAR2(2),
      DEPST_AMOUNT     VARCHAR2(9),
      DATA_SOURCE      VARCHAR2(20),
      LOAD_DATE        DATE,
      COMMENTS         VARCHAR2(1000)
    );

CREATE INDEX FF_INTERIM_DEPST_INDX_LD ON FF_INTERIM_DEPST (LOAD_DATE);