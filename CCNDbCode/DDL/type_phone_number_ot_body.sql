create or replace TYPE BODY phone_number_ot AS

CONSTRUCTOR FUNCTION phone_number_ot(IN_COST_CENTER_CODE IN    VARCHAR2,
                                     IN_PHONE_NUMBER_TYPE     IN    VARCHAR2) RETURN SELF AS RESULT
IS
BEGIN
/*****************************************************************************
This is a TYPE that is defined with fields used to generate a CSV file for new selling stores.

This is used by the CCN_BATCH_PROCESS
It has 1 Constructor and 2 Functions

1 - The CONSTRUCTOR FUNCTION address_usa_ot is used to initialize member variables.
2 - The MEMBER FUNCTION print_header_delimited is used to create a Header for the DELIMITER passed
3 - The MEMBER FUNCTION print_values_delimited prints the values with the DELIMITER passed

Created : 05/05/2017 sxp130 - ASP-783 - Include Phone Number in Selling Store E-Mail Notification.

*****************************************************************************/
    SELF.COST_CENTER_CODE := IN_COST_CENTER_CODE;
    BEGIN
        SELECT PHONE_AREA_CODE||PHONE_NUMBER
          INTO SELF.PHONE_NUMBER
      FROM PHONE
     WHERE UPPER(COST_CENTER_CODE) = UPPER(IN_COST_CENTER_CODE)
       AND PHONE_NUMBER_TYPE = IN_PHONE_NUMBER_TYPE;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
    RETURN;
END phone_number_ot;

OVERRIDING MEMBER FUNCTION print_header_delimited(IN_DELIMITER    IN    VARCHAR2) RETURN VARCHAR2
IS
    V_RETURN_VAL VARCHAR2(32000);
BEGIN
    FOR rec IN (SELECT *
                  FROM USER_TYPE_ATTRS
                 WHERE TYPE_NAME = UPPER('PHONE_NUMBER_OT')
                  AND ATTR_NAME  = 'PHONE_NUMBER'
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
    RETURN '"' || PHONE_NUMBER || '"';
END print_values_delimited;
END;