DECLARE

    v_transaction_id VARCHAR2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_address_USA_row ADDRESS_USA%ROWTYPE; 
    
begin

    v_address_usa_row.COST_CENTER_CODE  := :NEW.COST_CENTER_CODE;
    v_address_usa_row.ADDRESS_TYPE      := :NEW.ADDRESS_TYPE;
    v_address_usa_row.EFFECTIVE_DATE    := :NEW.EFFECTIVE_DATE;
    v_address_usa_row.EXPIRATION_DATE   := :NEW.EXPIRATION_DATE;
    v_address_usa_row.ADDRESS_LINE_1    := :NEW.ADDRESS_LINE_1;
    v_address_usa_row.ADDRESS_LINE_2    := :NEW.ADDRESS_LINE_2;	
    v_address_usa_row.ADDRESS_LINE_3    := :NEW.ADDRESS_LINE_3;
    v_address_usa_row.CITY              := :NEW.CITY;
    v_address_usa_row.STATE_CODE        := :NEW.STATE_CODE;
    v_address_usa_row.ZIP_CODE          := :NEW.ZIP_CODE;
    v_address_usa_Row.ZIP_CODE_4        := :NEW.ZIP_CODE_4;
    v_address_usa_row.COUNTY            := :NEW.COUNTY;
    v_address_usa_row.FIPS_CODE         := :NEW.FIPS_CODE;
    v_address_usa_row.DESTINATION_POINT := :NEW.DESTINATION_POINT;
    v_address_usa_row.CHECK_DIGIT       := :NEW.CHECK_DIGIT;
    v_address_usa_row.VALID_ADDRESS     := :NEW.VALID_ADDRESS;
    v_address_usa_row.COUNTRY_CODE      := :NEW.COUNTRY_CODE;
    
	
	SELECT XMLELEMENT (  "ADDRESS_USA",               
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	 "xsi:nonamespaceSchemaLocation" ),
       		XMLFOREST(
         v_address_usa_row.COST_CENTER_CODE COST_CENTER_CODE
        ,v_address_usa_row.ADDRESS_TYPE ADDRESS_TYPE
        ,to_char(v_address_usa_row.EFFECTIVE_DATE, 'yyyymmdd')  EFFECTIVE_DATE
        ,to_char(v_address_usa_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE
        ,v_address_usa_row.ADDRESS_LINE_1 ADDRESS_LINE_1
        ,v_address_usa_row.ADDRESS_LINE_2 ADDRESS_LINE_2	
        ,v_address_usa_row.ADDRESS_LINE_3 ADDRESS_LINE_3
        ,v_address_usa_row.CITY CITY
        ,v_address_usa_row.STATE_CODE STATE_CODE
        ,v_address_usa_row.ZIP_CODE ZIP_CODE
        ,v_address_usa_row.ZIP_CODE_4 ZIP_CODE_4
        ,v_address_usa_row.COUNTY COUNTY
        ,v_address_usa_row.FIPS_CODE FIPS_CODE
        ,v_address_usa_row.DESTINATION_POINT DESTINATION_POINT
        ,v_address_usa_row.CHECK_DIGIT CHECK_DIGIT
        ,v_address_usa_row.VALID_ADDRESS VALID_ADDRESS
        ,v_address_usa_row.COUNTRY_CODE COUNTRY_CODE
			)) AS  "result"
			,XMLELEMENT (  "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			 "xsi:nonamespaceSchemaLocation" ),
	       XMLFOREST(
				 v_address_usa_row.COST_CENTER_CODE COST_CENTER_CODE
				,v_address_usa_row.ADDRESS_TYPE ADDRESS_TYPE
				,v_address_usa_row.EFFECTIVE_DATE EFFECTIVE_DATE
			)) AS  "primaryKey"
			,('|' || v_address_usa_row.cost_center_code || 
			'|' || v_address_usa_row.ADDRESS_TYPE  || 
			'|' || TO_CHAR(v_address_usa_row.EFFECTIVE_DATE,'DD-MON-YY') || '|') transaction_id
			INTO v_rowdata
			,v_primaryKey
			,v_transaction_id
			FROM DUAL;	



         
     /* -- for   Column -- */
     --IF (:OLD.CATEGORY != :NEW.CATEGORY) THEN
          INSERT INTO audit_log
               (log_id
               , transaction_id
               , transaction_date
               , table_name
               , table_pk_value
               , table_row_data
               , change_by)
          VALUES
               ((SELECT NVL(MAX(LOG_ID), 0) + 1 FROM AUDIT_LOG),
                v_transaction_id
                , SYSDATE
                , 'ADDRESS_USA'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_ADDRESS_USA_UPD');
     --END IF;      
     

end  TR_ADDRESS_USA_UPD;
/

