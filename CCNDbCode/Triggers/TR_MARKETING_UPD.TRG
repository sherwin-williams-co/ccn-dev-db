create or replace TRIGGER "COSTCNTR"."TR_MARKETING_UPD" 
BEFORE INSERT OR UPDATE ON MARKETING
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

	v_transaction_id VARCHAR2(500);
    V_ROWDATA SYS.XMLTYPE;
    v_primaryKey SYS.XMLTYPE;
    v_MARK_row MARKETING%ROWTYPE; 
    
BEGIN

		v_MARK_row.COST_CENTER_CODE	:=	:NEW.COST_CENTER_CODE;
		v_MARK_row.CATEGORY	:=	:NEW.CATEGORY;
		v_MARK_row.MARKETING_TYPE	:=	:NEW.MARKETING_TYPE;
		v_MARK_row.EFFECTIVE_DATE	:=	:NEW.EFFECTIVE_DATE;
		v_MARK_row.EXPIRATION_DATE	:=	:NEW.EXPIRATION_DATE;
		v_MARK_row.MKT_BRAND	:=	:NEW.MKT_BRAND;
		v_MARK_row.MKT_MISSION	:=	:NEW.MKT_MISSION;
		v_MARK_row.MKT_SALES_FLOOR_SIZE	:=	:NEW.MKT_SALES_FLOOR_SIZE;
		V_MARK_ROW.MKT_WAREHOUSE_SIZE	:=	:NEW.MKT_WAREHOUSE_SIZE;
		v_MARK_row.MKT_REAL_ESTATE_SETTING	:=	:NEW.MKT_REAL_ESTATE_SETTING;
        v_MARK_row.TOTAL_SQ_FT	:=	:NEW.TOTAL_SQ_FT;
		V_MARK_ROW.SALES_SQ_FT	:=	:NEW.SALES_SQ_FT;
		v_MARK_row.WAREHOUSE_SQ_FT	:=	:NEW.WAREHOUSE_SQ_FT;
	
	SELECT XMLELEMENT ( "MARKETING",               
	  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
       XMLForest(
		v_MARK_row.COST_CENTER_CODE	COST_CENTER_CODE
		,v_MARK_row.CATEGORY	CATEGORY
		,v_MARK_row.MARKETING_TYPE	MARKETING_TYPE
  	,to_char(v_MARK_row.EFFECTIVE_DATE, 'yyyymmdd')  EFFECTIVE_DATE
		,to_char(v_MARK_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE
		,v_MARK_row.MKT_BRAND	MKT_BRAND
		,v_MARK_row.MKT_MISSION	MKT_MISSION
		,v_MARK_row.MKT_SALES_FLOOR_SIZE	MKT_SALES_FLOOR_SIZE
		,V_MARK_ROW.MKT_WAREHOUSE_SIZE	MKT_WAREHOUSE_SIZE
		,v_MARK_row.MKT_REAL_ESTATE_SETTING	MKT_REAL_ESTATE_SETTING
        ,v_MARK_row.TOTAL_SQ_FT TOTAL_SQ_FT
        ,V_MARK_ROW.SALES_SQ_FT SALES_SQ_FT
        ,v_MARK_row.WAREHOUSE_SQ_FT WAREHOUSE_SQ_FT
		)) AS "result"
	 ,XMLELEMENT ( "PrimaryKey",               
	  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
       XMLForest(
		v_MARK_row.COST_CENTER_CODE	COST_CENTER_CODE
		,v_MARK_row.CATEGORY	CATEGORY
		,v_MARK_row.MARKETING_TYPE	MARKETING_TYPE
    ,v_MARK_row.EFFECTIVE_DATE  EFFECTIVE_DATE
		)) AS "Primary_key"	
			,('|' || v_MARK_row.COST_CENTER_CODE || 
			'|' || v_MARK_row.CATEGORY  || 
			'|' || v_MARK_row.MARKETING_TYPE ||
      '|' || TO_CHAR(v_MARK_row.EFFECTIVE_DATE,'DD-MON-YY') || '|') transaction_id
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
                , 'MARKETING'
                , v_primaryKey--:NEW.COST_CENTER_CODE || ',' || :NEW.CATEGORY || ',' || :NEW.MARKETING_TYPE
                ,v_rowdata
                ,'TR_MARKETING_UPD');
     --END IF;      
      
END TR_MARKETING_UPD;