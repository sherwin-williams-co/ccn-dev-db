PACKAGE OTHER_TAPI
/*********************************************************** 
This package will hold the SQL DEVELOPER generated 
INSERT, UPDATE, and DELETE procedures/functions 
used to process the OTHER table	

created : 01/25/2012 tal CCN project
updated : 08/24/2012 tal CCN project
************************************************************/
IS
type OTHER_tapi_rec
IS
  record
  (
    CATEGORY OTHER.CATEGORY%type ,
    COST_CENTER_CODE OTHER.COST_CENTER_CODE%type );
type OTHER_tapi_tab
IS
  TABLE OF OTHER_tapi_rec;
  -- insert
PROCEDURE ins(
    IN_CATEGORY         IN OTHER.CATEGORY%type ,
    IN_COST_CENTER_CODE IN OTHER.COST_CENTER_CODE%type );
  -- update
PROCEDURE upd(
    IN_CATEGORY         IN OTHER.CATEGORY%type ,
    IN_COST_CENTER_CODE IN OTHER.COST_CENTER_CODE%type );
  -- delete
PROCEDURE del(
    IN_COST_CENTER_CODE IN OTHER.COST_CENTER_CODE%type );
END OTHER_tapi;
/

