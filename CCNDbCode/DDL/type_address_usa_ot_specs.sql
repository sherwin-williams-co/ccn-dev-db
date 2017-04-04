CREATE OR REPLACE TYPE address_usa_ot UNDER address_ot (
/*****************************************************************************
This is a TYPE that is defined with fields used to generate a CSV file for new selling stores.

This is used by the CCN_BATCH_PROCESS
It has 1 Constructor and 2 Functions

1 - The CONSTRUCTOR FUNCTION address_usa_ot is used to initialize member variables.
2 - The MEMBER FUNCTION print_header_delimited is used to create a Header for the DELIMITER passed
3 - The MEMBER FUNCTION print_values_delimited prints the values with the DELIMITER passed

Created : 09/28/2016 jxc517 CCN Project....
Changed : 04/03/2017 gxg192 Added comments block.
*****************************************************************************/
ADDRESS_LINE_1             VARCHAR2(35),
ADDRESS_LINE_2             VARCHAR2(35),
ADDRESS_LINE_3             VARCHAR2(35),
CITY                       VARCHAR2(25),
STATE_CODE                 VARCHAR2(2),
ZIP_CODE                   VARCHAR2(5),
ZIP_CODE_4                 VARCHAR2(4),
COUNTY                     VARCHAR2(30),
FIPS_CODE                  VARCHAR2(10),
DESTINATION_POINT          VARCHAR2(2),
CHECK_DIGIT                VARCHAR2(1),
VALID_ADDRESS              VARCHAR2(1),
COUNTRY_CODE               VARCHAR2(3),

CONSTRUCTOR FUNCTION address_usa_ot(IN_COST_CENTER_CODE IN    VARCHAR2,
                                    IN_ADDRESS_TYPE     IN    VARCHAR2) RETURN SELF AS RESULT,

OVERRIDING MEMBER FUNCTION print_header_delimited(IN_DELIMITER    IN    VARCHAR2) RETURN VARCHAR2,

OVERRIDING MEMBER FUNCTION print_values_delimited(IN_DELIMITER        IN    VARCHAR2) RETURN VARCHAR2
);