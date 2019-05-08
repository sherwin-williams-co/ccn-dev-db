/********************************************************************************
Create a table "BULK_LOAD_PROCESSES" and Grant Select access to CCNUSER

Created : 12/12/2018 sxg151 CCN Project Team....
        : ASP-1156
Created:
********************************************************************************/

CREATE TABLE BULK_LOAD_PROCESSES
(
 BULK_LOAD_PROCESS_ID          NUMBER
,BULK_LOAD_PROCESS_NAME        VARCHAR2(100)
,BULK_LOAD_PROCESS_DESCRIPTION VARCHAR2(200)
,BULK_LOAD_EXT_TBL_NAME        VARCHAR2(30)
,BULK_LOAD_PORCESS_EFFCTV_DT   DATE
,BULK_LOAD_PORCESS_EXPRTN_DT   DATE
,CREATED_BY_USER_ID            VARCHAR2(8),
CONSTRAINT BULK_LOAD_PROCESS_ID_PK PRIMARY KEY (BULK_LOAD_PROCESS_ID)
);
