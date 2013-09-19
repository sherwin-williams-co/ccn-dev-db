DECLARE

	v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primarykey sys.xmltype;
    v_real_estate_row real_estate%rowtype; 
    
begin
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
		v_real_estate_row.cost_center_code           := :new.cost_center_code;
		v_real_estate_row.category                   := :new.category;
	
	SELECT XMLELEMENT (  "REAL_ESTATE",
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	 "xsi:nonamespaceSchemaLocation" ),
       		XMLForest(
				v_real_estate_row.cost_center_code       cost_center_code
		   ,v_real_estate_row.category               category
        
						)) AS  "result"
			,XMLELEMENT (  "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			 "xsi:nonamespaceSchemaLocation" ),
	       xmlforest(
				v_real_estate_row.cost_center_code       cost_center_code
        
			)) as  "primaryKey",
      ('|' || v_real_estate_row.cost_center_code || '|') tran_id
			INTO v_rowdata
			,v_primarykey,v_transaction_id
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
                , 'REAL_ESTATE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_REAL_ESTATE_UPD');
     --END IF;      
      
END TR_REAL_ESTATE_UPD;
/

