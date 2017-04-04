CREATE OR REPLACE TYPE address_ot AS OBJECT (
/*****************************************************************************
This is a TYPE that is defined with fields used to generate a CSV file for new selling stores.

This is used by the CCN_BATCH_PROCESS
It has 2 Functions

1 - The MEMBER FUNCTION print_header_delimited is used to create a Header for the DELIMITER passed
2 - The MEMBER FUNCTION print_values_delimited prints the values with the DELIMITER passed

Created : 09/28/2016 jxc517 CCN Project....
Changed : 04/03/2017 gxg192 Added comments block.
*****************************************************************************/
COST_CENTER_CODE   VARCHAR2(6),
ADDRESS_TYPE       VARCHAR2(2),
EFFECTIVE_DATE     DATE,
EXPIRATION_DATE    DATE,

MEMBER FUNCTION print_header_delimited(IN_DELIMITER    IN    VARCHAR2) RETURN VARCHAR2,

MEMBER FUNCTION print_values_delimited(IN_DELIMITER        IN    VARCHAR2) RETURN VARCHAR2
) NOT INSTANTIABLE NOT FINAL;