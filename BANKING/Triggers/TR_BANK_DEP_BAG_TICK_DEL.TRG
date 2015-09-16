CREATE OR REPLACE TRIGGER TR_BANK_DEP_BAG_TICK_DEL
BEFORE DELETE ON BANK_DEP_BAG_TICK
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE
	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_bank_dep_bag_tick_row bank_dep_bag_tick%ROWTYPE;

begin
         v_bank_dep_bag_tick_row.BANK_ACCOUNT_NBR         := :OLD.BANK_ACCOUNT_NBR;
         v_bank_dep_bag_tick_row.COST_CENTER_CODE         := :OLD.COST_CENTER_CODE;
         v_bank_dep_bag_tick_row.DEPBAG_DAILY_USE_ACTUAL  := :OLD.DEPBAG_DAILY_USE_ACTUAL;
         v_bank_dep_bag_tick_row.DEPBAG_DLY_USE_OVERRIDE  := :OLD.DEPBAG_DLY_USE_OVERRIDE;
         v_bank_dep_bag_tick_row.DEPBAG_LAST_ORDER_DATE   := :OLD.DEPBAG_LAST_ORDER_DATE;
         v_bank_dep_bag_tick_row.DEPBAG_LAST_ORDER_QTY    := :OLD.DEPBAG_LAST_ORDER_QTY;
         v_bank_dep_bag_tick_row.DEPBAG_ONHAND_QTY        := :OLD.DEPBAG_ONHAND_QTY;
         v_bank_dep_bag_tick_row.DEPBAG_REORDER_QTY       := :OLD.DEPBAG_REORDER_QTY;
         v_bank_dep_bag_tick_row.DEPBAG_YTD_ORDERED_QTY   := :OLD.DEPBAG_YTD_ORDERED_QTY;
         v_bank_dep_bag_tick_row.DEP_BAG_REORDER_POINT    := :OLD.DEP_BAG_REORDER_POINT;
         v_bank_dep_bag_tick_row.DEP_BAG_TYPE             := :OLD.DEP_BAG_TYPE;
         v_bank_dep_bag_tick_row.DEP_BAG_REORDER_SWITCH   := :OLD.DEP_BAG_REORDER_SWITCH;
         v_bank_dep_bag_tick_row.EFFECTIVE_DATE           := :OLD.EFFECTIVE_DATE;
         v_bank_dep_bag_tick_row.EXPIRATION_DATE          := :OLD.EXPIRATION_DATE;
	SELECT XMLELEMENT ( "BANK_DEP_BAG_TICK",               
                      XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                      'http://www.oracle.com/Employee.xsd' AS
                                      "xsi:nonamespaceSchemaLocation" ),
                      XMLFOREST( 'Delete' UPD_TYPE
                                ,v_bank_dep_bag_tick_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
                                ,v_bank_dep_bag_tick_row.COST_CENTER_CODE COST_CENTER_CODE
                                ,v_bank_dep_bag_tick_row.DEPBAG_DAILY_USE_ACTUAL DEPBAG_DAILY_USE_ACTUAL
                                ,v_bank_dep_bag_tick_row.DEPBAG_DLY_USE_OVERRIDE DEPBAG_DLY_USE_OVERRIDE
                                ,to_char(v_bank_dep_bag_tick_row.DEPBAG_LAST_ORDER_DATE, 'yyyymmdd') DEPBAG_LAST_ORDER_DATE
                                ,v_bank_dep_bag_tick_row.DEPBAG_LAST_ORDER_QTY DEPBAG_LAST_ORDER_QTY
                                ,v_bank_dep_bag_tick_row.DEPBAG_ONHAND_QTY DEPBAG_ONHAND_QTY
                                ,v_bank_dep_bag_tick_row.DEPBAG_REORDER_QTY DEPBAG_REORDER_QTY
                                ,v_bank_dep_bag_tick_row.DEPBAG_YTD_ORDERED_QTY DEPBAG_YTD_ORDERED_QTY
                                ,v_bank_dep_bag_tick_row.DEP_BAG_REORDER_POINT DEP_BAG_REORDER_POINT
                                ,v_bank_dep_bag_tick_row.DEP_BAG_TYPE DEP_BAG_TYPE
                                ,v_bank_dep_bag_tick_row.DEP_BAG_REORDER_SWITCH DEP_BAG_REORDER_SWITCH
                                ,to_char(v_bank_dep_bag_tick_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
                                ,to_char(v_bank_dep_bag_tick_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
                                )) AS "result", 
                    XMLELEMENT ( "PrimaryKey",               
                                  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                  'http://www.oracle.com/Employee.xsd' AS
                                                  "xsi:nonamespaceSchemaLocation" ),
                                  XMLFOREST(
                                             v_bank_dep_bag_tick_row.COST_CENTER_CODE COST_CENTER_CODE
                                            )) AS "primaryKey"
                                            ,('|' || v_bank_dep_bag_tick_row.COST_CENTER_CODE || '|') transaction_id					
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
                ,'BANK_DEP_BAG_TICK'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_BANK_DEP_BAG_TICK_DEL');
     
END TR_BANK_DEP_BAG_TICK_DEL;

