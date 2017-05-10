create or replace TYPE phone_number_ot UNDER phone_ot (
/*****************************************************************************
This is a TYPE that is defined with fields used to generate a CSV file for new selling stores.

This is used by the CCN_BATCH_PROCESS
It has 1 Constructor and 2 Functions

1 - The CONSTRUCTOR FUNCTION phone_number_ot is used to initialize member variables.
2 - The MEMBER FUNCTION print_header_delimited is used to create a Header for the DELIMITER passed
3 - The MEMBER FUNCTION print_values_delimited prints the values with the DELIMITER passed

Created : 05/05/2017 sxp130 - ASP-783 - Include Phone Number in Selling Store E-Mail Notification.

*****************************************************************************/
PHONE_AREA_CODE               VARCHAR2(35),
PHONE_NUMBER                  VARCHAR2(35),
PHONE_EXTENSION               VARCHAR2(35),


CONSTRUCTOR FUNCTION phone_number_ot(IN_COST_CENTER_CODE IN    VARCHAR2,
                                     IN_PHONE_NUMBER_TYPE     IN    VARCHAR2) RETURN SELF AS RESULT,

OVERRIDING MEMBER FUNCTION print_header_delimited(IN_DELIMITER    IN    VARCHAR2) RETURN VARCHAR2,

OVERRIDING MEMBER FUNCTION print_values_delimited(IN_DELIMITER        IN    VARCHAR2) RETURN VARCHAR2
);
