create or replace
TRIGGER "COSTCNTR".tr_sales_rep_upd 
BEFORE INSERT or UPDATE ON SALES_REP 
referencing old as old new as new 
for each row

DECLARE

	v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primarykey sys.xmltype;
    v_sales_rep_row sales_rep%rowtype; 
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
		v_sales_rep_row.gems_employee_id           := :new.gems_employee_id;
		v_sales_rep_row.social_security_number     := :new.social_security_number;
		v_sales_rep_row.effective_date             := :new.effective_date;
		v_sales_rep_row.expiration_date            := :new.expiration_date;
		v_sales_rep_row.first_name                 := :new.first_name;
		v_sales_rep_row.middle_initial             := :new.middle_initial;
		v_sales_rep_row.last_name                  := :new.last_name;
		v_sales_rep_row.employee_code              := :new.employee_code;
	
	SELECT XMLELEMENT ( "SALES_REP",
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		xmlforest(
				 v_sales_rep_row.gems_employee_id           gems_employee_id
        ,v_sales_rep_row.social_security_number     social_security_number
				,to_char(v_sales_rep_row.EFFECTIVE_DATE, 'yyyymmdd')   EFFECTIVE_DATE
				,to_char(v_sales_rep_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE
        ,v_sales_rep_row.first_name                 first_name
        ,v_sales_rep_row.middle_initial             middle_initial
        ,v_sales_rep_row.last_name                  last_name
        ,v_sales_rep_row.employee_code              employee_code
        
						)) AS "result"
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       xmlforest(
				 v_sales_rep_row.gems_employee_id           gems_employee_id
        
			)) AS "primaryKey",
      ('|'|| v_sales_rep_row.gems_employee_id || '|') tran_id
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
                , 'SALES_REP'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_SALES_REP_UPD');
     --END IF;      
      
END TR_SALES_REP_UPD;