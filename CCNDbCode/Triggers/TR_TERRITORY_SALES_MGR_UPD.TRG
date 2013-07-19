create or replace
TRIGGER "COSTCNTR".TR_TERRITORY_SALES_MGR_UPD
BEFORE INSERT OR UPDATE ON TERRITORY_SALES_MGR
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

	v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_terr_sls_mgr_row TERRITORY_SALES_MGR%ROWTYPE;
     
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
	

         v_terr_sls_mgr_row.territory_sls_mgr_code := :NEW.territory_sls_mgr_code;
                v_terr_sls_mgr_row.gems_employee_id := :NEW.gems_employee_id;
                v_terr_sls_mgr_row.territory_sls_mgr_dad := :NEW.territory_sls_mgr_dad;
                v_terr_sls_mgr_row.effective_date := :NEW.effective_date;
                v_terr_sls_mgr_row.expiration_date := :NEW.expiration_date;     
                v_terr_sls_mgr_row.first_name := :NEW.first_name;
                v_terr_sls_mgr_row.last_name := :NEW.last_name;
                v_terr_sls_mgr_row.middle_initial := :NEW.middle_INITIAL;
                v_terr_sls_mgr_row.territory_sls_mgr_type := :NEW.territory_sls_mgr_type;
	
	SELECT XMLELEMENT ( "TERRITORY_SALES_MGR",               
		  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
			v_terr_sls_mgr_row.territory_sls_mgr_code territory_sls_mgr_code
			,v_terr_sls_mgr_row.gems_employee_id gems_employee_id                              
                        ,v_terr_sls_mgr_row.territory_sls_mgr_dad territory_sls_mgr_dad
				,to_char(v_terr_sls_mgr_row.EFFECTIVE_DATE, 'yyyymmdd')   EFFECTIVE_DATE
				,to_char(v_terr_sls_mgr_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE
                        ,v_terr_sls_mgr_row.first_name first_name
                        ,v_terr_sls_mgr_row.last_name last_name 
                        ,v_terr_sls_mgr_row.middle_initial Middle_initial
                        ,v_terr_sls_mgr_row.territory_sls_mgr_type territory_sls_mgr_type			
			)) AS "result" 
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				V_TERR_SLS_MGR_ROW.TERRITORY_SLS_MGR_CODE TERRITORY_SLS_MGR_CODE
			)) AS "primaryKey"		,
      ('|' || V_TERR_SLS_MGR_ROW.TERRITORY_SLS_MGR_CODE || '|') tran_id
	INTO V_ROWDATA
		,v_primaryKey,v_transaction_id
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
                , 'TERRITORY_SALES_MGR'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_TERRITORY_SALES_MGR_UPD');
     --END IF;      
      
END TR_TERRITORY_SALES_MGR_UPD;