create or replace PACKAGE SD_COMMON_TOOLS
/**************************************************************** 
This package will have store drafts specific tools

created : 11/10/2014 jxc517 CCN Project....
changed :
*****************************************************************/
IS

FUNCTION GET_HEX_VALUE_FOR_TRNSCTN_TYP
/******************************************************************
This function will return the hexadecimal conversion of the value passed in
based on the transaction type passed in

created : 11/10/2014 jxc517 CCN Project....
changed :
******************************************************************/
(IN_TRANSACTION_TYPE    IN     VARCHAR2
,IN_AMOUNT              IN     NUMBER) RETURN VARCHAR2;

PROCEDURE GENERATE_FIRST_WEEKDAY
/******************************************************************
This procedure will return the run date for the monthly process which should be
1st business day

Created : 09/05/2017 nxk927 CCN Project....
Changed :
******************************************************************/
;

PROCEDURE GENERATE_SECOND_WEEKDAY
/******************************************************************
This procedure will return the run date for the monthly process which should be 
2nd business day

Created : 02/29/2016 nxk927 CCN Project....
Changed :
******************************************************************/
;

PROCEDURE GET_ADDRESS_RECORD(
/******************************************************************************
  This procedure gets the address details for the cost center passed in

Created : 08/22/2019 akj899 CCNSD-8 CCN Project Team....
Changed :
*******************************************************************************/
IN_COST_CENTER_CODE       IN     VARCHAR2,
OUT_ADDRESS_RECORD        OUT    ADDRESS_VW%ROWTYPE)
;

PROCEDURE GET_PHONE_RECORD(
/******************************************************************************
  This procedure gets the phone details for the cost center passed in

Created : 08/22/2019 akj899 CCNSD-8 CCN Project Team....
Changed :
*******************************************************************************/
IN_COST_CENTER_CODE       IN     VARCHAR2,
OUT_PHONE_RECORD          OUT    CCN_PHONE_INFO_VW%ROWTYPE)
;

PROCEDURE GET_STORE_MANAGER_RECORD(
/******************************************************************************
  This procedure gets the Manager details for the cost center passed in

Created  : 08/22/2019 akj899 CCNSD-8 CCN Project Team....
Modified : 
*******************************************************************************/
IN_COST_CENTER_CODE       IN     VARCHAR2,
OUT_MANAGER_RECORD        OUT    EMPLOYEE_DETAILS%ROWTYPE)
;

END SD_COMMON_TOOLS;