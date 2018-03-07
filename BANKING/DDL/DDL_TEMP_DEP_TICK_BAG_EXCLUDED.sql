/*
   script name: DDL_TEMP_DEP_TICK_BAG_EXCLUDED.sql
   Created by : 03/07/2018 axt754 CCN Project Team...
                This Script Creates table TEMP_DEP_TICK_EXCLUDED
*/

CREATE TABLE TEMP_DEP_TICK_BAG_EXCLUDED (COST_CENTER_CODE    VARCHAR2(6),
                                         COST_CENTER_NAME    VARCHAR2(100),
                                         POLLING_STATUS_CODE VARCHAR2(1),
                                         CATEGORY            VARCHAR2(1),
                                         COUNTRY_CODE        VARCHAR2(3),
                                         OPEN_DATE           VARCHAR2(20));