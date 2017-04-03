CREATE OR REPLACE TYPE BODY address_can_ot AS

CONSTRUCTOR FUNCTION address_can_ot(IN_COST_CENTER_CODE IN    VARCHAR2,
                                    IN_ADDRESS_TYPE     IN    VARCHAR2) RETURN SELF AS RESULT
IS
BEGIN
    SELF.COST_CENTER_CODE := IN_COST_CENTER_CODE;
    BEGIN
        SELECT *
          INTO SELF.COST_CENTER_CODE,
               SELF.ADDRESS_TYPE,
               SELF.EFFECTIVE_DATE,
               SELF.EXPIRATION_DATE,
               SELF.ADDRESS_LINE_1,
               SELF.ADDRESS_LINE_2,
               SELF.ADDRESS_LINE_3,
               SELF.CITY,
               SELF.PROVINCE_CODE,
               SELF.POSTAL_CODE,
               SELF.VALID_ADDRESS,
               SELF.COUNTRY_CODE
      FROM ADDRESS_CAN
     WHERE UPPER(COST_CENTER_CODE) = UPPER(IN_COST_CENTER_CODE)
       AND ADDRESS_TYPE = IN_ADDRESS_TYPE
       AND EXPIRATION_DATE IS NULL;
    EXCEPTION
        WHEN OTHERS THEN
            NULL;
    END;
    RETURN;
END address_can_ot;

OVERRIDING MEMBER FUNCTION print_header_delimited(IN_DELIMITER    IN    VARCHAR2) RETURN VARCHAR2
IS
    V_RETURN_VAL VARCHAR2(32000);
BEGIN
    FOR rec IN (SELECT *
                  FROM USER_TYPE_ATTRS
                 WHERE TYPE_NAME = UPPER('ADDRESS_CAN_OT')
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
           '"' || PROVINCE_CODE || '"' || IN_DELIMITER ||
           '"' || POSTAL_CODE || '"' || IN_DELIMITER ||
           '"' || VALID_ADDRESS || '"' || IN_DELIMITER ||
           '"' || COUNTRY_CODE || '"';
END print_values_delimited;
END;