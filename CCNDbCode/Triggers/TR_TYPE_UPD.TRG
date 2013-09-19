DECLARE

	v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_TYPE_row TYPE%ROWTYPE;
     
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
	v_TYPE_row.COST_CENTER_CODE := :NEW.COST_CENTER_CODE;
        v_TYPE_row.TYPE_CODE := :NEW.TYPE_CODE;
        v_TYPE_row.EFFECTIVE_DATE := :NEW.EFFECTIVE_DATE;
        v_TYPE_row.EXPIRATION_DATE := :NEW.EXPIRATION_DATE;
    
		
	
	SELECT XMLELEMENT (  "TYPE",               
		  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                          "xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
			v_type_row.COST_CENTER_CODE COST_CENTER_CODE
			 ,v_TYPE_row.TYPE_code TYPE_CODE
				,to_char(v_TYPE_row.EFFECTIVE_DATE, 'yyyymmdd')   EFFECTIVE_DATE
				,to_char(v_TYPE_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE		
			)) AS  "result" 
			,XMLELEMENT (  "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			 "xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				v_TYPE_row.COST_CENTER_CODE COST_CENTER_CODE
				,v_TYPE_row.TYPE_CODE TYPE_CODE
				,v_TYPE_row.EFFECTIVE_DATE EFFECTIVE_DATE
			)) AS  "primaryKey"		,
      ('|' || v_TYPE_row.COST_CENTER_CODE || 
       '|' || v_TYPE_row.TYPE_CODE || --'|') tran_id
       '|' || TO_CHAR(v_TYPE_row.EFFECTIVE_DATE,'DD-MON-YY') || '|') tran_id
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
                , 'TYPE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_TYPE_UPD');
     --END IF;      
      
END TR_TYPE_UPD;
/

