create or replace TYPE BODY address_usa_ot AS

CONSTRUCTOR FUNCTION address_usa_ot(IN_COST_CENTER_CODE IN    VARCHAR2,
                                    IN_ADDRESS_TYPE     IN    VARCHAR2) RETURN SELF AS RESULT
IS
BEGIN
/*****************************************************************************
This is a TYPE that is defined with fields used to generate a CSV file for new selling stores.

This is used by the CCN_BATCH_PROCESS
It has 1 Constructor and 2 Functions

1 - The CONSTRUCTOR FUNCTION address_usa_ot is used to initialize member variables.
2 - The MEMBER FUNCTION print_header_delimited is used to create a Header for the DELIMITER passed
3 - The MEMBER FUNCTION print_values_delimited prints the values with the DELIMITER passed

Created : 09/28/2016 jxc517 CCN Project....
Changed : 04/03/2017 gxg192 Added comments block.
Modified : 07/11/2018 pxa852 CCN Project team...
           updated to select only needed columns for reporting as we added a new field to 
           address_usa table for cleansing process
*****************************************************************************/
    SELF.COST_CENTER_CODE := IN_COST_CENTER_CODE;
    BEGIN
        SELECT COST_CENTER_CODE,
               ADDRESS_TYPE,
               EFFECTIVE_DATE,
               EXPIRATION_DATE,
               ADDRESS_LINE_1,
               ADDRESS_LINE_2,
               ADDRESS_LINE_3,
               CITY,
               STATE_CODE,
               ZIP_CODE,
               ZIP_CODE_4,
               COUNTY,
               FIPS_CODE,
               DESTINATION_POINT,
               CHECK_DIGIT,
               VALID_ADDRESS,
               COUNTRY_CODE
          INTO SELF.COST_CENTER_CODE,
               SELF.ADDRESS_TYPE,
               SELF.EFFECTIVE_DATE,
               SELF.EXPIRATION_DATE,
               SELF.ADDRESS_LINE_1,
               SELF.ADDRESS_LINE_2,
               SELF.ADDRESS_LINE_3,
               SELF.CITY,
               SELF.STATE_CODE,
               SELF.ZIP_CODE,
               SELF.ZIP_CODE_4,
               SELF.COUNTY,
               SELF.FIPS_CODE,
               SELF.DESTINATION_POINT,
               SELF.CHECK_DIGIT,
               SELF.VALID_ADDRESS,
               SELF.COUNTRY_CODE
      FROM ADDRESS_USA
     WHERE UPPER(COST_CENTER_CODE) = UPPER(IN_COST_CENTER_CODE)
       AND ADDRESS_TYPE = IN_ADDRESS_TYPE
       AND EXPIRATION_DATE IS NULL;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
    RETURN;
END address_usa_ot;

OVERRIDING MEMBER FUNCTION print_header_delimited(IN_DELIMITER    IN    VARCHAR2) RETURN VARCHAR2
IS
    V_RETURN_VAL VARCHAR2(32000);
BEGIN
    FOR rec IN (SELECT *
                  FROM USER_TYPE_ATTRS
                 WHERE TYPE_NAME = UPPER('ADDRESS_USA_OT')
                 ORDER BY ATTR_NO) LOOP
        V_RETURN_VAL := V_RETURN_VAL || rec.ATTR_NAME || IN_DELIMITER;
    END LOOP;
    V_RETURN_VAL := TRIM(BOTH IN_DELIMITER FROM V_RETURN_VAL);
    RETURN V_RETURN_VAL;
END print_header_delimited;

OVERRIDING MEMBER FUNCTION print_values_delimited(IN_DELIMITER        IN    VARCHAR2) RETURN VARCHAR2
IS
    V_RETURN_VAL VARCHAR2(32000);
BEGIN
    RETURN '"' || COST_CENTER_CODE || '"' || IN_DELIMITER ||
           '"' || ADDRESS_TYPE || '"' || IN_DELIMITER ||
           '"' || EFFECTIVE_DATE || '"' || IN_DELIMITER ||
           '"' || EXPIRATION_DATE || '"' || IN_DELIMITER ||
           '"' || ADDRESS_LINE_1 || '"' || IN_DELIMITER ||
           '"' || ADDRESS_LINE_2 || '"' || IN_DELIMITER ||
           '"' || ADDRESS_LINE_3 || '"' || IN_DELIMITER ||
           '"' || CITY || '"' || IN_DELIMITER ||
           '"' || STATE_CODE || '"' || IN_DELIMITER ||
           '"' || ZIP_CODE || '"' || IN_DELIMITER ||
           '"' || ZIP_CODE_4 || '"' || IN_DELIMITER ||
           '"' || COUNTY || '"' || IN_DELIMITER ||
           '"' || FIPS_CODE || '"' || IN_DELIMITER ||
           '"' || DESTINATION_POINT || '"' || IN_DELIMITER ||
           '"' || CHECK_DIGIT || '"' || IN_DELIMITER ||
           '"' || VALID_ADDRESS || '"' || IN_DELIMITER ||
           '"' || COUNTRY_CODE || '"';
END print_values_delimited;
END;