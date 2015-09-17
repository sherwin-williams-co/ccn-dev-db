create or replace TRIGGER TR_BANK_DEP_TICK_FTR_UPD
BEFORE INSERT OR UPDATE ON BANK_DEP_TICK_FUTURE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE
	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_bank_dep_tick_ftr_row bank_dep_tick_future%ROWTYPE;

begin
         v_bank_dep_tick_ftr_row.BANK_ACCOUNT_NBR         := :NEW.BANK_ACCOUNT_NBR;
         v_bank_dep_tick_ftr_row.COST_CENTER_CODE         := :NEW.COST_CENTER_CODE;
         v_bank_dep_tick_ftr_row.DAILY_USE_ACTUAL         := :NEW.DAILY_USE_ACTUAL;
         v_bank_dep_tick_ftr_row.DAILY_USE_OVERRIDE       := :NEW.DAILY_USE_OVERRIDE;
         v_bank_dep_tick_ftr_row.DEP_TKTS_ONHAND_QTY      := :NEW.DEP_TKTS_ONHAND_QTY;
         v_bank_dep_tick_ftr_row.YTD_DEP_TKTS_ORDERED_QTY := :NEW.YTD_DEP_TKTS_ORDERED_QTY;
         v_bank_dep_tick_ftr_row.REORDER_POINT            := :NEW.REORDER_POINT;
         v_bank_dep_tick_ftr_row.REORDER_NUMBER_BKS       := :NEW.REORDER_NUMBER_BKS;
         v_bank_dep_tick_ftr_row.IMAGES_PER_PAGE          := :NEW.IMAGES_PER_PAGE;
         v_bank_dep_tick_ftr_row.NBR_FORMS_PER_BK         := :NEW.NBR_FORMS_PER_BK;
         v_bank_dep_tick_ftr_row.PART_PAPER_PER_FORM      := :NEW.PART_PAPER_PER_FORM;
         v_bank_dep_tick_ftr_row.NBR_DEP_TICKETS_PER_BK   := :NEW.NBR_DEP_TICKETS_PER_BK;
         v_bank_dep_tick_ftr_row.SHEETS_OF_PAPER_PER_BK   := :NEW.SHEETS_OF_PAPER_PER_BK;
         v_bank_dep_tick_ftr_row.EFFECTIVE_DATE           := :NEW.EFFECTIVE_DATE;
         v_bank_dep_tick_ftr_row.EXPIRATION_DATE          := :NEW.EXPIRATION_DATE;
         v_bank_dep_tick_ftr_row.LAST_MAINTENANCE_DATE    := :NEW.LAST_MAINTENANCE_DATE;
         v_bank_dep_tick_ftr_row.LAST_MAINT_USER_ID       := :NEW.LAST_MAINT_USER_ID;
         v_bank_dep_tick_ftr_row.REORDER_SWITCH           := :NEW.REORDER_SWITCH;
         v_bank_dep_tick_ftr_row.LAST_VW_ORDER_DATE       := :NEW.LAST_VW_ORDER_DATE;
         v_bank_dep_tick_ftr_row.FUTURE_ID                := :NEW.FUTURE_ID;
	SELECT XMLELEMENT ( "BANK_DEP_TICK_FUTURE",               
                      XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                      'http://www.oracle.com/Employee.xsd' AS
                                      "xsi:nonamespaceSchemaLocation" ),
                      XMLFOREST(
                                 v_bank_dep_tick_ftr_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
                                ,v_bank_dep_tick_ftr_row.COST_CENTER_CODE COST_CENTER_CODE
                                ,v_bank_dep_tick_ftr_row.DAILY_USE_ACTUAL DAILY_USE_ACTUAL
                                ,v_bank_dep_tick_ftr_row.DAILY_USE_OVERRIDE DAILY_USE_OVERRIDE
                                ,v_bank_dep_tick_ftr_row.DEP_TKTS_ONHAND_QTY DEP_TKTS_ONHAND_QTY
                                ,v_bank_dep_tick_ftr_row.YTD_DEP_TKTS_ORDERED_QTY YTD_DEP_TKTS_ORDERED_QTY
                                ,v_bank_dep_tick_ftr_row.REORDER_POINT REORDER_POINT
                                ,v_bank_dep_tick_ftr_row.REORDER_NUMBER_BKS REORDER_NUMBER_BKS
                                ,v_bank_dep_tick_ftr_row.IMAGES_PER_PAGE IMAGES_PER_PAGE
                                ,v_bank_dep_tick_ftr_row.NBR_FORMS_PER_BK NBR_FORMS_PER_BK
                                ,v_bank_dep_tick_ftr_row.PART_PAPER_PER_FORM PART_PAPER_PER_FORM
                                ,v_bank_dep_tick_ftr_row.NBR_DEP_TICKETS_PER_BK NBR_DEP_TICKETS_PER_BK
                                ,v_bank_dep_tick_ftr_row.SHEETS_OF_PAPER_PER_BK SHEETS_OF_PAPER_PER_BK
                                ,to_char(v_bank_dep_tick_ftr_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
                                ,to_char(v_bank_dep_tick_ftr_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
                                ,to_char(v_bank_dep_tick_ftr_row.LAST_MAINTENANCE_DATE, 'yyyymmdd') LAST_MAINTENANCE_DATE
                                ,v_bank_dep_tick_ftr_row.LAST_MAINT_USER_ID LAST_MAINT_USER_ID
                                ,v_bank_dep_tick_ftr_row.REORDER_SWITCH REORDER_SWITCH
                                ,to_char(v_bank_dep_tick_ftr_row.LAST_VW_ORDER_DATE, 'yyyymmdd') LAST_VW_ORDER_DATE
                                ,v_bank_dep_tick_ftr_row.FUTURE_ID FUTURE_ID
                                )) AS "result", 
                    XMLELEMENT ( "PrimaryKey",               
                                  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                  'http://www.oracle.com/Employee.xsd' AS
                                                  "xsi:nonamespaceSchemaLocation" ),
                                  XMLFOREST(
                                             v_bank_dep_tick_ftr_row.COST_CENTER_CODE COST_CENTER_CODE
                                            ,v_bank_dep_tick_ftr_row.FUTURE_ID FUTURE_ID
                                            )) AS "primaryKey"
                                            ,('|' || v_bank_dep_tick_ftr_row.COST_CENTER_CODE || 
                                              '|' || v_bank_dep_tick_ftr_row.FUTURE_ID  || '|') transaction_id					
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
                ,'BANK_DEP_TICK_FUTURE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_BANK_DEP_TICK_FTR_UPD');
     
END TR_BANK_DEP_TICK_FTR_UPD;