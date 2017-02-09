CREATE OR REPLACE TRIGGER COSTCNTR.TR_TAXWARE_UPD 
BEFORE INSERT OR UPDATE ON COSTCNTR.TAXWARE REFERENCING FOR EACH ROW
DECLARE

	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primarykey sys.xmltype;
    v_taxware_row taxware%rowtype; 
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;            
      */

		v_taxware_row.cost_center_code           := :new.cost_center_code;
		v_taxware_row.twj_state                  := :new.twj_state;
		v_taxware_row.twj_zip                    := :new.twj_zip;
		v_taxware_row.twj_geo                    := :new.twj_geo;
    v_taxware_row.twj_maintenance_date       := :new.twj_maintenance_date;
		v_taxware_row.twj_country                := :new.twj_country;
		v_taxware_row.twj_company                := :new.twj_company;
    v_taxware_row.LAST_MAINT_DATE            := :new.LAST_MAINT_DATE;
		v_taxware_row.LAST_MAINT_METHOD_ID       := :new.LAST_MAINT_METHOD_ID;
		v_taxware_row.LAST_MAINT_USER_ID         := :new.LAST_MAINT_USER_ID;
	
	SELECT XMLELEMENT ( "TAXWARE",
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		xmlforest(
				 v_taxware_row.cost_center_code       cost_center_code
        ,v_taxware_row.twj_state              state
        ,v_taxware_row.twj_zip                zip_code
        ,v_taxware_row.twj_geo                geo
				,to_char(v_taxware_row.twj_maintenance_date, 'yyyymmdd')  twj_maintenance_date
        ,v_taxware_row.twj_country            country
        ,v_taxware_row.twj_company            company
				,to_char(v_taxware_row.LAST_MAINT_DATE, 'yyyymmdd')       LAST_MAINT_DATE
        ,v_taxware_row.LAST_MAINT_METHOD_ID   LAST_MAINT_METHOD_ID
        ,v_taxware_row.LAST_MAINT_USER_ID     LAST_MAINT_USER_ID
						)) AS "result"
            
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       xmlforest(
				 v_taxware_row.cost_center_code           cost_center_code                
			)) AS "primaryKey",
      
      ('|' || v_taxware_row.cost_center_code || '|') tran_id
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
                , 'TAXWARE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_TAXWARE_UPD');
     --END IF;     
BEGIN
IF UPDATING THEN
   
   IF POS_DATA_GENERATION.CHECK_COST_CENTER_CATEGORY(v_taxware_row.COST_CENTER_CODE)='S' THEN

      IF
      (
      NVL(:OLD.TWJ_STATE,'XXX')   <> NVL(:NEW.TWJ_STATE,'XXX')   OR
      NVL(:OLD.TWJ_ZIP,'XXX')     <> NVL(:NEW.TWJ_ZIP,'XXX')     OR
      NVL(:OLD.TWJ_GEO,'XXX')     <> NVL(:NEW.TWJ_GEO,'XXX')     OR
      NVL(:OLD.TWJ_COUNTRY,'XXX') <> NVL(:NEW.TWJ_COUNTRY,'XXX') OR
      NVL(:OLD.TWJ_COMPANY,'XXX') <> NVL(:NEW.TWJ_COMPANY,'XXX')
      )
      THEN
      POS_DATA_GENERATION.POS_TRG_EVENT_LOG(v_taxware_row.COST_CENTER_CODE,
                                            'TAXWARE',
                                            'CHANGE',
                                            'POS_STORE_UPDATE'
                                            );
      END IF;

   END IF;

END IF;
EXCEPTION
WHEN OTHERS THEN
ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                           'TR_TAXWARE_UPD',
                           SQLERRM,
                           v_taxware_row.COST_CENTER_CODE
                           );

END;
END TR_TAXWARE_UPD;