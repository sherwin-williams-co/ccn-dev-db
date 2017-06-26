/***************************************************************************************************
Description : This file has commands to create table POS_DPST_TICKET_COUNTS
Created  : 05/10/2017 gxg192 CCN Project Team.....
Modified : 06/23/2017 gxg192 Added index on load_date field.
****************************************************************************************************/

CREATE TABLE POS_DPST_TICKET_COUNTS
   (
      COST_CENTER_CODE VARCHAR2(4),
      TERMINAL_NUMBER  VARCHAR2(6),
      POS_COUNT        VARCHAR2(5),
      FILLER           VARCHAR2(6),
      DATA_SOURCE      VARCHAR2(20),
      LOAD_DATE        DATE
   );

CREATE INDEX POS_DPST_TICKET_COUNTS_INDX_LD ON POS_DPST_TICKET_COUNTS (LOAD_DATE);