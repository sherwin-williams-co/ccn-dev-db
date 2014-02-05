CREATE OR REPLACE TRIGGER "COSTCNTR".TR_ADDRESS_OTHER_UPD 
before insert or update on ADDRESS_OTHER 
referencing old as old new as new 
for each row 


DECLARE

    v_transaction_id VARCHAR2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_address_other_row ADDRESS_OTHER%ROWTYPE; 
    
begin

v_address_other_row.COST_CENTER_CODE      := :NEW.COST_CENTER_CODE;
		v_address_other_row.ADDRESS_TYPE      := :NEW.ADDRESS_TYPE;
		v_address_other_row.EFFECTIVE_DATE    := :NEW.EFFECTIVE_DATE;
		v_address_other_row.EXPIRATION_DATE   := :NEW.EXPIRATION_DATE;
		v_address_other_row.ADDRESS_LINE_1    := :NEW.ADDRESS_LINE_1;
		v_address_other_row.ADDRESS_LINE_2    := :NEW.ADDRESS_LINE_2;	
		v_address_other_row.ADDRESS_LINE_3    := :NEW.ADDRESS_LINE_3;
		v_address_other_row.CITY              := :NEW.CITY;
		v_address_other_row.PROVINCE_CODE     := :NEW.PROVINCE_CODE;
    v_address_other_row.STATE_CODE        := :NEW.STATE_CODE;
		v_address_other_row.POSTAL_CODE       := :NEW.POSTAL_CODE;
    v_address_other_row.COUNTRY_CODE      := :NEW.COUNTRY_CODE;
		v_address_other_row.VALID_ADDRESS     := :NEW.VALID_ADDRESS;
    v_address_other_row.COUNTRY_CODE      := :NEW.COUNTRY_CODE;
	
	SELECT XMLELEMENT ( "ADDRESS_OTHER",               
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		XMLForest(
				v_address_other_row.cost_center_code cost_center_code
				,v_address_other_row.ADDRESS_TYPE ADDRESS_TYPE
				,to_char(v_address_other_row.EFFECTIVE_DATE, 'yyyymmdd')  EFFECTIVE_DATE
				,to_char(v_address_other_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE
				,v_address_other_row.ADDRESS_LINE_1 ADDRESS_LINE_1
				,v_address_other_row.ADDRESS_LINE_2 ADDRESS_LINE_2	
				,v_address_other_row.ADDRESS_LINE_3 ADDRESS_LINE_3
				,v_address_other_row.CITY CITY
				,v_address_other_row.PROVINCE_CODE PROVINCE
        ,v_address_other_row.STATE_CODE STATE
				,v_address_other_row.POSTAL_CODE POSTAL_CODE
        ,v_address_other_row.COUNTRY_CODE COUNTRY
				,v_address_other_row.VALID_ADDRESS VALID_ADDRESS
        ,v_address_other_row.COUNTRY_CODE COUNTRY_CODE
			)) AS "result"
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				v_address_other_row.cost_center_code cost_center_code
				,v_address_other_row.ADDRESS_TYPE ADDRESS_TYPE
				,v_address_other_row.EFFECTIVE_DATE EFFECTIVE_DATE
			)) AS "primaryKey"			
			,('|' || v_address_other_row.cost_center_code || 
			'|' || v_address_other_row.ADDRESS_TYPE  || 
      '|' || TO_CHAR(v_address_other_row.EFFECTIVE_DATE,'DD-MON-YY') || '|') transaction_id
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
                , 'ADDRESS_OTHER'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_ADDRESS_OTH_UPD');
     --END IF;      
     

end  TR_ADDRESS_OTHER_UPD;

