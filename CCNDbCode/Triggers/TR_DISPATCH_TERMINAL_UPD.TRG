create or replace TRIGGER TR_DISPATCH_TERMINAL_UPD
/**********************************************************
handle Audit Log and POS Data generation for DISPATCH_TERMINAL

created  : 04/12/2017 rxa457 CCN Project Team..
Modified : 06/23/2017 rxa457 CCN Project Team..
               The purpose is to store the Audit on DISPATCH_TERMINAL into Audit_log table 
               with "STORE" table name and "STORE" tags so that the backfeed to mainframe can be sent as "STORE" info
**********************************************************/
BEFORE INSERT OR UPDATE ON COSTCNTR.DISPATCH_TERMINAL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE
   v_transaction_id VARCHAR2(500);
   v_rowdata sys.xmltype;
   v_primarykey sys.xmltype;
   v_store_row store%rowtype;
BEGIN
  v_store_row.cost_center_code      := :new.cost_center_code;
  v_store_row.category              := 'S';
  v_store_row.perp_inv_start_date   := NULL;
  v_store_row.classification_code   := NULL;
  v_store_row.inventory_indicator   := NULL;
  v_store_row.rural_metro_zone_code := NULL;
  v_store_row.selling_store_flag    := NULL;
  v_store_row.sales_vol_class_code  := NULL;
  
  SELECT XMLELEMENT ("STORE",
                     XMLATTRIBUTES ('http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                                    'http://www.oracle.com/Employee.xsd' AS
                                    "xsi:nonamespaceSchemaLocation" ),
                     xmlforest(v_store_row.cost_center_code cost_center_code ,
                               v_store_row.category category,
                               TO_CHAR(v_store_row.perp_inv_start_date, 'yyyymmdd') perp_inv_start_date ,
                               v_store_row.classification_code classification_code ,
                               v_store_row.inventory_indicator inventory_indicator ,
                               v_store_row.rural_metro_zone_code rural_metro_zone_code ,
                               v_store_row.selling_store_flag selling_store_flag ,
                               v_store_row.sales_vol_class_code sales_vol_class_code )
                     ) AS "result" ,
         XMLELEMENT ( "PrimaryKey",
                      XMLATTRIBUTES (
                                 'http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                                 'http://www.oracle.com/Employee.xsd' AS
                                 "xsi:nonamespaceSchemaLocation" ),
                      xmlforest(v_store_row.cost_center_code cost_center_code )
                    ) AS "primaryKey" ,
         ('|'
         || v_store_row.COST_CENTER_CODE
         || '|' ) transaction_id
  INTO v_rowdata ,
       v_primarykey ,
       v_transaction_id
  FROM DUAL;
  INSERT
  INTO audit_log
     (
        log_id ,
        transaction_id ,
        transaction_date ,
        table_name ,
        table_pk_value ,
        table_row_data ,
        change_by
     )
     VALUES
     (
        (
           SELECT NVL(MAX(LOG_ID), 0) + 1
           FROM AUDIT_LOG
        )
        ,
        v_transaction_id ,
        sysdate ,
        'STORE' ,
        v_primaryKey ,
        v_rowdata ,
        'TR_DISPATCH_TERMINAL_UPD'
     );
END TR_DISPATCH_TERMINAL_UPD;
