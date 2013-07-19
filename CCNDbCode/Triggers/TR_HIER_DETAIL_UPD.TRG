create or replace
TRIGGER "COSTCNTR"."TR_HIER_DETAIL_UPD" 
BEFORE INSERT OR UPDATE ON HIERARCHY_DETAIL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

	V_TRANSACTION_ID VARCHAR2(500);
  v_key VARCHAR2(500);
    V_ROWDATA SYS.XMLTYPE;
    v_primaryKey sys.xmltype;
    v_HI_DET_row HIERARCHY_DETAIL%ROWTYPE; 
    
BEGIN

/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             */

v_HI_DET_row.HRCHY_HDR_NAME	:=	:NEW.HRCHY_HDR_NAME;
v_HI_DET_row.HRCHY_DTL_LEVEL	:=	:NEW.HRCHY_DTL_LEVEL;
v_HI_DET_row.HRCHY_DTL_PREV_LVL_VAL	:=	:NEW.HRCHY_DTL_PREV_LVL_VAL;
v_HI_DET_row.HRCHY_DTL_CURR_LVL_VAL	:=	:NEW.HRCHY_DTL_CURR_LVL_VAL;
v_HI_DET_row.HRCHY_DTL_NEXT_LVL_VAL	:=	:NEW.HRCHY_DTL_NEXT_LVL_VAL;
v_HI_DET_row.HRCHY_DTL_EFF_DATE	:=	:NEW.HRCHY_DTL_EFF_DATE;
V_HI_DET_ROW.HRCHY_DTL_EXP_DATE	:=	:NEW.HRCHY_DTL_EXP_DATE;
v_HI_DET_row.HRCHY_DTL_DESC	:=	:NEW.HRCHY_DTL_DESC;
	
	SELECT XMLELEMENT ( "HIERARCHY_DETAIL",               
	  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
       XMLFOREST(
 v_HI_DET_row.HRCHY_HDR_NAME	HRCHY_HDR_NAME
,v_HI_DET_row.HRCHY_DTL_LEVEL	HRCHY_DTL_LEVEL
,v_HI_DET_row.HRCHY_DTL_PREV_LVL_VAL	HRCHY_DTL_PREV_LVL_VAL
,v_HI_DET_row.HRCHY_DTL_CURR_LVL_VAL	HRCHY_DTL_CURR_LVL_VAL
,v_HI_DET_row.HRCHY_DTL_NEXT_LVL_VAL	HRCHY_DTL_NEXT_LVL_VAL
,to_char(v_HI_DET_row.HRCHY_DTL_EFF_DATE, 'yyyymmdd')  HRCHY_DTL_EFF_DATE
,to_char(v_HI_DET_row.HRCHY_DTL_EXP_DATE, 'yyyymmdd')  HRCHY_DTL_EXP_DATE
,v_HI_DET_row.HRCHY_DTL_DESC	HRCHY_DTL_DESC
		)) AS "result"
    ,XMLELEMENT ( "PRIMARY_KEY",               
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
       		XMLForest(
				V_HI_DET_ROW.HRCHY_HDR_NAME	HRCHY_HDR_NAME,
v_HI_DET_row.HRCHY_DTL_LEVEL	HRCHY_DTL_LEVEL,
V_HI_DET_ROW.HRCHY_DTL_PREV_LVL_VAL	HRCHY_DTL_PREV_LVL_VAL,
v_HI_DET_row.HRCHY_DTL_CURR_LVL_VAL	HRCHY_DTL_CURR_LVL_VAL,
v_HI_DET_row.HRCHY_DTL_NEXT_LVL_VAL	HRCHY_DTL_NEXT_LVL_VAL,
v_HI_DET_row.HRCHY_DTL_EFF_DATE	HRCHY_DTL_EFF_DATE
			)) AS "PrimaryKey"
	INTO v_rowdata, v_primaryKey
	FROM DUAL;	
      
     /* -- for   Column -- */
     --IF (:OLD.CATEGORY != :NEW.CATEGORY) THEN
     
     v_key:=v_HI_DET_row.HRCHY_HDR_NAME || '|'|| v_HI_DET_row.HRCHY_DTL_LEVEL || '|'|| v_HI_DET_row.HRCHY_DTL_PREV_LVL_VAL || '|' || v_HI_DET_row.HRCHY_DTL_CURR_LVL_VAL || '|'|| v_HI_DET_row.HRCHY_DTL_NEXT_LVL_VAL || '|' || v_HI_DET_row.HRCHY_DTL_EFF_DATE;

          INSERT INTO audit_log
               (log_id
               , transaction_id
               , transaction_date
               , table_name
               , table_pk_value
               , table_row_data
               , change_by)
          VALUES
               ((SELECT NVL(MAX(LOG_ID), 0) + 1 FROM AUDIT_LOG)
                , v_key
                , SYSDATE
                , 'HIERARCHY_DETAIL'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_HIER_DETAIL_UPD');
     --END IF;      
      
END TR_HIER_DETAIL_UPD;