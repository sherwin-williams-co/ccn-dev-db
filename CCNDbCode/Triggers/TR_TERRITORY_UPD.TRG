CREATE OR REPLACE TRIGGER "COSTCNTR".TR_TERRITORY_UPD
BEFORE INSERT OR UPDATE ON TERRITORY
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

	v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_territory_row TERRITORY%ROWTYPE;
     
    
BEGIN
/*
	SELECT NVL(MAX(V_TRANSACTION_ID), 0) + 1 
      INTO v_TRANSACTION_ID
      FROM AUDIT_LOG;             
*/
	v_territory_row.territory_sls_mgr_code := :NEW.territory_sls_mgr_code;
            v_territory_row.cost_center_code := :NEW.cost_center_code;
            v_territory_row.home_store := :NEW.home_store;      
            v_territory_row.category := :NEW.category;
            v_territory_row.lease_car_indicator := :NEW.lease_car_indicator;
            v_territory_row.territory_type_busn_code := :NEW.territory_type_busn_code;
     
		
	
	SELECT XMLELEMENT ( "TERRITORY",               
		  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
		 v_territory_row.TERRITORY_SLS_MGR_CODE TERRITORY_SLS_MGR_CODE						
			,v_territory_row.COST_CENTER_CODE COST_CENTER_CODE			
			,v_territory_row.CATEGORY CATEGORY
			,v_territory_row.HOME_STORE HOME_STORE
			,v_territory_row.LEASE_CAR_INDICATOR LEASE_CAR_INDICATOR
			,v_territory_row.TERRITORY_TYPE_BUSN_CODE TERRITORY_TYPE_BUSN_CODE			
			)) AS "result" 
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				v_territory_row.territory_sls_mgr_code territory_sls_mgr_code 
                                ,v_territory_row.cost_center_code cost_center_code
                                ,V_TERRITORY_ROW.CATEGORY CATEGORY
			)) AS "primaryKey"		,
      ('|'||v_territory_row.territory_sls_mgr_code || '|' || v_territory_row.cost_center_code || '|' || V_TERRITORY_ROW.CATEGORY || '|') tran_id
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
                , 'TERRITORY'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_TERRITORY_UPD');
     --END IF;      
      
END TR_TERRITORY_UPD;

