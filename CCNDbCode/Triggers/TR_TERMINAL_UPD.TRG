CREATE OR REPLACE TRIGGER "COSTCNTR".tr_terminal_upd
before insert or  update on terminal
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

	v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_terminal_row TERMINAL%ROWTYPE;
     
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
	  v_terminal_row.COST_CENTER_CODE := :NEW.COST_CENTER_CODE;
		v_terminal_row.POLLING_STATUS_CODE := :NEW.POLLING_STATUS_CODE;
		v_terminal_row.TERMINAL_NUMBER := :NEW.TERMINAL_NUMBER;
		v_terminal_row.EFFECTIVE_DATE := :NEW.EFFECTIVE_DATE;
		v_terminal_row.EXPIRATION_DATE := :NEW.EXPIRATION_DATE;
		v_terminal_row.POS_LAST_TRAN_DATE := :NEW.POS_LAST_TRAN_DATE;
		v_terminal_row.POS_LAST_TRAN_NUMBER := :NEW.POS_LAST_TRAN_NUMBER;
		
	SELECT XMLELEMENT ( "TERMINAL",               
		  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
	       XMLFOREST(
			 v_terminal_row.COST_CENTER_CODE COST_CENTER_CODE
			,v_terminal_row.POLLING_STATUS_CODE POLLING_STATUS_CODE
		  ,v_terminal_row.TERMINAL_NUMBER TERMINAL_NUMBER 
				,to_char(v_terminal_row.EFFECTIVE_DATE, 'yyyymmdd')   EFFECTIVE_DATE
				,to_char(v_terminal_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE
				,to_char(v_terminal_row.POS_LAST_TRAN_DATE, 'yyyymmdd')  POS_LAST_TRAN_DATE
		  ,v_terminal_row.POS_LAST_TRAN_NUMBER POS_LAST_TRAN_NUMBER			
			)) AS "result" 
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				V_TERMINAL_ROW.COST_CENTER_CODE COST_CENTER_CODE
        ,v_terminal_row.EFFECTIVE_DATE   EFFECTIVE_DATE
        ,v_terminal_row.TERMINAL_NUMBER TERMINAL_NUMBER
			)) AS "primaryKey"		,
      ('|' || V_TERMINAL_ROW.COST_CENTER_CODE 
      || '|' || V_TERMINAL_ROW.TERMINAL_NUMBER  || '|'
      || '|' || TO_CHAR(V_TERMINAL_ROW.EFFECTIVE_DATE,'DD-MON-YY')  || '|') tran_id
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
                , 'TERMINAL'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_TERMINAL_UPD');
     --END IF;      
      
END TR_TERMINAL_UPD;

