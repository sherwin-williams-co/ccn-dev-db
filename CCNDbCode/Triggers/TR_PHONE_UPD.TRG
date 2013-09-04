create or replace
TRIGGER "COSTCNTR".tr_phone_upd 
before insert or update on phone 
referencing old as old new as new 
for each row

DECLARE

 v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primarykey sys.xmltype;
    v_phone_row PHONE%rowtype; 
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
		v_phone_row.cost_center_code := :new.cost_center_code;
		v_phone_row.phone_number_type := :new.phone_number_type;
		v_phone_row.phone_number := :new.phone_number;
		v_phone_row.phone_area_code := :new.phone_area_code;
	
	SELECT XMLELEMENT ( "PHONE",               
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		xmlforest(
				v_phone_row.cost_center_code cost_center_code
				,v_phone_row.phone_number_type phone_number_type
				,v_phone_row.phone_number phone_number
			)) AS "result"
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				v_phone_row.cost_center_code cost_center_code
				,v_phone_row.phone_number_type phone_number_type
				,V_PHONE_ROW.PHONE_NUMBER PHONE_NUMBER
			)) AS "primaryKey",
      ('|' || v_phone_row.cost_center_code || '|' || v_phone_row.phone_number_type || '|' || V_PHONE_ROW.PHONE_NUMBER) v_tran
			INTO v_rowdata
			,V_PRIMARYKEY
      ,V_TRANSACTION_ID
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
                , sysdate
                , 'PHONE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_PHONE_UPD');
     --END IF;      
      
END  TR_PHONE_UPD;