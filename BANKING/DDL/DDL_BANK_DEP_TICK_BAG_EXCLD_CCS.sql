/*
   script name: DDL_BANK_DEP_TICK_BAG_EXCLD_CCS.sql
   Created by : 03/07/2018 axt754 CCN Project Team...
                This Script Creates table BANK_DEP_TICK_BAG_EXCLD_CCS
*/

CREATE TABLE BANK_DEP_TICK_BAG_EXCLD_CCS (COST_CENTER_CODE   VARCHAR2(6),
                                         COST_CENTER_NAME    VARCHAR2(100),
                                         POLLING_STATUS_CODE VARCHAR2(1),
                                         CATEGORY            VARCHAR2(1),
                                         COUNTRY_CODE        VARCHAR2(3),
                                         OPEN_DATE           DATE,
                                         TICKET_BAG_TYPE     VARCHAR2(5));