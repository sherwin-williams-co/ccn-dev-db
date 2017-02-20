CREATE OR REPLACE TRIGGER "COSTCNTR"."TR_HIER_DESC_UPD"
   /***************************************************************************
   ***
   TR_HIER_DESC_UPD.TRG
   This trigger will insert records into audit_log table for logging changes
   happened on hierarchy_description table.
   Modified : 02/15/2017 gxg192 Added missing fields
   ****************************************************************************
   **/
   BEFORE INSERT OR UPDATE ON "COSTCNTR"."HIERARCHY_DESCRIPTION"
   REFERENCING OLD AS OLD NEW AS NEW
   FOR EACH ROW

   DECLARE
       v_transaction_id VARCHAR2(500);
       V_ROWDATA SYS.XMLTYPE;
       V_HI_DESC_ROW HIERARCHY_DESCRIPTION%ROWTYPE;
       v_primaryKey SYS.XMLTYPE;
   BEGIN
      v_hi_desc_row.HRCHY_HDR_NAME       := :NEW.HRCHY_HDR_NAME;
      V_HI_DESC_ROW.HRCHY_HDR_LVL_NBR    := :NEW.HRCHY_HDR_LVL_NBR;
      v_hi_desc_row.HRCHY_HDR_LVL_DESC   := :NEW.HRCHY_HDR_LVL_DESC;
      v_hi_desc_row.HRCHY_GLOBAL_LVL_NBR := :NEW.HRCHY_GLOBAL_LVL_NBR;
      v_hi_desc_row.LVL_VALUE_SIZE       := :NEW.LVL_VALUE_SIZE;
      v_hi_desc_row.UPPER_LVL_VER_VALUE  := :NEW.UPPER_LVL_VER_VALUE;

      SELECT XMLELEMENT ( "HIERARCHY_DESCRIPTION",
                          XMLATTRIBUTES (
                                         'http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                                         'http://www.oracle.com/Employee.xsd' AS
                                         "xsi:nonamespaceSchemaLocation" ),
                          XMLForest(
                                     v_hi_desc_row.HRCHY_HDR_NAME HRCHY_HDR_NAME ,
                                     V_HI_DESC_ROW.HRCHY_HDR_LVL_NBR HRCHY_HDR_LVL_NBR ,
                                     V_HI_DESC_ROW.HRCHY_HDR_LVL_DESC HRCHY_HDR_LVL_DESC ,
                                     v_hi_desc_row.HRCHY_GLOBAL_LVL_NBR HRCHY_GLOBAL_LVL_NBR ,
                                     v_hi_desc_row.LVL_VALUE_SIZE LVL_VALUE_SIZE ,
                                     v_hi_desc_row.UPPER_LVL_VER_VALUE UPPER_LVL_VER_VALUE )
                        ) AS "result" ,
             XMLELEMENT ( "PRIMARY_KEY",
                          XMLATTRIBUTES (
                                         'http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                                         'http://www.oracle.com/Employee.xsd' AS
                                         "xsi:nonamespaceSchemaLocation" ),
                          XMLFOREST(
                                     V_HI_DESC_ROW.HRCHY_HDR_NAME HRCHY_HDR_NAME,
                                     V_HI_DESC_ROW.HRCHY_HDR_LVL_NBR HRCHY_HDR_LVL_NBR )
                        ) AS "PrimaryKey" ,
             ('|'
             || V_HI_DESC_ROW.HRCHY_HDR_NAME
             || '|'
             || V_HI_DESC_ROW.HRCHY_HDR_LVL_NBR
             || '|') transaction_id
      INTO v_rowdata ,
         v_primaryKey ,
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
            'HIERARCHY_DESCRIPTION' ,
            v_primaryKey ,
            v_rowdata ,
            'TR_HIER_DESC_UPD'
         );
      --END IF;
   END TR_HIER_DESC_UPD;
