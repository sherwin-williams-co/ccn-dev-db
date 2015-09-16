CREATE OR REPLACE TRIGGER TR_BANK_DEP_TICKORD_FTR_UPD
BEFORE INSERT OR UPDATE ON BANK_DEP_TICKORD_FUTURE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE
	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_bank_dep_tickord_ftr_row bank_dep_tickord_future%ROWTYPE;

begin
         v_bank_dep_tickord_ftr_row.BANK_ACCOUNT_NBR         := :NEW.BANK_ACCOUNT_NBR;
         v_bank_dep_tickord_ftr_row.COST_CENTER_CODE         := :NEW.COST_CENTER_CODE;
         v_bank_dep_tickord_ftr_row.DEPOSIT_ORDER_PRIORITY   := :NEW.DEPOSIT_ORDER_PRIORITY;
         v_bank_dep_tickord_ftr_row.DEPOSIT_ORDER_STATUS     := :NEW.DEPOSIT_ORDER_STATUS;
         v_bank_dep_tickord_ftr_row.DEPOSIT_ORDER_SEQ_NBR    := :NEW.DEPOSIT_ORDER_SEQ_NBR;
         v_bank_dep_tickord_ftr_row.EFFECTIVE_DATE           := :NEW.EFFECTIVE_DATE;
         v_bank_dep_tickord_ftr_row.EXPIRATION_DATE          := :NEW.EXPIRATION_DATE;
         v_bank_dep_tickord_ftr_row.LAST_MAINTENANCE_DATE    := :NEW.LAST_MAINTENANCE_DATE;
         v_bank_dep_tickord_ftr_row.LAST_MAINT_USER_ID       := :NEW.LAST_MAINT_USER_ID;
         v_bank_dep_tickord_ftr_row.EXTRACT_DATE             := :NEW.EXTRACT_DATE;
         v_bank_dep_tickord_ftr_row.EXTRACTED_USER_ID        := :NEW.EXTRACTED_USER_ID;
         v_bank_dep_tickord_ftr_row.FUTURE_ID                := :NEW.FUTURE_ID;
	SELECT XMLELEMENT ( "BANK_DEP_TICKORD_FUTURE",               
                      XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                      'http://www.oracle.com/Employee.xsd' AS
                                      "xsi:nonamespaceSchemaLocation" ),
                      XMLFOREST(
                                 v_bank_dep_tickord_ftr_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
                                ,v_bank_dep_tickord_ftr_row.COST_CENTER_CODE COST_CENTER_CODE
                                ,v_bank_dep_tickord_ftr_row.DEPOSIT_ORDER_PRIORITY DEPOSIT_ORDER_PRIORITY
                                ,v_bank_dep_tickord_ftr_row.DEPOSIT_ORDER_STATUS DEPOSIT_ORDER_STATUS
                                ,v_bank_dep_tickord_ftr_row.DEPOSIT_ORDER_SEQ_NBR DEPOSIT_ORDER_SEQ_NBR
                                ,to_char(v_bank_dep_tickord_ftr_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
                                ,to_char(v_bank_dep_tickord_ftr_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
                                ,to_char(v_bank_dep_tickord_ftr_row.LAST_MAINTENANCE_DATE, 'yyyymmdd') LAST_MAINTENANCE_DATE
                                ,v_bank_dep_tickord_ftr_row.LAST_MAINT_USER_ID LAST_MAINT_USER_ID
                                ,to_char(v_bank_dep_tickord_ftr_row.EXTRACT_DATE, 'yyyymmdd') EXTRACT_DATE
                                ,v_bank_dep_tickord_ftr_row.EXTRACTED_USER_ID EXTRACTED_USER_ID
                                )) AS "result", 
                    XMLELEMENT ( "PrimaryKey",               
                                  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                  'http://www.oracle.com/Employee.xsd' AS
                                                  "xsi:nonamespaceSchemaLocation" ),
                                  XMLFOREST(
                                             v_bank_dep_tickord_ftr_row.COST_CENTER_CODE COST_CENTER_CODE
                                            ,v_bank_dep_tickord_ftr_row.FUTURE_ID FUTURE_ID
                                            )) AS "primaryKey"
                                            ,('|' || v_bank_dep_tickord_ftr_row.COST_CENTER_CODE || 
                                              '|' || v_bank_dep_tickord_ftr_row.FUTURE_ID  || '|') transaction_id					
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
                ,'BANK_DEP_TICKORD_FUTURE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_BANK_DEP_TICKORD_FTR_UPD');
     
END TR_BANK_DEP_TICKORD_FTR_UPD;

