create or replace
TRIGGER "COSTCNTR"."TR_HIER_HEAD_UPD" 
BEFORE INSERT OR UPDATE ON HIERARCHY_HEADER
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

	v_transaction_id VARCHAR2(500);
    V_ROWDATA SYS.XMLTYPE;
    v_primaryKey SYS.XMLTYPE;
    v_HI_HEAD_row HIERARCHY_HEADER%ROWTYPE; 
    
BEGIN

v_HI_HEAD_row.HRCHY_HDR_NAME	:=	:NEW.HRCHY_HDR_NAME;
V_HI_HEAD_ROW.HRCHY_HDR_LEVELS	:=	:NEW.HRCHY_HDR_LEVELS;
v_HI_HEAD_row.HRCHY_HDR_DESC	:=	:NEW.HRCHY_HDR_DESC;
	
	SELECT XMLELEMENT ( "HIERARCHY_HEADER",               
	  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
       XMLForest(
v_HI_HEAD_row.HRCHY_HDR_NAME	HRCHY_HDR_NAME
,V_HI_HEAD_ROW.HRCHY_HDR_LEVELS	HRCHY_HDR_LEVELS
,v_HI_HEAD_row.HRCHY_HDR_DESC	HRCHY_HDR_DESC
		)) AS "result"
    ,XMLELEMENT ( "PRIMARY_KEY",               
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
       		XMLForest(
				v_HI_HEAD_row.HRCHY_HDR_NAME		HRCHY_HDR_NAME
			)) AS "PrimaryKey"
			,('|' || v_HI_HEAD_row.HRCHY_HDR_NAME 
				  || '|') transaction_id
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
                , 'HIERARCHY_HEADER'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_HIER_HEAD_UPD');
     --END IF;      
      
END TR_HIER_HEAD_UPD;