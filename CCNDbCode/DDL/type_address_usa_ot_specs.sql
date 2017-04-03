CREATE OR REPLACE TYPE address_usa_ot UNDER address_ot (
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