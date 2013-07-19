TRIGGER "COSTCNTR".tr_polling_upd 
before insert or update on polling 
REFERENCING OLD AS OLD NEW AS NEW 
for each row

DECLARE

	v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primarykey sys.xmltype;
    v_polling_row polling%rowtype; 
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/

		v_polling_row.cost_center_code           := :new.cost_center_code;
		v_polling_row.polling_status_code        := :new.polling_status_code;
		v_polling_row.multicast_ind              := :new.multicast_ind;
		v_polling_row.time_zone                  := :new.time_zone;
		v_polling_row.polling_ind                := :new.polling_ind;
		v_polling_row.next_download_block_count  := :new.next_download_block_count;
		v_polling_row.current_flag              := :new.current_flag;
	
	SELECT XMLELEMENT ( "POLLING",
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		XMLFOREST(
				 v_polling_row.cost_center_code           cost_center_code
        ,v_polling_row.polling_status_code        polling_status_code
        ,v_polling_row.multicast_ind              multicast_ind
        ,v_polling_row.time_zone                  time_zone
        ,v_polling_row.polling_ind                polling_ind
        ,v_polling_row.next_download_block_count  next_download_block_count
        
						)) AS "result"
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       xmlforest(
				v_polling_row.cost_center_code cost_center_code
				,v_polling_row.polling_status_code polling_status_code
        
			)) AS "primaryKey",
      ('|' || v_polling_row.cost_center_code || '|' || v_polling_row.polling_status_code || '|') tran_id
			INTO V_ROWDATA
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
                , 'POLLING'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_POLLING_UPD');
     --END IF;      
      
END TR_POLLING_UPD;

