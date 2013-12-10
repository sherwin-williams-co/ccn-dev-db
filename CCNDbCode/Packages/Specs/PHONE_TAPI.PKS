CREATE OR REPLACE PACKAGE PHONE_tapi
IS
type PHONE_tapi_rec
IS
  record
  (
    phone_number_type  phone.phone_number_type%type ,
    cost_center_code   phone.cost_center_code%type ,
    phone_area_code    phone.phone_area_code%type ,
    phone_number       phone.phone_number%type ,
    phone_extension    phone.phone_extension%type );
type PHONE_tapi_tab
IS
  TABLE OF PHONE_tapi_rec;
  -- insert
PROCEDURE ins(
    in_phone_number_type in phone.phone_number_type%type ,
    in_cost_center_code  in phone.cost_center_code%type ,
    in_phone_area_code   in phone.phone_area_code%type default null  ,
    in_phone_number      in phone.phone_number%type default null  ,
    IN_PHONE_extension   IN PHONE.PHONE_extension%type DEFAULT NULL );
  -- update
PROCEDURE upd(
    IN_PHONE_NUMBER_TYPE IN PHONE.PHONE_NUMBER_TYPE%type ,
    IN_COST_CENTER_CODE  IN PHONE.COST_CENTER_CODE%type ,
    in_phone_area_code   in phone.phone_area_code%type default null  ,
    in_phone_number      in phone.phone_number%type default null  ,
    IN_PHONE_extension   IN PHONE.PHONE_extension%type DEFAULT NULL );
  -- delete
PROCEDURE del(
    IN_COST_CENTER_CODE  IN PHONE.COST_CENTER_CODE%type ,
    IN_PHONE_NUMBER_TYPE IN PHONE.PHONE_NUMBER_TYPE%type );
END PHONE_tapi;

