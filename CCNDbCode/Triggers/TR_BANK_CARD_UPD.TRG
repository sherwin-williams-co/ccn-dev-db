CREATE OR REPLACE TRIGGER COSTCNTR.TR_BANK_CARD_UPD
   /***************************************************************************
   ***
   TR_BANK_CARD_UPD.TRG
   This trigger will insert records into audit_log table for logging changes
   happened on BANK_CARD table.
   Modified : 02/17/2017 gxg192 Added 2 new fields, PCI_MERCHANT_ID and PCI_DISCOVER_ID
            : 02/21/2017 gxg192 Added , to rectify compilation error
   ****************************************************************************
   **/
   BEFORE INSERT OR UPDATE ON COSTCNTR.BANK_CARD
   REFERENCING OLD AS OLD NEW AS NEW
   FOR EACH ROW

   DECLARE
       v_transaction_id VARCHAR2(500);
       v_rowdata sys.xmltype;
       v_primaryKey sys.xmltype;
       v_bank_card_row BANK_CARD%ROWTYPE;
   BEGIN
      /*
      SELECT NVL(MAX(TRANSACTION_ID), 0) + 1
      INTO v_transaction_id
      FROM AUDIT_LOG;
      */
      --This trigger code should be executed only if the corresponding data
      -- changes
      --If the data got manipulated by osme other table changes we should not
      -- consider that for audit_log
      IF NVL(CCN_TABLE_IU_PKG.TRIGGER_DISABLE_FLAG,'N') = 'N' THEN
         v_bank_card_row.COST_CENTER_CODE              := :NEW.COST_CENTER_CODE
         ;
         v_bank_card_row.POLLING_STATUS_CODE  := :NEW.POLLING_STATUS_CODE;
         v_bank_card_row.MERCHANT_ID          := :NEW.MERCHANT_ID;
         v_bank_card_row.EFFECTIVE_DATE       := :NEW.EFFECTIVE_DATE;
         v_bank_card_row.EXPIRATION_DATE      := :NEW.EXPIRATION_DATE;
         v_bank_card_row.LAST_MAINT_DATE      := :NEW.LAST_MAINT_DATE;
         v_bank_card_row.LAST_MAINT_METHOD_ID := :NEW.LAST_MAINT_METHOD_ID;
         v_bank_card_row.LAST_MAINT_USER_ID   := :NEW.LAST_MAINT_USER_ID;
         v_bank_card_row.QUALITY_CODE         := :NEW.QUALITY_CODE;
         v_bank_card_row.AMEX_SE_ID           := :NEW.AMEX_SE_ID;
         v_bank_card_row.DISCOVER_ID          := :NEW.DISCOVER_ID;
         v_bank_card_row.PCI_MERCHANT_ID      := :NEW.PCI_MERCHANT_ID;
         v_bank_card_row.PCI_DISCOVER_ID      := :NEW.PCI_DISCOVER_ID;
         SELECT XMLELEMENT ( "BANK_CARD",
                             XMLATTRIBUTES (
                                            'http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                                            'http://www.oracle.com/Employee.xsd' AS
                                            "xsi:nonamespaceSchemaLocation" ),
                             XMLForest(
                                        v_bank_card_row.COST_CENTER_CODE COST_CENTER_CODE ,
                                        v_bank_card_row.POLLING_STATUS_CODE POLLING_STATUS_CODE ,
                                        v_bank_card_row.MERCHANT_ID MERCHANT_ID ,
                                        TO_CHAR(v_bank_card_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE ,
                                        TO_CHAR(v_bank_card_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE ,
                                        TO_CHAR(v_bank_card_row.LAST_MAINT_DATE, 'yyyymmdd') LAST_MAINT_DATE ,
                                        v_bank_card_row.LAST_MAINT_METHOD_ID LAST_MAINT_METHOD_ID ,
                                        v_bank_card_row.LAST_MAINT_USER_ID LAST_MAINT_USER_ID ,
                                        v_bank_card_row.QUALITY_CODE QUALITY_CODE ,
                                        v_bank_card_row.AMEX_SE_ID AMEX_SE_ID ,
                                        v_bank_card_row.DISCOVER_ID DISCOVER_ID ,
                                        v_bank_card_row.PCI_MERCHANT_ID PCI_MERCHANT_ID ,
                                        v_bank_card_row.PCI_DISCOVER_ID PCI_DISCOVER_ID )
                            ) AS "result" ,
                XMLELEMENT ( "PrimaryKey",
                             XMLATTRIBUTES (
                                            'http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                                            'http://www.oracle.com/Employee.xsd' AS
                                            "xsi:nonamespaceSchemaLocation" ),
                             XMLForest(
                                        v_bank_card_row.COST_CENTER_CODE COST_CENTER_CODE ,
                                        v_bank_card_row.POLLING_STATUS_CODE POLLING_STATUS_CODE
                                        --,v_bank_card_row.MERCHANT_ID MERCHANT_ID
                                        ,v_bank_card_row.EFFECTIVE_DATE EFFECTIVE_DATE )
                            ) AS "primaryKey",
                ('|'
                || V_BANK_CARD_ROW.COST_CENTER_CODE
                || '|'
                || V_BANK_CARD_ROW.POLLING_STATUS_CODE
                ||
                --'|' || v_bank_card_row.MERCHANT_ID|| --'|')      as tran_id
                '|'
                || TO_CHAR(V_BANK_CARD_ROW.EFFECTIVE_DATE,'DD-MON-YY')
                || '|') AS tran_id
         INTO V_ROWDATA ,
            V_PRIMARYKEY ,
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
               SYSDATE ,
               'BANK_CARD' ,
               v_primaryKey ,
               v_rowdata ,
               'TR_BANK_CARD_UPD'
            );
         --END IF;
         BEGIN
            IF INSERTING THEN
               POS_DATA_GENERATION.POS_TRG_EVENT_LOG(
               V_BANK_CARD_ROW.COST_CENTER_CODE, 'BANK_CARD', 'ADD',
               'POS_PARAM_UPDATE' );
            ELSIF UPDATING THEN
               IF ( NVL(:OLD.MERCHANT_ID,'XXX')            <> NVL(:NEW.MERCHANT_ID,'XXX')
                  OR NVL(:OLD.DISCOVER_ID,'XXX')           <> NVL(:NEW.DISCOVER_ID,'XXX')
                  OR NVL(:OLD.AMEX_SE_ID,'XXX')            <> NVL(:NEW.AMEX_SE_ID,'XXX')
                  OR NVL(:OLD.QUALITY_CODE,'XXX')          <> NVL(:NEW.QUALITY_CODE,
                  'XXX')OR NVL(:OLD.PCI_MERCHANT_ID,'XXX') <> NVL(:NEW.PCI_MERCHANT_ID,'XXX') ) THEN
                  POS_DATA_GENERATION.POS_TRG_EVENT_LOG(V_BANK_CARD_ROW.COST_CENTER_CODE,
                                                        'BANK_CARD',
                                                        'CHANGE',
                                                        'POS_PARAM_UPDATE' );
               END IF;
            END IF;
         EXCEPTION
         WHEN OTHERS THEN
            ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                       'TR_BANK_CARD_UPD',
                                       SQLERRM,
                                       V_BANK_CARD_ROW.COST_CENTER_CODE );
         END;
      END IF;
   END TR_BANK_CARD_UPD;