/*
This script creates a Table COSTCNTR.CCN_ADDRESS_GEO_DETAILS and the grant to 
Utility schema 
Created by rxv940 on 03/20/2018
ASP-976 - Run this in COSTCNTR Schema

*/

-- Create table script 
CREATE TABLE CCN_ADDRESS_GEO_DETAILS 
    (COST_CENTER_CODE VARCHAR2(6) NOT NULL ENABLE, 
     LONGITUDE       VARCHAR2(11), 
     LATITUDE        VARCHAR2(11), 
     ADDRESS_TYPE    VARCHAR2(2),
     EFFECTIVE_DATE  DATE, 
     EXPIRATION_DATE DATE, 
      CONSTRAINT PK_CCN_ADDRESS_GEO_DETAILS PRIMARY KEY (COST_CENTER_CODE, ADDRESS_TYPE, EFFECTIVE_DATE)
    );