/*---------------------------------------------------------------------------
Below script will create drop and create tabel STORE_RUN_TYPE_DETAILS for 
Store drafts tracking/printing services tables


Created: 01/18/2019 akj899 ASP-1193 CCNSD-8 CCN project Team....
---------------------------------------------------------------------------*/
  DROP TABLE STORE_RUN_TYPE_DETAILS;
   
  CREATE TABLE STORE_RUN_TYPE_DETAILS 
   (COST_CENTER_CODE              VARCHAR2(6), 
    STORE_DRAFT_CHECK_RUN_TYPE    VARCHAR2(1), 
    EFFECTIVE_DATE                DATE, 
    EXPIRATION_DATE               DATE, 
    CREATED_BY_USER_ID            VARCHAR2(100), 
    CREATED_ON_DATE               DATE, 
     CONSTRAINT STORE_RUN_TYPE_PK PRIMARY KEY (COST_CENTER_CODE, EFFECTIVE_DATE));     