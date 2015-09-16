CREATE OR REPLACE TRIGGER TR_BANK_DEP_TICK_DEL
BEFORE DELETE ON BANK_DEP_TICK
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE
	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_bank_dep_tick_row bank_dep_tick%ROWTYPE;

begin
         v_bank_dep_tick_row.BANK_ACCOUNT_NBR         := :OLD.BANK_ACCOUNT_NBR;
         v_bank_dep_tick_row.COST_CENTER_CODE         := :OLD.COST_CENTER_CODE;
         v_bank_dep_tick_row.DAILY_USE_ACTUAL         := :OLD.DAILY_USE_ACTUAL;
         v_bank_dep_tick_row.DAILY_USE_OVERRIDE       := :OLD.DAILY_USE_OVERRIDE;
         v_bank_dep_tick_row.DEP_TKTS_ONHAND_QTY      := :OLD.DEP_TKTS_ONHAND_QTY;
         v_bank_dep_tick_row.YTD_DEP_TKTS_ORDERED_QTY := :OLD.YTD_DEP_TKTS_ORDERED_QTY;
         v_bank_dep_tick_row.REORDER_POINT            := :OLD.REORDER_POINT;
         v_bank_dep_tick_row.REORDER_NUMBER_BKS       := :OLD.REORDER_NUMBER_BKS;
         v_bank_dep_tick_row.IMAGES_PER_PAGE          := :OLD.IMAGES_PER_PAGE;
         v_bank_dep_tick_row.NBR_FORMS_PER_BK         := :OLD.NBR_FORMS_PER_BK;
         v_bank_dep_tick_row.PART_PAPER_PER_FORM      := :OLD.PART_PAPER_PER_FORM;
         v_bank_dep_tick_row.NBR_DEP_TICKETS_PER_BK   := :OLD.NBR_DEP_TICKETS_PER_BK;
         v_bank_dep_tick_row.SHEETS_OF_PAPER_PER_BK   := :OLD.SHEETS_OF_PAPER_PER_BK;
         v_bank_dep_tick_row.EFFECTIVE_DATE           := :OLD.EFFECTIVE_DATE;
         v_bank_dep_tick_row.EXPIRATION_DATE          := :OLD.EXPIRATION_DATE;
         v_bank_dep_tick_row.LAST_MAINTENANCE_DATE    := :OLD.LAST_MAINTENANCE_DATE;
         v_bank_dep_tick_row.LAST_MAINT_USER_ID       := :OLD.LAST_MAINT_USER_ID;
         v_bank_dep_tick_row.REORDER_SWITCH           := :OLD.REORDER_SWITCH;
         v_bank_dep_tick_row.LAST_VW_ORDER_DATE       := :OLD.LAST_VW_ORDER_DATE;
         
	SELECT XMLELEMENT ( "BANK_DEP_TICK",               
                      XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                      'http://www.oracle.com/Employee.xsd' AS
                                      "xsi:nonamespaceSchemaLocation" ),
                      XMLFOREST( 'Delete' UPD_TYPE
                                ,v_bank_dep_tick_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
                                ,v_bank_dep_tick_row.COST_CENTER_CODE COST_CENTER_CODE
                                ,v_bank_dep_tick_row.DAILY_USE_ACTUAL DAILY_USE_ACTUAL
                                ,v_bank_dep_tick_row.DAILY_USE_OVERRIDE DAILY_USE_OVERRIDE
                                ,v_bank_dep_tick_row.DEP_TKTS_ONHAND_QTY DEP_TKTS_ONHAND_QTY
                                ,v_bank_dep_tick_row.YTD_DEP_TKTS_ORDERED_QTY YTD_DEP_TKTS_ORDERED_QTY
                                ,v_bank_dep_tick_row.REORDER_POINT REORDER_POINT
                                ,v_bank_dep_tick_row.REORDER_NUMBER_BKS REORDER_NUMBER_BKS
                                ,v_bank_dep_tick_row.IMAGES_PER_PAGE IMAGES_PER_PAGE
                                ,v_bank_dep_tick_row.NBR_FORMS_PER_BK NBR_FORMS_PER_BK
                                ,v_bank_dep_tick_row.PART_PAPER_PER_FORM PART_PAPER_PER_FORM
                                ,v_bank_dep_tick_row.NBR_DEP_TICKETS_PER_BK NBR_DEP_TICKETS_PER_BK
                                ,v_bank_dep_tick_row.SHEETS_OF_PAPER_PER_BK SHEETS_OF_PAPER_PER_BK
                                ,to_char(v_bank_dep_tick_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
                                ,to_char(v_bank_dep_tick_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
                                ,to_char(v_bank_dep_tick_row.LAST_MAINTENANCE_DATE, 'yyyymmdd') LAST_MAINTENANCE_DATE
                                ,v_bank_dep_tick_row.LAST_MAINT_USER_ID LAST_MAINT_USER_ID
                                ,v_bank_dep_tick_row.REORDER_SWITCH REORDER_SWITCH
                                ,to_char(v_bank_dep_tick_row.LAST_VW_ORDER_DATE, 'yyyymmdd') LAST_VW_ORDER_DATE
                                )) AS "result", 
                    XMLELEMENT ( "PrimaryKey",               
                                  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                  'http://www.oracle.com/Employee.xsd' AS
                                                  "xsi:nonamespaceSchemaLocation" ),
                                  XMLFOREST(
                                            v_bank_dep_tick_row.COST_CENTER_CODE COST_CENTER_CODE
                                            )) AS "primaryKey"
                                            ,('|' || v_bank_dep_tick_row.COST_CENTER_CODE || '|') transaction_id					
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
                ,'BANK_DEP_TICK'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_BANK_DEP_TICK_DEL');
     
END TR_BANK_DEP_TICK_DEL;

