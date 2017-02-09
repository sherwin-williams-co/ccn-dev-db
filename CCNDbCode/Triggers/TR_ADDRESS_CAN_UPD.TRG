CREATE OR REPLACE TRIGGER COSTCNTR.TR_ADDRESS_CAN_UPD
BEFORE INSERT or UPDATE ON COSTCNTR.ADDRESS_CAN
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_address_can_row ADDRESS_CAN%ROWTYPE; 
    
begin

		v_address_can_row.cost_center_code  := :NEW.cost_center_code;
		v_address_can_row.ADDRESS_TYPE      := :NEW.ADDRESS_TYPE;
    v_address_can_row.EFFECTIVE_DATE    := :NEW.EFFECTIVE_DATE;
    v_address_can_row.EXPIRATION_DATE   := :NEW.EXPIRATION_DATE;
		v_address_can_row.ADDRESS_LINE_1    := :NEW.ADDRESS_LINE_1;
		v_address_can_row.ADDRESS_LINE_2    := :NEW.ADDRESS_LINE_2;	
		v_address_can_row.ADDRESS_LINE_3    := :NEW.ADDRESS_LINE_3;
		v_address_can_row.CITY              := :NEW.CITY;
		v_address_can_row.PROVINCE_CODE     := :NEW.PROVINCE_CODE;
		v_address_can_row.POSTAL_CODE       := :NEW.POSTAL_CODE;
		v_address_can_row.VALID_ADDRESS     := :NEW.VALID_ADDRESS;
    v_address_can_row.COUNTRY_CODE      := :NEW.COUNTRY_CODE;
	
	SELECT XMLELEMENT ( "ADDRESS_CAN",               
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		XMLForest(
				 v_address_can_row.COST_CENTER_CODE COST_CENTER_CODE
				,v_address_can_row.ADDRESS_TYPE ADDRESS_TYPE
				,to_char(v_address_can_row.EFFECTIVE_DATE, 'yyyymmdd')   EFFECTIVE_DATE
				,to_char(v_address_can_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE
				,v_address_can_row.ADDRESS_LINE_1 ADDRESS_LINE_1
				,v_address_can_row.ADDRESS_LINE_2 ADDRESS_LINE_2	
				,v_address_can_row.ADDRESS_LINE_3 ADDRESS_LINE_3
				,v_address_can_row.CITY CITY
				,v_address_can_row.PROVINCE_CODE PROVINCE_CODE
				,v_address_can_row.POSTAL_CODE POSTAL_CODE
				,v_address_can_row.VALID_ADDRESS VALID_ADDRESS
        ,v_address_can_row.COUNTRY_CODE COUNTRY_CODE
			)) AS "result"
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       xmlforest(
				 v_address_can_row.COST_CENTER_CODE COST_CENTER_CODE
				,v_address_can_row.ADDRESS_TYPE     ADDRESS_TYPE  
				,v_address_can_row.EFFECTIVE_DATE   EFFECTIVE_DATE
			)) AS "primaryKey"
			,('|' || v_address_can_row.cost_center_code || 
			'|' || v_address_can_row.ADDRESS_TYPE  || 
			'|' || TO_CHAR(v_address_can_row.EFFECTIVE_DATE,'DD-MON-YY') || '|') transaction_id
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
                , 'ADDRESS_CAN'
                ,v_primaryKey
                ,V_ROWDATA
                ,'TR_ADDRESS_CAN_UPD');
     --END IF;
IF POS_DATA_GENERATION.CHECK_COST_CENTER_CATEGORY(v_address_can_row.COST_CENTER_CODE)='S' THEN     
IF INSERTING THEN
        POS_DATA_GENERATION.POS_TRG_EVENT_LOG(IN_COST_CENTER_CODE=>v_address_can_row.COST_CENTER_CODE,IN_DATA_SOURCE=>'ADDRESS_CAN',IN_DATA_OPERATION=>'ADD',IN_FILE_TYPE=>'POS_STORE_UPDATE');    
ELSIF UPDATING THEN
   IF NVL(:OLD.ADDRESS_LINE_1,'XXX') <> NVL(:NEW.ADDRESS_LINE_1,'XXX') OR
      NVL(:OLD.ADDRESS_LINE_2,'XXX') <> NVL(:NEW.ADDRESS_LINE_2,'XXX') OR
      NVL(:OLD.ADDRESS_LINE_3,'XXX') <> NVL(:NEW.ADDRESS_LINE_3,'XXX') OR
      NVL(:OLD.CITY,'XXX')           <> NVL(:NEW.CITY,'XXX')           OR
      NVL(:OLD.POSTAL_CODE,'XXX')    <> NVL(:NEW.POSTAL_CODE,'XXX')
   THEN
      POS_DATA_GENERATION.POS_TRG_EVENT_LOG(IN_COST_CENTER_CODE=>v_address_can_row.COST_CENTER_CODE,IN_DATA_SOURCE=>'ADDRESS_CAN',IN_DATA_OPERATION=>'CHANGE',IN_FILE_TYPE=>'POS_STORE_UPDATE');
   END IF;
END IF;
END IF;
EXCEPTION
WHEN OTHERS THEN
ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE, 'TR_ADDRESS_CAN_UPD', SQLERRM, v_address_can_row.COST_CENTER_CODE);
END TR_ADDRESS_CAN_UPD;