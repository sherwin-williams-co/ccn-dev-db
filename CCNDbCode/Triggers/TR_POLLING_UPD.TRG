create or replace TRIGGER "COSTCNTR".tr_polling_upd
   /***************************************************************************
   ***
   TR_POLLING_UPD.TRG
   This trigger will insert records into audit_log table for logging changes
   happened on polling table.
   Modified : 02/15/2017 gxg192 Added missing fields
            : 03/08/2018 nxk927 Added new field polling start date and stop date
            : 03/15/2018 nxk927 Added missing alias for the new field polling start date and stop date
            : 06/12/2018 pxa852 CCN Project Team....
              EFFECTIVE_DATE column name changed to POLL_STATUS_EFF_DT and
              EXPIRATION_DATE column name changed to POLL_STATUS_EXP_DT
   ****************************************************************************
   **/
   BEFORE INSERT OR UPDATE ON polling
   REFERENCING OLD AS OLD NEW AS NEW
   FOR EACH ROW

   DECLARE
       v_transaction_id VARCHAR2(500);
       v_rowdata sys.xmltype;
       v_primarykey sys.xmltype;
       v_polling_row polling%ROWTYPE;
   BEGIN
      /*
      SELECT NVL(MAX(TRANSACTION_ID), 0) + 1
      INTO v_transaction_id
      FROM AUDIT_LOG;
      */
      v_polling_row.cost_center_code          := :NEW.cost_center_code;
      v_polling_row.polling_status_code       := :NEW.polling_status_code;
      v_polling_row.multicast_ind             := :NEW.multicast_ind;
      v_polling_row.time_zone                 := :NEW.time_zone;
      v_polling_row.polling_ind               := :NEW.polling_ind;
      v_polling_row.next_download_block_count := :NEW.next_download_block_count;
      v_polling_row.current_flag              := :NEW.current_flag;
      v_polling_row.poll_status_eff_dt        := :NEW.poll_status_eff_dt;
      v_polling_row.poll_status_exp_dt        := :NEW.poll_status_exp_dt;
      v_polling_row.POLLING_START_DATE        := :NEW.POLLING_START_DATE;
      v_polling_row.POLLING_STOP_DATE         := :NEW.POLLING_STOP_DATE;
      
      SELECT XMLELEMENT ( "POLLING",
                          XMLATTRIBUTES ('http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                                         'http://www.oracle.com/Employee.xsd' AS
                                         "xsi:nonamespaceSchemaLocation" ),
                         XMLFOREST(v_polling_row.cost_center_code cost_center_code ,
                                   v_polling_row.polling_status_code polling_status_code ,
                                   v_polling_row.multicast_ind multicast_ind ,
                                   v_polling_row.time_zone time_zone ,
                                   v_polling_row.polling_ind polling_ind ,
                                   v_polling_row.next_download_block_count next_download_block_count ,
                                   v_polling_row.current_flag current_flag ,
                                   v_polling_row.poll_status_eff_dt poll_status_eff_dt ,
                                   v_polling_row.poll_status_exp_dt poll_status_exp_dt,
                                   v_polling_row.POLLING_START_DATE POLLING_START_DATE,
                                   v_polling_row.POLLING_STOP_DATE POLLING_STOP_DATE)
                        ) AS "result" ,
             XMLELEMENT ( "PrimaryKey",
                          XMLATTRIBUTES (
                                         'http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                                         'http://www.oracle.com/Employee.xsd' AS
                                         "xsi:nonamespaceSchemaLocation" ),
                          xmlforest(
                                     v_polling_row.cost_center_code cost_center_code ,
                                     v_polling_row.polling_status_code polling_status_code )
                        ) AS "primaryKey",
             ('|'
             || v_polling_row.cost_center_code
             || '|'
             || v_polling_row.polling_status_code
             || '|') tran_id
      INTO V_ROWDATA ,
         v_primarykey,
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
            'POLLING' ,
            v_primaryKey ,
            v_rowdata ,
            'TR_POLLING_UPD'
         );
      --END IF;
   END TR_POLLING_UPD;