create or replace TYPE phone_ot AS OBJECT (
/*****************************************************************************
This is a TYPE that is defined with fields used to generate a CSV file for new selling stores.

This is used by the CCN_BATCH_PROCESS
It has 2 Functions

1 - The MEMBER FUNCTION print_header_delimited is used to create a Header for the DELIMITER passed
2 - The MEMBER FUNCTION print_values_delimited prints the values with the DELIMITER passed

Created : 05/05/2017 sxp130 - ASP-783 - Include Phone Number in Selling Store E-Mail Notification.

*****************************************************************************/
COST_CENTER_CODE   VARCHAR2(6),
PHONE_NUMBER_TYPE       VARCHAR2(3),

MEMBER FUNCTION print_header_delimited(IN_DELIMITER    IN    VARCHAR2) RETURN VARCHAR2,

MEMBER FUNCTION print_values_delimited(IN_DELIMITER        IN    VARCHAR2) RETURN VARCHAR2
) NOT INSTANTIABLE NOT FINAL;

