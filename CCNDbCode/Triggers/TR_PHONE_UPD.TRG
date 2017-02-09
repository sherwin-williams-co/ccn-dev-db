CREATE OR REPLACE TRIGGER COSTCNTR.TR_PHONE_UPD 
before insert or update ON COSTCNTR.PHONE 
referencing old as old new as new 
for each row
DECLARE

 v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primarykey sys.xmltype;
    v_phone_row PHONE%rowtype; 
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
		v_phone_row.cost_center_code := :new.cost_center_code;
		v_phone_row.phone_number_type := :new.phone_number_type;
		v_phone_row.phone_number := :new.phone_number;
    v_phone_row.phone_area_code := :new.phone_area_code;
    v_phone_row.phone_extension := :new.phone_extension;
	
	SELECT XMLELEMENT ( "PHONE",               
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		xmlforest(
				v_phone_row.cost_center_code cost_center_code
				,v_phone_row.phone_number_type phone_number_type
				,v_phone_row.phone_area_code phone_area_code
				,v_phone_row.phone_number phone_number
        ,v_phone_row.phone_extension phone_extension
			)) AS "result"
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				v_phone_row.cost_center_code cost_center_code
				,v_phone_row.phone_number_type phone_number_type
        ,v_phone_row.phone_area_code phone_area_code --jxc 09182013
				,V_PHONE_ROW.PHONE_NUMBER PHONE_NUMBER  -- kdp 08232013
			)) AS "primaryKey",
      ('|' || v_phone_row.cost_center_code || '|' || v_phone_row.phone_number_type ) v_tran --removed phone number kdp
			INTO v_rowdata
			,V_PRIMARYKEY
      ,V_TRANSACTION_ID
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
                , 'PHONE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_PHONE_UPD');
     --END IF;      
IF POS_DATA_GENERATION.CHECK_COST_CENTER_CATEGORY(v_phone_row.COST_CENTER_CODE)='S' THEN
IF INSERTING THEN
   IF :NEW.PHONE_NUMBER IS NOT NULL THEN
      POS_DATA_GENERATION.POS_TRG_EVENT_LOG(IN_COST_CENTER_CODE=>v_phone_row.COST_CENTER_CODE,IN_DATA_SOURCE=>'PHONE',IN_DATA_OPERATION=>'ADD',IN_FILE_TYPE=>'POS_STORE_UPDATE');
   END IF;
ELSIF UPDATING THEN
   IF NVL(:OLD.PHONE_NUMBER,'XXX') <> NVL(:NEW.PHONE_NUMBER,'XXX') OR
      NVL(:OLD.PHONE_AREA_CODE,'XXX') <> NVL(:NEW.PHONE_AREA_CODE,'XXX')
   THEN
      POS_DATA_GENERATION.POS_TRG_EVENT_LOG(IN_COST_CENTER_CODE=>v_phone_row.COST_CENTER_CODE,IN_DATA_SOURCE=>'PHONE',IN_DATA_OPERATION=>'CHANGE',IN_FILE_TYPE=>'POS_STORE_UPDATE');
   END IF;
END IF;
END IF;
EXCEPTION
WHEN OTHERS THEN
ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE, 'TR_PHONE_UPD', SQLERRM, v_phone_row.COST_CENTER_CODE);
END  TR_PHONE_UPD;