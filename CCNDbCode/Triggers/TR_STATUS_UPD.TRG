create or replace
TRIGGER "COSTCNTR".tr_status_upd 
before insert or update on status 
referencing old as old new as new
for each row

DECLARE

	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primarykey sys.xmltype;
    v_status_row status%rowtype; 
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;            
      */

		v_status_row.cost_center_code           := :new.cost_center_code;
		v_status_row.status_code                := :new.status_code;
		v_status_row.effective_date             := :new.effective_date;
		v_status_row.expiration_date            := :new.expiration_date;
	
	SELECT XMLELEMENT ( "STATUS",
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		xmlforest(
				 v_status_row.cost_center_code           cost_center_code
        ,v_status_row.status_code                status_code
				,to_char(v_status_row.EFFECTIVE_DATE, 'yyyymmdd')   EFFECTIVE_DATE
				,to_char(v_status_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE
        
						)) AS "result"
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       xmlforest(
				 v_status_row.cost_center_code           cost_center_code
        ,v_status_row.status_code                status_code
        ,v_status_row.effective_date             effective_date
        
			)) AS "primaryKey",
      ('|' || v_status_row.cost_center_code || '|' || v_status_row.status_code || '|' || v_status_row.effective_date || '|') tran_id
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
                , 'STATUS'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_STATUS_UPD');
     --END IF;      
      
END TR_STATUS_UPD;