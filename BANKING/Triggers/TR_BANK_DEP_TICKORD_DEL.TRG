CREATE OR REPLACE TRIGGER TR_BANK_DEP_TICKORD_DEL
BEFORE DELETE ON BANK_DEP_TICKORD
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE
	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_bank_dep_tickord_row bank_dep_tickord%ROWTYPE;

begin
         v_bank_dep_tickord_row.BANK_ACCOUNT_NBR         := :OLD.BANK_ACCOUNT_NBR;
         v_bank_dep_tickord_row.COST_CENTER_CODE         := :OLD.COST_CENTER_CODE;
         v_bank_dep_tickord_row.DEPOSIT_ORDER_PRIORITY   := :OLD.DEPOSIT_ORDER_PRIORITY;
         v_bank_dep_tickord_row.DEPOSIT_ORDER_STATUS     := :OLD.DEPOSIT_ORDER_STATUS;
         v_bank_dep_tickord_row.DEPOSIT_ORDER_SEQ_NBR    := :OLD.DEPOSIT_ORDER_SEQ_NBR;
         v_bank_dep_tickord_row.EFFECTIVE_DATE           := :OLD.EFFECTIVE_DATE;
         v_bank_dep_tickord_row.EXPIRATION_DATE          := :OLD.EXPIRATION_DATE;
         v_bank_dep_tickord_row.LAST_MAINTENANCE_DATE    := :OLD.LAST_MAINTENANCE_DATE;
         v_bank_dep_tickord_row.LAST_MAINT_USER_ID       := :OLD.LAST_MAINT_USER_ID;
         v_bank_dep_tickord_row.EXTRACT_DATE             := :OLD.EXTRACT_DATE;
         v_bank_dep_tickord_row.EXTRACTED_USER_ID        := :OLD.EXTRACTED_USER_ID;
	SELECT XMLELEMENT ( "BANK_DEP_TICKORD",               
                      XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                      'http://www.oracle.com/Employee.xsd' AS
                                      "xsi:nonamespaceSchemaLocation" ),
                      XMLFOREST( 'Delete' UPD_TYPE
                                ,v_bank_dep_tickord_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
                                ,v_bank_dep_tickord_row.COST_CENTER_CODE COST_CENTER_CODE
                                ,v_bank_dep_tickord_row.DEPOSIT_ORDER_PRIORITY DEPOSIT_ORDER_PRIORITY
                                ,v_bank_dep_tickord_row.DEPOSIT_ORDER_STATUS DEPOSIT_ORDER_STATUS
                                ,v_bank_dep_tickord_row.DEPOSIT_ORDER_SEQ_NBR DEPOSIT_ORDER_SEQ_NBR
                                ,to_char(v_bank_dep_tickord_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
                                ,to_char(v_bank_dep_tickord_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
                                ,to_char(v_bank_dep_tickord_row.LAST_MAINTENANCE_DATE, 'yyyymmdd') LAST_MAINTENANCE_DATE
                                ,v_bank_dep_tickord_row.LAST_MAINT_USER_ID LAST_MAINT_USER_ID
                                ,to_char(v_bank_dep_tickord_row.EXTRACT_DATE, 'yyyymmdd') EXTRACT_DATE
                                ,v_bank_dep_tickord_row.EXTRACTED_USER_ID EXTRACTED_USER_ID
                                )) AS "result", 
                    XMLELEMENT ( "PrimaryKey",               
                                  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                  'http://www.oracle.com/Employee.xsd' AS
                                                  "xsi:nonamespaceSchemaLocation" ),
                                  XMLFOREST(
                                             v_bank_dep_tickord_row.COST_CENTER_CODE COST_CENTER_CODE
                                            )) AS "primaryKey"
                                            ,('|' || v_bank_dep_tickord_row.COST_CENTER_CODE || '|') transaction_id					
	INTO v_rowdata
      ,v_primaryKey
      ,v_transaction_id
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
                ,SYSDATE
                ,'BANK_DEP_TICKORD'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_BANK_DEP_TICKORD_DEL');
     
END TR_BANK_DEP_TICKORD_DEL;

