CREATE OR REPLACE TRIGGER "COSTCNTR".TR_ADMINISTRATION_upd 
before insert or update on ADMINISTRATION 
referencing old as old new as new 
for each row 

DECLARE

    v_transaction_id VARCHAR2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_administration_row ADMINISTRATION%ROWTYPE; 
    
begin

v_administration_row.cost_center_code := :NEW.cost_center_code;
		v_administration_row.CATEGORY := :NEW.CATEGORY;
		v_administration_row.INTERNAL_MAIL_NUMBER := :NEW.INTERNAL_MAIL_NUMBER;
    v_administration_row.ADMIN_COST_CNTR_TYPE := :NEW.ADMIN_COST_CNTR_TYPE;
			
	SELECT XMLELEMENT ( "ADMINISTRATION",               
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		XMLFOREST(
         v_administration_row.COST_CENTER_CODE COST_CENTER_CODE
				,v_administration_row.CATEGORY CATEGORY
				,v_administration_row.INTERNAL_MAIL_NUMBER INTERNAL_MAIL_NUMBER
        ,v_administration_row.ADMIN_COST_CNTR_TYPE ADMIN_COST_CNTR_TYPE
			)) AS "result"
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				v_administration_row.cost_center_code cost_center_code
			)) AS "primaryKey"
			,('|' || v_administration_row.cost_center_code || '|') transaction_id
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
                , 'ADMINISTRATION'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_ADMINISTRATION_UPD');
     --END IF;      
     

end  TR_ADMINISTRATION_UPD;

