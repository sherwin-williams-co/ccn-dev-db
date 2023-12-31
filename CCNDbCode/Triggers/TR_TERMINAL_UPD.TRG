create or replace TRIGGER "COSTCNTR".tr_terminal_upd
   /***************************************************************************
   TR_TERMINAL_UPD.TRG

   This trigger will insert records into audit_log table for logging changes
   happened on terminal table.
   Modified : 02/15/2017 gxg192 Added missing fields
            : 01/22/2018 nxk927 Added POS_VERSION_NBR field
            : 01/24/2018 sxg151 Removed pci_terminal_id,pci_val_link_alt_mid & pci_value_link_mid
            : 06/25/2019 axm868 Added GET_DESIGNATED_TERMINAL_NUMBER logic,
                                for CCNCC-2
            : 07/08/2019 axm868 Updated STORE.DESIGNATED_TERMINAL_NUMBER
                                to the first terminal number, for CCNCC-2
   ****************************************************************************/
   BEFORE INSERT OR UPDATE ON terminal
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW

   DECLARE
       v_transaction_id VARCHAR2(500);
       v_rowdata sys.xmltype;
       v_primaryKey sys.xmltype;
       v_terminal_row TERMINAL%ROWTYPE;
   BEGIN
      /*
      SELECT NVL(MAX(TRANSACTION_ID), 0) + 1
      INTO v_transaction_id
      FROM AUDIT_LOG;
      */
      v_terminal_row.COST_CENTER_CODE     := :NEW.COST_CENTER_CODE;
      v_terminal_row.POLLING_STATUS_CODE  := :NEW.POLLING_STATUS_CODE;
      v_terminal_row.TERMINAL_NUMBER      := :NEW.TERMINAL_NUMBER;
      v_terminal_row.EFFECTIVE_DATE       := :NEW.EFFECTIVE_DATE;
      v_terminal_row.EXPIRATION_DATE      := :NEW.EXPIRATION_DATE;
      v_terminal_row.POS_LAST_TRAN_DATE   := :NEW.POS_LAST_TRAN_DATE;
      v_terminal_row.POS_LAST_TRAN_NUMBER := :NEW.POS_LAST_TRAN_NUMBER;
      v_terminal_row.POS_VERSION_NBR      := :NEW.POS_VERSION_NBR;
      
      SELECT XMLELEMENT ( "TERMINAL",
                XMLATTRIBUTES ('http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                               'http://www.oracle.com/Employee.xsd' AS
                               "xsi:nonamespaceSchemaLocation" ),
                XMLFOREST(v_terminal_row.COST_CENTER_CODE COST_CENTER_CODE ,
                          v_terminal_row.POLLING_STATUS_CODE POLLING_STATUS_CODE ,
                          v_terminal_row.TERMINAL_NUMBER TERMINAL_NUMBER ,TO_CHAR(
                          v_terminal_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE ,TO_CHAR(
                          v_terminal_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE ,TO_CHAR(
                          v_terminal_row.POS_LAST_TRAN_DATE, 'yyyymmdd') POS_LAST_TRAN_DATE ,
                          v_terminal_row.POS_LAST_TRAN_NUMBER POS_LAST_TRAN_NUMBER ,
                          v_terminal_row.POS_VERSION_NBR POS_VERSION_NBR)
                        ) AS "result" ,
             XMLELEMENT ( "PrimaryKey",
                XMLATTRIBUTES ('http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                               'http://www.oracle.com/Employee.xsd' AS
                               "xsi:nonamespaceSchemaLocation" ),
                XMLForest(V_TERMINAL_ROW.COST_CENTER_CODE COST_CENTER_CODE ,
                          v_terminal_row.EFFECTIVE_DATE EFFECTIVE_DATE ,
                          v_terminal_row.TERMINAL_NUMBER TERMINAL_NUMBER)
                        ) AS "primaryKey" ,
             ('|'
             || V_TERMINAL_ROW.COST_CENTER_CODE
             || '|'
             || V_TERMINAL_ROW.TERMINAL_NUMBER
             || '|'
             || '|'
             || TO_CHAR(V_TERMINAL_ROW.EFFECTIVE_DATE,'DD-MON-YY')
             || '|') tran_id
      INTO V_ROWDATA ,
         v_primaryKey,
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
            'TERMINAL' ,
            v_primaryKey ,
            v_rowdata ,
            'TR_TERMINAL_UPD'
         );
      --END IF;
     BEGIN
         IF INSERTING THEN
             IF CCN_COMMON_TOOLS.GET_DESIGNATED_TERMINAL_NUMBER(v_terminal_row.COST_CENTER_CODE) IS NULL THEN
                POS_DATA_GENERATION.POS_TRG_EVENT_LOG(v_terminal_row.COST_CENTER_CODE,
                                                      'TERMINAL',
                                                      'ADD',
                                                      'POS_PARAM_UPDATE'
                                                      );
              UPDATE STORE S
                 SET S.DESIGNATED_TERMINAL_NUMBER = v_terminal_row.TERMINAL_NUMBER
              WHERE S.COST_CENTER_CODE = v_terminal_row.COST_CENTER_CODE;
             END IF;
         END IF;
     EXCEPTION
        WHEN OTHERS THEN
             ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                        'TR_TERMINAL_UPD',
                                        SQLERRM,
                                        v_terminal_row.COST_CENTER_CODE
                                        );
     END;
   END TR_TERMINAL_UPD;