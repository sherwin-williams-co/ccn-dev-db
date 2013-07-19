create or replace
TRIGGER "COSTCNTR".tr_store_upd 
BEFORE INSERT or UPDATE ON STORE 
REFERENCING OLD AS old NEW AS new
for each row

DECLARE

	v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primarykey sys.xmltype;
    v_store_row store%rowtype; 
    
begin
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
		v_store_row.cost_center_code           := :new.cost_center_code;
		v_store_row.category                   := :new.category;
		v_store_row.perp_inv_start_date        := :new.perp_inv_start_date;
		v_store_row.classification_code        := :new.classification_code;
		v_store_row.inventory_indicator        := :new.inventory_indicator;
		v_store_row.rural_metro_zone_code      := :new.rural_metro_zone_code;
		v_store_row.selling_store_flag         := :new.selling_store_flag;
	 
	SELECT XMLELEMENT ( "STORE",
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		xmlforest(
				 v_store_row.cost_center_code            cost_center_code
        ,v_store_row.category                    category
				,to_char(v_store_row.perp_inv_start_date, 'yyyymmdd')   perp_inv_start_date
        ,v_store_row.classification_code         classification_code
        ,v_store_row.inventory_indicator         inventory_indicator
        ,v_store_row.rural_metro_zone_code       rural_metro_zone_code
        ,v_store_row.selling_store_flag          selling_store_flag
         
						)) AS "result"
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       xmlforest(
				 v_store_row.cost_center_code            cost_center_code
        			)) AS "primaryKey"
			,('|' || v_store_row.COST_CENTER_CODE ||
			  '|' ) transaction_id					
       			
			INTO v_rowdata
			,v_primarykey
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
                , sysdate
                , 'STORE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_STORE_UPD');
     --END IF;      
      
END TR_STORE_UPD;