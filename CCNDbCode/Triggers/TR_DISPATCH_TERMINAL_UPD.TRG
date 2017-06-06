create or replace TRIGGER TR_DISPATCH_TERMINAL_UPD
/**********************************************************
created : rxa457 -- 4/12/2017
handle Audit Log and POS Data generation for DISPATCH_TERMINAL
**********************************************************/
BEFORE INSERT OR UPDATE ON COSTCNTR.DISPATCH_TERMINAL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
    v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_dispatch_terminal_row dispatch_terminal%ROWTYPE;
BEGIN
    v_dispatch_terminal_row.cost_center_code := :NEW.cost_center_code;
    v_dispatch_terminal_row.home_store := :NEW.home_store;      
    v_dispatch_terminal_row.category := :NEW.category;
    
    SELECT XMLELEMENT ( "DISPATCH_TERMINAL",               
           XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
           XMLForest(v_dispatch_terminal_row.COST_CENTER_CODE COST_CENTER_CODE            
            ,v_dispatch_terminal_row.CATEGORY CATEGORY
            ,v_dispatch_terminal_row.HOME_STORE HOME_STORE
            )) AS "result" 
            ,XMLELEMENT ( "PrimaryKey",               
                  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                  'http://www.oracle.com/Employee.xsd' AS
                                     "xsi:nonamespaceSchemaLocation" ),
            XMLForest(
                                v_dispatch_terminal_row.cost_center_code cost_center_code
                                ,V_dispatch_terminal_ROW.CATEGORY CATEGORY
            )) AS "primaryKey"        ,
            ('|' || v_dispatch_terminal_row.cost_center_code || '|' || V_DISPATCH_TERMINAL_ROW.CATEGORY || '|') tran_id
        INTO V_ROWDATA
        ,v_primaryKey,v_transaction_id
        FROM DUAL;    
      
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
                , 'DISPATCH_TERMINAL'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_DISPATCH_TERMINAL_UPD');


END TR_DISPATCH_TERMINAL_UPD;
