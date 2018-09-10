create or replace TRIGGER "COSTCNTR"."TR_STORE_UPD"
   /***************************************************************************
   ***
   TR_STORE_UPD.TRG
   This trigger will insert records into audit_log table for logging changes
   happened on store table.
   Modified : 02/15/2017 gxg192 Added missing fields
   Modified : 04/04/2018 sxg151 CCN Project Team....
              Added new column POTENTIAL_OPEN_DATE
   Modified : 09/10/2018 pxa852 CCN Project Team...
              Modified code to insert records into pos_downloads table
              if there are any changed on store table.
   ****************************************************************************
   **/
   BEFORE INSERT OR UPDATE ON "COSTCNTR"."STORE"
   REFERENCING OLD AS OLD NEW AS NEW
   FOR EACH ROW

   DECLARE
       v_transaction_id VARCHAR2(500);
       v_rowdata sys.xmltype;
       v_primarykey sys.xmltype;
       v_store_row store%rowtype;
   BEGIN
      /*
      SELECT NVL(MAX(TRANSACTION_ID), 0) + 1
      INTO v_transaction_id
      FROM AUDIT_LOG;
      */
      v_store_row.cost_center_code        := :new.cost_center_code;
      v_store_row.category                := :new.category;
      v_store_row.perp_inv_start_date     := :new.perp_inv_start_date;
      v_store_row.classification_code     := :new.classification_code;
      v_store_row.inventory_indicator     := :new.inventory_indicator;
      v_store_row.rural_metro_zone_code   := :new.rural_metro_zone_code;
      v_store_row.selling_store_flag      := :new.selling_store_flag;
      v_store_row.sales_vol_class_code    := :NEW.sales_vol_class_code;
      v_store_row.potential_open_date     := :NEW.potential_open_date;
      v_store_row.descartes_delivery_code := :NEW.descartes_delivery_code;
      
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
                                   v_store_row.sales_vol_class_code sales_vol_class_code,
                                   TO_CHAR(v_store_row.potential_open_date, 'yyyymmdd') potential_open_date,
                                   v_store_row.descartes_delivery_code descartes_delivery_code )
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
      /* -- for   Column -- */
      --IF (:OLD.CATEGORY != :NEW.CATEGORY) THEN
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
            'TR_STORE_UPD'
         );
      --END IF;
      BEGIN
         IF INSERTING THEN
             POS_DATA_GENERATION.POS_TRG_EVENT_LOG(v_store_row.COST_CENTER_CODE, 'STORE', 'ADD', 'POS_STORE_UPDATE' );
         ELSIF UPDATING THEN
             IF NVL(:OLD.DESCARTES_DELIVERY_CODE, 'XXX') <> NVL(:NEW.DESCARTES_DELIVERY_CODE, 'XXX') THEN
                 POS_DATA_GENERATION.POS_TRG_EVENT_LOG(v_store_row.COST_CENTER_CODE, 'STORE', 'CHANGE', 'POS_STORE_UPDATE');
             END IF;
         END IF;
      EXCEPTION
          WHEN OTHERS THEN
              ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE, 'TR_STORE_UPD', SQLERRM, v_store_row.COST_CENTER_CODE );
      END;
   END TR_STORE_UPD;