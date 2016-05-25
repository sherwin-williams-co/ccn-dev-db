CREATE OR REPLACE TRIGGER TR_ADDRESS_BRB_UPD
BEFORE INSERT OR UPDATE ON ADDRESS_BRB 
REFERENCING OLD AS OLD NEW AS NEW 
FOR EACH ROW 
DECLARE
    v_transaction_id   VARCHAR2(500);
    v_rowdata          SYS.XMLTYPE;
    v_primaryKey       SYS.XMLTYPE;
    v_address_brb_row  ADDRESS_BRB%ROWTYPE;
BEGIN
    v_address_brb_row.COST_CENTER_CODE  := :NEW.COST_CENTER_CODE;
    v_address_brb_row.ADDRESS_TYPE      := :NEW.ADDRESS_TYPE;
    v_address_brb_row.EFFECTIVE_DATE    := :NEW.EFFECTIVE_DATE;
    v_address_brb_row.EXPIRATION_DATE   := :NEW.EXPIRATION_DATE;
    v_address_brb_row.PREMISES          := :NEW.PREMISES;
    v_address_brb_row.AVENUE_LANE       := :NEW.AVENUE_LANE;
    v_address_brb_row.DISTRICT          := :NEW.DISTRICT;
    v_address_brb_row.PARISH            := :NEW.PARISH;
    v_address_brb_row.POSTAL_CODE       := :NEW.POSTAL_CODE;
    v_address_brb_row.VALID_ADDRESS     := :NEW.VALID_ADDRESS;
    v_address_brb_row.COUNTRY_CODE      := :NEW.COUNTRY_CODE;

    SELECT XMLELEMENT("ADDRESS_BRB",
                      XMLATTRIBUTES('http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                    'http://www.oracle.com/Employee.xsd' AS "xsi:nonamespaceSchemaLocation"),
                                     XMLFOREST(v_address_brb_row.COST_CENTER_CODE COST_CENTER_CODE
                                               ,v_address_brb_row.ADDRESS_TYPE ADDRESS_TYPE
                                               ,to_char(v_address_brb_row.EFFECTIVE_DATE, 'yyyymmdd')  EFFECTIVE_DATE
                                               ,to_char(v_address_brb_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE
                                               ,v_address_brb_row.PREMISES PREMISES
                                               ,v_address_brb_row.AVENUE_LANE AVENUE_LANE
                                               ,v_address_brb_row.DISTRICT DISTRICT
                                               ,v_address_brb_row.PARISH PARISH
                                               ,v_address_brb_row.POSTAL_CODE POSTAL_CODE
                                               ,v_address_brb_row.VALID_ADDRESS VALID_ADDRESS
                                               ,v_address_brb_row.COUNTRY_CODE COUNTRY_CODE
                                               )
                                   ) AS "result"
                      ,XMLELEMENT("PrimaryKey",
                                  XMLATTRIBUTES('http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                'http://www.oracle.com/Employee.xsd' AS "xsi:nonamespaceSchemaLocation" ),
                                                XMLForest(v_address_brb_row.COST_CENTER_CODE COST_CENTER_CODE
                                                          ,v_address_brb_row.ADDRESS_TYPE ADDRESS_TYPE
                                                          ,v_address_brb_row.EFFECTIVE_DATE EFFECTIVE_DATE
                                                          )
                                               ) AS "primaryKey"
                      ,('|' || 
                        v_address_brb_row.COST_CENTER_CODE || '|' ||
                        v_address_brb_row.ADDRESS_TYPE  || '|' ||
                        TO_CHAR(v_address_brb_row.EFFECTIVE_DATE,'DD-MON-YY') ||
                        '|') transaction_id
      INTO v_rowdata
           ,v_primaryKey
           ,v_transaction_id
      FROM DUAL;

    INSERT INTO audit_log(log_id
                          ,transaction_id
                          ,transaction_date
                          ,table_name
                          ,table_pk_value
                          ,table_row_data
                          ,change_by)
    VALUES((SELECT NVL(MAX(LOG_ID), 0) + 1 FROM AUDIT_LOG),
           v_transaction_id
           ,SYSDATE
           ,'ADDRESS_BRB'
           ,v_primaryKey
           ,v_rowdata
           ,'TR_ADDRESS_BRB_UPD');
END  TR_ADDRESS_BRB_UPD;


ALTER TRIGGER TR_ADDRESS_BRB_UPD ENABLE;

