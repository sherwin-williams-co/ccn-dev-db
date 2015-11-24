/*
Created : dxv848 11/21/2015 create CODE_HEADER table.
*/

CREATE TABLE CODE_HEADER 
(
  CODE_HEADER_NAME VARCHAR2(30) NOT NULL 
, CODE_HEADER_TYPE VARCHAR2(3) NOT NULL 
, CODE_HEADER_DESCRIPTION VARCHAR2(100) 
, CODE_HEADER_EXPIRE_FLAG CHAR(1) 
, CODE_HEADER_EXPIRE_USER VARCHAR2(20) 
, CODE_HEADER_EXPIRE_EFF_DATE DATE 
, CODE_HEADER_DTL_VAL_SIZE NUMBER(2,0) 
, CODE_HEADER_DTL_VAL_DEFAULT VARCHAR2(32) 
, CODE_HEADER_CREATE_USER VARCHAR2(25) 
, CODE_HEADER_EFF_DATE DATE 
, CONSTRAINT CODE_HEADER_PK PRIMARY KEY(CODE_HEADER_NAME,CODE_HEADER_TYPE)
);

