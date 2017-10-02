/***************************************************************************************************
Description : Table ERROR_LOG for customer deposits
Created  : 09/28/2017 sxh487 CCN Project Team.....
****************************************************************************************************/
CREATE TABLE ERROR_LOG 
    (	ERROR_ID NUMBER NOT NULL ENABLE, 
       CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9) NOT NULL ENABLE, 
       ERROR_DATE DATE NOT NULL ENABLE, 
       MODULE VARCHAR2(65) NOT NULL ENABLE, 
       ERROR_TEXT VARCHAR2(500), 
       NOTES VARCHAR2(200), 
       ERROR_CODE VARCHAR2(9), 
       COST_CENTER_CODE VARCHAR2(6), 
       TABLE_NAME VARCHAR2(30),
CONSTRAINT ERROR_LOG_PK PRIMARY KEY (ERROR_ID, COST_CENTER_CODE, ERROR_DATE, MODULE));

CREATE INDEX ERROR_LOG_INDEX1 ON ERROR_LOG (ERROR_ID, ERROR_DATE, COST_CENTER_CODE, MODULE) ;
