CREATE OR REPLACE PACKAGE CODE_HEADER_tapi
/*********************************************************** 
This package will hold the SQL DEVELOPER generated 
INSERT, UPDATE, and DELETE procedures/functions 
used to process the CODE_HEADER table	

created : 01/25/2012 tal CCN project
revisions: 

************************************************************/
IS
type CODE_HEADER_tapi_rec
IS
  record
  (
    CODE_HEADER_EXPIRE_EFF_DATE CODE_HEADER.CODE_HEADER_EXPIRE_EFF_DATE%type ,
    CODE_HEADER_NAME CODE_HEADER.CODE_HEADER_NAME%type ,
    CODE_HEADER_EXPIRE_USER CODE_HEADER.CODE_HEADER_EXPIRE_USER%type ,
    CODE_HEADER_EXPIRE_FLAG CODE_HEADER.CODE_HEADER_EXPIRE_FLAG%type ,
    CODE_HEADER_TYPE CODE_HEADER.CODE_HEADER_TYPE%type ,
    CODE_HEADER_DTL_VAL_DEFAULT CODE_HEADER.CODE_HEADER_DTL_VAL_DEFAULT%type ,
    CODE_HEADER_DESCRIPTION CODE_HEADER.CODE_HEADER_DESCRIPTION%type ,
    CODE_HEADER_DTL_VAL_SIZE CODE_HEADER.CODE_HEADER_DTL_VAL_SIZE%type );
type CODE_HEADER_tapi_tab
IS
  TABLE OF CODE_HEADER_tapi_rec;
  -- insert
PROCEDURE ins(
    IN_CODE_HEADER_EXPIRE_EFF_DATE IN CODE_HEADER.CODE_HEADER_EXPIRE_EFF_DATE%type DEFAULT NULL ,
    IN_CODE_HEADER_NAME            IN CODE_HEADER.CODE_HEADER_NAME%type ,
    IN_CODE_HEADER_EXPIRE_USER     IN CODE_HEADER.CODE_HEADER_EXPIRE_USER%type DEFAULT NULL ,
    IN_CODE_HEADER_EXPIRE_FLAG     IN CODE_HEADER.CODE_HEADER_EXPIRE_FLAG%type DEFAULT NULL ,
    IN_CODE_HEADER_TYPE            IN CODE_HEADER.CODE_HEADER_TYPE%type ,
    IN_CODE_HEADER_DTL_VAL_DEFAULT IN CODE_HEADER.CODE_HEADER_DTL_VAL_DEFAULT%type DEFAULT NULL ,
    IN_CODE_HEADER_DESCRIPTION     IN CODE_HEADER.CODE_HEADER_DESCRIPTION%type DEFAULT NULL ,
    IN_CODE_HEADER_DTL_VAL_SIZE    IN CODE_HEADER.CODE_HEADER_DTL_VAL_SIZE%type DEFAULT NULL );
  -- update
PROCEDURE upd(
    IN_CODE_HEADER_EXPIRE_EFF_DATE IN CODE_HEADER.CODE_HEADER_EXPIRE_EFF_DATE%type DEFAULT NULL ,
    IN_CODE_HEADER_NAME            IN CODE_HEADER.CODE_HEADER_NAME%type ,
    IN_CODE_HEADER_EXPIRE_USER     IN CODE_HEADER.CODE_HEADER_EXPIRE_USER%type DEFAULT NULL ,
    IN_CODE_HEADER_EXPIRE_FLAG     IN CODE_HEADER.CODE_HEADER_EXPIRE_FLAG%type DEFAULT NULL ,
    IN_CODE_HEADER_TYPE            IN CODE_HEADER.CODE_HEADER_TYPE%type ,
    IN_CODE_HEADER_DTL_VAL_DEFAULT IN CODE_HEADER.CODE_HEADER_DTL_VAL_DEFAULT%type DEFAULT NULL ,
    IN_CODE_HEADER_DESCRIPTION     IN CODE_HEADER.CODE_HEADER_DESCRIPTION%type DEFAULT NULL ,
    IN_CODE_HEADER_DTL_VAL_SIZE    IN CODE_HEADER.CODE_HEADER_DTL_VAL_SIZE%type DEFAULT NULL );
  -- delete
PROCEDURE del(
    IN_CODE_HEADER_NAME IN CODE_HEADER.CODE_HEADER_NAME%type ,
    IN_CODE_HEADER_TYPE IN CODE_HEADER.CODE_HEADER_TYPE%type );
END CODE_HEADER_tapi;

