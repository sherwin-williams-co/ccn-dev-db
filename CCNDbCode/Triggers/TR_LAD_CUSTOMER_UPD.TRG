create or replace TRIGGER TR_LAD_CUSTOMER_UPD 
BEFORE INSERT or UPDATE ON LAD_CUSTOMER 
referencing old as old new as new 
for each row

DECLARE
    v_transaction_id   varchar2(500);
    v_rowdata          sys.xmltype;
    v_primarykey       sys.xmltype;
    v_lad_customer_row LAD_CUSTOMER%rowtype; 
BEGIN
    v_lad_customer_row.cost_center_code           := :new.cost_center_code;
    v_lad_customer_row.category                   := :new.category;
    v_lad_customer_row.LAD_CUSTOMER_TYPE          := :new.LAD_CUSTOMER_TYPE;
    v_lad_customer_row.ALLOCATION_CC              := :new.ALLOCATION_CC;

    SELECT XMLELEMENT ( "LAD_CUSTOMER",
                       XMLATTRIBUTES ('http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                      'http://www.oracle.com/Employee.xsd' AS "xsi:nonamespaceSchemaLocation" ),
       		XMLForest(v_lad_customer_row.cost_center_code       cost_center_code,
       		          v_lad_customer_row.category               category)) AS "result"
			,XMLELEMENT ( "PrimaryKey",
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       xmlforest(v_lad_customer_row.cost_center_code       cost_center_code)) as "primaryKey",
      ('|' || v_lad_customer_row.cost_center_code || '|') tran_id
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
                , 'LAD_CUSTOMER'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_LAD_CUSTOMER_UPD');
     --END IF;      

END TR_LAD_CUSTOMER_UPD;