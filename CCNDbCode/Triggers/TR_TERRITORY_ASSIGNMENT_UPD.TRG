DECLARE

	v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_terr_assignment_row TERRITORY_ASSIGNMENT%ROWTYPE;
     
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
	
         v_terr_assignment_row.territory_sls_mgr_code := :NEW.territory_sls_mgr_code;
         v_terr_assignment_row.cost_center_code := :NEW.cost_center_code;
         v_terr_assignment_row.category	:= :NEW.category;
         v_terr_assignment_row.gems_employee_id := :NEW.gems_employee_id;    
         v_terr_assignment_row.effective_date := :NEW.effective_date;      
         v_terr_assignment_row.expiration_date := :NEW.expiration_date;
	
	SELECT XMLELEMENT (  "TERRITORY_ASSIGNMENT",               
		  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                          "xsi:nonamespaceSchemaLocation" ),
	       XMLForest(					
		v_terr_assignment_row.TERRITORY_SLS_MGR_CODE TERRITORY_SLS_MGR_CODE  
                          ,v_terr_assignment_row.COST_CENTER_CODE cOST_CENTER_CODE  
                          ,v_terr_assignment_row.CATEGORY CATEGORY
                          ,v_terr_assignment_row.GEMS_EMPLOYEE_ID GEMS_EMPLOYEE_ID
				,to_char(v_terr_assignment_row.EFFECTIVE_DATE, 'yyyymmdd')   EFFECTIVE_DATE
				,to_char(v_terr_assignment_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE 
			)) AS  "result" 
			,XMLELEMENT (  "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			 "xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				v_terr_assignment_row.TERRITORY_SLS_MGR_CODE TERRITORY_SLS_MGR_CODE
				,v_terr_assignment_row.COST_CENTER_CODE COST_CENTER_CODE
				,v_terr_assignment_row.CATEGORY CATEGORY
				,v_terr_assignment_row.GEMS_EMPLOYEE_ID GEMS_EMPLOYEE_ID
				,v_terr_assignment_row.EFFECTIVE_DATE EFFECTIVE_DATE
			)) AS  "primaryKey"		,
      ('|'||V_TERR_ASSIGNMENT_ROW.TERRITORY_SLS_MGR_CODE || 
       '|' || V_TERR_ASSIGNMENT_ROW.COST_CENTER_CODE || 
       '|' || v_terr_assignment_row.CATEGORY || 
       '|' || v_terr_assignment_row.GEMS_EMPLOYEE_ID || '|') tran_id
       --'|' || v_terr_assignment_row.EFFECTIVE_DATE || '|') tran_id
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
                , 'TERRITORY_ASSIGNMENT'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_TERRITORY_ASSIGNMENT_UPD');
     --END IF;      
      
END TR_TERRITORY_ASSIGNMENT_UPD;
/

