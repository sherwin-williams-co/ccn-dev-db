CREATE OR REPLACE TRIGGER "COSTCNTR".TR_OTHER_UPD
BEFORE  INSERT OR 
UPDATE ON OTHER
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

	v_transaction_id VARCHAR2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;    
    v_OTH_row OTHER%ROWTYPE; 
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
	v_OTH_row.COST_CENTER_CODE	:=	:NEW.COST_CENTER_CODE;
	v_OTH_row.CATEGORY	:=	:NEW.CATEGORY;
	
	SELECT XMLELEMENT ( "OTHER",               
	  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
       XMLForest(
		v_OTH_row.COST_CENTER_CODE	COST_CENTER_CODE
		,v_OTH_row.CATEGORY	CATEGORY
		)) AS "result"
		,XMLELEMENT ( "PrimaryKey",               
 			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
           				  'http://www.oracle.com/Employee.xsd' AS
                   			"xsi:nonamespaceSchemaLocation" ),
        XMLForest(
			v_OTH_row.COST_CENTER_CODE	COST_CENTER_CODE
			,v_OTH_row.CATEGORY	CATEGORY
			)) AS "primaryKey"
			,('|' || v_OTH_row.COST_CENTER_CODE || 
			'|' || v_OTH_row.CATEGORY || '|') transaction_id
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
                , 'OTHER'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_OTHER_UPD');
     --END IF;      
      
END TR_OTHER_UPD;

