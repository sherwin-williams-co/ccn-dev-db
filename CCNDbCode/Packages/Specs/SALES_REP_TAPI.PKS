CREATE OR REPLACE PACKAGE SALES_REP_tapi
IS
type SALES_REP_tapi_rec
IS
  record
  (
    EXPIRATION_DATE SALES_REP.EXPIRATION_DATE%type ,
    EMPLOYEE_CODE SALES_REP.EMPLOYEE_CODE%type ,
    EFFECTIVE_DATE SALES_REP.EFFECTIVE_DATE%type ,
    MIDDLE_INITIAL SALES_REP.MIDDLE_INITIAL%type ,
    SOCIAL_SECURITY_NUMBER SALES_REP.SOCIAL_SECURITY_NUMBER%type ,
    FIRST_NAME SALES_REP.FIRST_NAME%type ,
    LAST_NAME SALES_REP.LAST_NAME%type ,
    GEMS_EMPLOYEE_ID SALES_REP.GEMS_EMPLOYEE_ID%type );
type SALES_REP_tapi_tab
IS
  TABLE OF SALES_REP_tapi_rec;
  -- insert
PROCEDURE ins(
    IN_EXPIRATION_DATE        IN SALES_REP.EXPIRATION_DATE%type DEFAULT NULL ,
    IN_EMPLOYEE_CODE          IN SALES_REP.EMPLOYEE_CODE%type DEFAULT NULL ,
    IN_EFFECTIVE_DATE         IN SALES_REP.EFFECTIVE_DATE%type DEFAULT NULL ,
    IN_MIDDLE_INITIAL         IN SALES_REP.MIDDLE_INITIAL%type DEFAULT NULL ,
    IN_SOCIAL_SECURITY_NUMBER IN SALES_REP.SOCIAL_SECURITY_NUMBER%type DEFAULT NULL ,
    IN_FIRST_NAME             IN SALES_REP.FIRST_NAME%type DEFAULT NULL ,
    IN_LAST_NAME              IN SALES_REP.LAST_NAME%type DEFAULT NULL ,
    IN_GEMS_EMPLOYEE_ID       IN SALES_REP.GEMS_EMPLOYEE_ID%type );
  -- update
PROCEDURE upd(
    IN_EXPIRATION_DATE        IN SALES_REP.EXPIRATION_DATE%type DEFAULT NULL ,
    IN_EMPLOYEE_CODE          IN SALES_REP.EMPLOYEE_CODE%type DEFAULT NULL ,
    IN_EFFECTIVE_DATE         IN SALES_REP.EFFECTIVE_DATE%type DEFAULT NULL ,
    IN_MIDDLE_INITIAL         IN SALES_REP.MIDDLE_INITIAL%type DEFAULT NULL ,
    IN_SOCIAL_SECURITY_NUMBER IN SALES_REP.SOCIAL_SECURITY_NUMBER%type DEFAULT NULL ,
    IN_FIRST_NAME             IN SALES_REP.FIRST_NAME%type DEFAULT NULL ,
    IN_LAST_NAME              IN SALES_REP.LAST_NAME%type DEFAULT NULL ,
    IN_GEMS_EMPLOYEE_ID       IN SALES_REP.GEMS_EMPLOYEE_ID%type );
  -- delete
PROCEDURE del(
    IN_GEMS_EMPLOYEE_ID IN SALES_REP.GEMS_EMPLOYEE_ID%type );
END SALES_REP_tapi;

