PACKAGE REAL_ESTATE_TAPI
/*********************************************************** 
This package will hold the SQL DEVELOPER generated 
INSERT, UPDATE, and DELETE procedures/functions 
used to process the REAL_ESTATE table	

created : 01/25/2012 tal CCN project
updated : 08/24/2012 tal CCN project
revisions: 

************************************************************/
IS
type REAL_ESTATE_tapi_rec
IS
  record
  (
    CATEGORY REAL_ESTATE.CATEGORY%type ,
    COST_CENTER_CODE REAL_ESTATE.COST_CENTER_CODE%type );
type REAL_ESTATE_tapi_tab
IS
  TABLE OF REAL_ESTATE_tapi_rec;
  -- insert
PROCEDURE ins(
    IN_CATEGORY         IN REAL_ESTATE.CATEGORY%type ,
    IN_COST_CENTER_CODE IN REAL_ESTATE.COST_CENTER_CODE%type );
  -- update
PROCEDURE upd(
    IN_CATEGORY         IN REAL_ESTATE.CATEGORY%type ,
    IN_COST_CENTER_CODE IN REAL_ESTATE.COST_CENTER_CODE%type );
  -- delete
PROCEDURE del(
    IN_COST_CENTER_CODE IN REAL_ESTATE.COST_CENTER_CODE%type );
END REAL_ESTATE_tapi;
/

