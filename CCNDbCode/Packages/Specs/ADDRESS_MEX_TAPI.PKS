CREATE OR REPLACE PACKAGE ADDRESS_MEX_tapi
/*********************************************************** 
This package will hold the SQL DEVELOPER generated 
INSERT, UPDATE, and DELETE procedures/functions 
used to process the ADDRESS_MEX table	

created : 01/25/2012 tal CCN project
revisions: 

************************************************************/
IS
type ADDRESS_MEX_tapi_rec
IS
  record
  (
    EXPIRATION_DATE ADDRESS_MEX.EXPIRATION_DATE%type ,
    EFFECTIVE_DATE ADDRESS_MEX.EFFECTIVE_DATE%type ,
    VALID_ADDRESS ADDRESS_MEX.VALID_ADDRESS%type ,
    COST_CENTER_CODE ADDRESS_MEX.COST_CENTER_CODE%type ,
    ADDRESS_TYPE ADDRESS_MEX.ADDRESS_TYPE%type ,
    POSTAL_CODE ADDRESS_MEX.POSTAL_CODE%type ,
    CITY ADDRESS_MEX.CITY%type ,
    PROVINCE_CODE ADDRESS_MEX.PROVINCE_CODE%type ,
    ADDRESS_LINE_3 ADDRESS_MEX.ADDRESS_LINE_3%type ,
    ADDRESS_LINE_2 ADDRESS_MEX.ADDRESS_LINE_2%type ,
    ADDRESS_LINE_1 ADDRESS_MEX.ADDRESS_LINE_1%type );
type ADDRESS_MEX_tapi_tab
IS
  TABLE OF ADDRESS_MEX_tapi_rec;
  -- insert
PROCEDURE ins(
    IN_EXPIRATION_DATE  IN ADDRESS_MEX.EXPIRATION_DATE%type DEFAULT NULL ,
    IN_EFFECTIVE_DATE   IN ADDRESS_MEX.EFFECTIVE_DATE%type ,
    IN_VALID_ADDRESS    IN ADDRESS_MEX.VALID_ADDRESS%type DEFAULT NULL ,
    IN_COST_CENTER_CODE IN ADDRESS_MEX.COST_CENTER_CODE%type ,
    IN_ADDRESS_TYPE     IN ADDRESS_MEX.ADDRESS_TYPE%type ,
    IN_POSTAL_CODE      IN ADDRESS_MEX.POSTAL_CODE%type DEFAULT NULL ,
    IN_CITY             IN ADDRESS_MEX.CITY%type DEFAULT NULL ,
    IN_PROVINCE_CODE    IN ADDRESS_MEX.PROVINCE_CODE%type DEFAULT NULL ,
    IN_ADDRESS_LINE_3   IN ADDRESS_MEX.ADDRESS_LINE_3%type DEFAULT NULL ,
    IN_ADDRESS_LINE_2   IN ADDRESS_MEX.ADDRESS_LINE_2%type DEFAULT NULL ,
    IN_ADDRESS_LINE_1   IN ADDRESS_MEX.ADDRESS_LINE_1%type DEFAULT NULL );
  -- update
PROCEDURE upd(
    IN_EXPIRATION_DATE  IN ADDRESS_MEX.EXPIRATION_DATE%type DEFAULT NULL ,
    IN_EFFECTIVE_DATE   IN ADDRESS_MEX.EFFECTIVE_DATE%type ,
    IN_VALID_ADDRESS    IN ADDRESS_MEX.VALID_ADDRESS%type DEFAULT NULL ,
    IN_COST_CENTER_CODE IN ADDRESS_MEX.COST_CENTER_CODE%type ,
    IN_ADDRESS_TYPE     IN ADDRESS_MEX.ADDRESS_TYPE%type ,
    IN_POSTAL_CODE      IN ADDRESS_MEX.POSTAL_CODE%type DEFAULT NULL ,
    IN_CITY             IN ADDRESS_MEX.CITY%type DEFAULT NULL ,
    IN_PROVINCE_CODE    IN ADDRESS_MEX.PROVINCE_CODE%type DEFAULT NULL ,
    IN_ADDRESS_LINE_3   IN ADDRESS_MEX.ADDRESS_LINE_3%type DEFAULT NULL ,
    IN_ADDRESS_LINE_2   IN ADDRESS_MEX.ADDRESS_LINE_2%type DEFAULT NULL ,
    IN_ADDRESS_LINE_1   IN ADDRESS_MEX.ADDRESS_LINE_1%type DEFAULT NULL );
  -- delete
PROCEDURE del(
    IN_ADDRESS_TYPE     IN ADDRESS_MEX.ADDRESS_TYPE%type ,
    IN_EFFECTIVE_DATE   IN ADDRESS_MEX.EFFECTIVE_DATE%type ,
    IN_COST_CENTER_CODE IN ADDRESS_MEX.COST_CENTER_CODE%type );
END ADDRESS_MEX_tapi;

