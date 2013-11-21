DECLARE

	v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_cost_center_row COST_CENTER%ROWTYPE;
     
    
begin
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
    v_cost_center_row.COST_CENTER_CODE := :NEW.cost_center_code;
		v_cost_center_row.COST_CENTER_NAME := :NEW.COST_CENTER_NAME;
		v_cost_center_row.CATEGORY := :NEW.CATEGORY;
		v_cost_center_row.ENTITY_TYPE := :NEW.ENTITY_TYPE;
		v_cost_center_row.STATEMENT_TYPE := :NEW.STATEMENT_TYPE;
		v_cost_center_row.COUNTRY_CODE := :NEW.COUNTRY_CODE;
		v_cost_center_row.TRANSPORT_TYPE := :NEW.TRANSPORT_TYPE;
		v_cost_center_row.BEGIN_DATE := :NEW.BEGIN_DATE;
		v_cost_center_row.OPEN_DATE := :NEW.OPEN_DATE;
		v_cost_center_row.MOVE_DATE := :NEW.MOVE_DATE;
		v_cost_center_row.CLOSE_DATE := :NEW.CLOSE_DATE;
		v_cost_center_row.FINANCIAL_CLOSE_DATE := :NEW.FINANCIAL_CLOSE_DATE;
		v_cost_center_row.POS_PROG_VER_EFF_DATE := :NEW.POS_PROG_VER_EFF_DATE;
		v_cost_center_row.UPS_ZONE_CODE := :NEW.UPS_ZONE_CODE;
		v_cost_center_row.RPS_ZONE_CODE := :NEW.RPS_ZONE_CODE;
		v_cost_center_row.CURRENCY_CODE := :NEW.CURRENCY_CODE;
		v_cost_center_row.POS_PROG_VER_NBR := :NEW.POS_PROG_VER_NBR;
		v_cost_center_row.LEASE_OWN_CODE := :NEW.LEASE_OWN_CODE;
		v_cost_center_row.MISSION_TYPE_CODE := :NEW.MISSION_TYPE_CODE;
		v_cost_center_row.DUNS_NUMBER := :NEW.DUNS_NUMBER;
		v_cost_center_row.PRI_LOGO_GROUP_IND := :NEW.PRI_LOGO_GROUP_IND;
		v_cost_center_row.SCD_LOGO_GROUP_IND := :NEW.SCD_LOGO_GROUP_IND;
	    v_cost_center_row.BANKING_TYPE := :NEW.BANKING_TYPE;
	    v_cost_center_row.DEPOSIT_BAG_REORDER := :NEW.DEPOSIT_BAG_REORDER;
	    v_cost_center_row.DEPOSIT_TICKET_REORDER := :NEW.DEPOSIT_TICKET_REORDER;
      v_cost_center_row.POP_KIT_CODE := :NEW.POP_KIT_CODE;
      
	    
	SELECT XMLELEMENT (  "COST_CENTER",               
		  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                          "xsi:nonamespaceSchemaLocation" ),
	       xmlforest(
			 v_cost_center_row.COST_CENTER_CODE COST_CENTER_CODE
			,v_cost_center_row.COST_CENTER_NAME COST_CENTER_NAME
			,v_cost_center_row.CATEGORY CATEGORY
			,v_cost_center_row.ENTITY_TYPE ENTITY_TYPE
			,v_cost_center_row.STATEMENT_TYPE STATEMENT_TYPE
			,v_cost_center_row.COUNTRY_CODE COUNTRY_CODE
			,v_cost_center_row.TRANSPORT_TYPE TRANSPORT_TYPE
				,to_char(v_cost_center_row.BEGIN_DATE, 'yyyymmdd')  BEGIN_DATE
				,to_char(v_cost_center_row.OPEN_DATE, 'yyyymmdd')   OPEN_DATE
				,to_char(v_cost_center_row.MOVE_DATE, 'yyyymmdd')   MOVE_DATE
				,to_char(v_cost_center_row.CLOSE_DATE, 'yyyymmdd')  CLOSE_DATE
				,to_char(v_cost_center_row.FINANCIAL_CLOSE_DATE, 'yyyymmdd')   FINANCIAL_CLOSE_DATE
				,to_char(v_cost_center_row.POS_PROG_VER_EFF_DATE, 'yyyymmdd')  POS_PROG_VER_EFF_DATE
			,v_cost_center_row.UPS_ZONE_CODE UPS_ZONE_CODE
			,v_cost_center_row.RPS_ZONE_CODE RPS_ZONE_CODE
			,v_cost_center_row.CURRENCY_CODE CURRENCY_CODE
			,v_cost_center_row.POS_PROG_VER_NBR POS_PROG_VER_NBR
			,v_cost_center_row.LEASE_OWN_CODE LEASE_OWN_CODE
			,v_cost_center_row.MISSION_TYPE_CODE MISSION_TYPE_CODE
			,v_cost_center_row.DUNS_NUMBER DUNS_NUMBER
			,v_cost_center_row.PRI_LOGO_GROUP_IND PRI_LOGO_GROUP_IND
			,v_cost_center_row.SCD_LOGO_GROUP_IND SCD_LOGO_GROUP_IND 
			,v_cost_center_row.BANKING_TYPE BANKING_TYPE
	    	,v_cost_center_row.DEPOSIT_BAG_REORDER DEPOSIT_BAG_REORDER
	    	,v_cost_center_row.DEPOSIT_TICKET_REORDER DEPOSIT_TICKET_REORDER
        ,v_cost_center_row.POP_KIT_CODE POP_KIT_CODE

			)) AS  "result" 
			,XMLELEMENT (  "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			 "xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				v_cost_center_row.COST_CENTER_CODE COST_CENTER_CODE
			)) AS  "primaryKey"
			,('|' || v_cost_center_row.COST_CENTER_CODE ||
			  '|' ) transaction_id					
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
                , 'COST_CENTER'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_COST_CENTER_UPD');
     --END IF;      
      
END tr_cost_center_upd;
/

