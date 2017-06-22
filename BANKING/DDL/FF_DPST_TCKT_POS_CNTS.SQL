/***************************************************************************************************
Description : This file has commands to create table FF_DPST_TCKT_POS_CNTS
Created  : 05/10/2017 gxg192 CCN Project Team.....
Modified : 06/21/2017 gxg192 Changes to make this table as hostorical table and not external table
                             Data from TEMP_DPST_TCKT_POS_CNTS table (which stores data from main frame file)
                             will be loaded in this table daily. We need to store all the historical data
                             in this table thus added load_date column.
****************************************************************************************************/

CREATE TABLE FF_DPST_TCKT_POS_CNTS
   (
      COST_CENTER_CODE VARCHAR2(4),
      TERMINAL_NUMBER  VARCHAR2(6),
      POS_COUNT        VARCHAR2(5),
      FILLER           VARCHAR2(6),
      DATA_SOURCE      VARCHAR2(20),
      LOAD_DATE        DATE,
      COMMENTS         VARCHAR2(1000)
   );