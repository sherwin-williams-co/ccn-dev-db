create or replace TRIGGER COSTCNTR.TR_COST_CENTER_UPD
   /***************************************************************************
   ***
   TR_COST_CENTER_UPD.TRG
   This trigger will insert records into audit_log table for logging changes
   happened on cost_center table.
   Modified : 02/15/2017 gxg192 Added missing fields
            : 06/23/2017 rxa457 CCN Project Team..
                Override category "D" for dispatch_terminal category with "S" - Store type in order to 
                continue to send the back feed to mainframe as "S" category
            : 12/05/2017 rxv940 CCN Project Team..
              reference to Global variable (G_MUT_POS_DOWNLOAD_CC_IND) to handle mutating trigger error
            : 02/01/2018 rxv940 CCN Project Team..
             Changes to assign G_MUT_POS_DOWNLOAD_CC_IND based on S or T
             Setting POS_DOWNLOAD_CC_IND := 'Y' for Territories
            : 03/01/2018 nxk927/jxc527 CCN Project Team..
              indentation and the right event trigger for the catory
            : 02/15/2019 sxg151 CCN Team...
            : ASP-1216 : Added PRI_LOGO_GROUP_IND /SCD_LOGO_GROUP_IND  fields to be tracked to automatically trigger PARAM download for Stores.
   ****************************************************************************
   **/
   BEFORE INSERT OR UPDATE ON COSTCNTR.COST_CENTER
   REFERENCING NEW AS NEW OLD AS OLD
   FOR EACH ROW

   DECLARE
       v_transaction_id VARCHAR2(500);
       v_rowdata sys.xmltype;
       v_primaryKey sys.xmltype;
       v_cost_center_row COST_CENTER%ROWTYPE;
   BEGIN
      /*
      SELECT NVL(MAX(TRANSACTION_ID), 0) + 1
      INTO v_transaction_id
      FROM AUDIT_LOG;
      */
      v_cost_center_row.COST_CENTER_CODE             := :NEW.cost_center_code;
      v_cost_center_row.COST_CENTER_NAME             := :NEW.COST_CENTER_NAME;
      IF :NEW.CATEGORY = 'D' THEN
        v_cost_center_row.CATEGORY                   := 'S';
      ELSE
      v_cost_center_row.CATEGORY                     := :NEW.CATEGORY;
      END IF;
      v_cost_center_row.ENTITY_TYPE                  := :NEW.ENTITY_TYPE;
      v_cost_center_row.STATEMENT_TYPE               := :NEW.STATEMENT_TYPE;
      v_cost_center_row.COUNTRY_CODE                 := :NEW.COUNTRY_CODE;
      v_cost_center_row.TRANSPORT_TYPE               := :NEW.TRANSPORT_TYPE;
      v_cost_center_row.BEGIN_DATE                   := :NEW.BEGIN_DATE;
      v_cost_center_row.OPEN_DATE                    := :NEW.OPEN_DATE;
      v_cost_center_row.MOVE_DATE                    := :NEW.MOVE_DATE;
      v_cost_center_row.CLOSE_DATE                   := :NEW.CLOSE_DATE;
      v_cost_center_row.FINANCIAL_CLOSE_DATE         := :NEW.FINANCIAL_CLOSE_DATE;
      v_cost_center_row.POS_PROG_VER_EFF_DATE        := :NEW.POS_PROG_VER_EFF_DATE;
      v_cost_center_row.UPS_ZONE_CODE                := :NEW.UPS_ZONE_CODE;
      v_cost_center_row.RPS_ZONE_CODE                := :NEW.RPS_ZONE_CODE;
      v_cost_center_row.CURRENCY_CODE                := :NEW.CURRENCY_CODE;
      v_cost_center_row.POS_PROG_VER_NBR             := :NEW.POS_PROG_VER_NBR;
      v_cost_center_row.LEASE_OWN_CODE               := :NEW.LEASE_OWN_CODE;
      v_cost_center_row.MISSION_TYPE_CODE            := :NEW.MISSION_TYPE_CODE;
      v_cost_center_row.DUNS_NUMBER                  := :NEW.DUNS_NUMBER;
      v_cost_center_row.PRI_LOGO_GROUP_IND           := :NEW.PRI_LOGO_GROUP_IND;
      v_cost_center_row.SCD_LOGO_GROUP_IND           := :NEW.SCD_LOGO_GROUP_IND;
      v_cost_center_row.BANKING_TYPE                 := :NEW.BANKING_TYPE;
      v_cost_center_row.DEPOSIT_BAG_REORDER          := :NEW.DEPOSIT_BAG_REORDER;
      v_cost_center_row.DEPOSIT_TICKET_REORDER       := :NEW.DEPOSIT_TICKET_REORDER;
      v_cost_center_row.POP_KIT_CODE                 := :NEW.POP_KIT_CODE;
      v_cost_center_row.SPRAY_EQP_RPR_IND            := :NEW.SPRAY_EQP_RPR_IND;
      v_cost_center_row.BOOK_PLN_PROFILE_CD          := :NEW.BOOK_PLN_PROFILE_CD;
      v_cost_center_row.ACQUISITION_CODE             := :NEW.ACQUISITION_CODE;
      v_cost_center_row.CC_TEMP_CLOSED_CD            := :NEW.CC_TEMP_CLOSED_CD;
      v_cost_center_row.COLOR_CONSULTANT_TYPE        := :NEW.COLOR_CONSULTANT_TYPE;
      v_cost_center_row.GLOBAL_HIERARCHY_IND         := :NEW.GLOBAL_HIERARCHY_IND;
      v_cost_center_row.PCC_PCL_STORE                := :NEW.PCC_PCL_STORE;
      v_cost_center_row.POS_NON_STORE_IND            := :NEW.POS_NON_STORE_IND;
      v_cost_center_row.PRIM_COST_IDENTIFIER         := :NEW.PRIM_COST_IDENTIFIER;
      v_cost_center_row.STD_COST_IDENTIFIER          := :NEW.STD_COST_IDENTIFIER;

      SELECT XMLELEMENT ( "COST_CENTER",
                          XMLATTRIBUTES (
                                         'http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                                         'http://www.oracle.com/Employee.xsd' AS
                                         "xsi:nonamespaceSchemaLocation" ),
                          xmlforest(
                                     v_cost_center_row.COST_CENTER_CODE COST_CENTER_CODE ,
                                     v_cost_center_row.COST_CENTER_NAME COST_CENTER_NAME ,
                                     v_cost_center_row.CATEGORY CATEGORY ,
                                     v_cost_center_row.ENTITY_TYPE
                                     ENTITY_TYPE ,
                                     v_cost_center_row.STATEMENT_TYPE STATEMENT_TYPE ,
                                     v_cost_center_row.COUNTRY_CODE COUNTRY_CODE ,
                                     v_cost_center_row.TRANSPORT_TYPE TRANSPORT_TYPE ,
                                     TO_CHAR(v_cost_center_row.BEGIN_DATE, 'yyyymmdd') BEGIN_DATE ,
                                     TO_CHAR(v_cost_center_row.OPEN_DATE, 'yyyymmdd') OPEN_DATE ,
                                     TO_CHAR(v_cost_center_row.MOVE_DATE, 'yyyymmdd') MOVE_DATE ,
                                     TO_CHAR(v_cost_center_row.CLOSE_DATE, 'yyyymmdd') CLOSE_DATE ,
                                     TO_CHAR(v_cost_center_row.FINANCIAL_CLOSE_DATE, 'yyyymmdd') FINANCIAL_CLOSE_DATE ,
                                     TO_CHAR(v_cost_center_row.POS_PROG_VER_EFF_DATE,'yyyymmdd') POS_PROG_VER_EFF_DATE ,
                                     v_cost_center_row.UPS_ZONE_CODE UPS_ZONE_CODE ,
                                     v_cost_center_row.RPS_ZONE_CODE RPS_ZONE_CODE ,
                                     v_cost_center_row.CURRENCY_CODE CURRENCY_CODE ,
                                     v_cost_center_row.POS_PROG_VER_NBR POS_PROG_VER_NBR ,
                                     v_cost_center_row.LEASE_OWN_CODE LEASE_OWN_CODE ,
                                     v_cost_center_row.MISSION_TYPE_CODE MISSION_TYPE_CODE ,
                                     v_cost_center_row.DUNS_NUMBER DUNS_NUMBER ,
                                     v_cost_center_row.PRI_LOGO_GROUP_IND PRI_LOGO_GROUP_IND ,
                                     v_cost_center_row.SCD_LOGO_GROUP_IND SCD_LOGO_GROUP_IND ,
                                     v_cost_center_row.BANKING_TYPE BANKING_TYPE ,
                                     v_cost_center_row.DEPOSIT_BAG_REORDER DEPOSIT_BAG_REORDER ,
                                     v_cost_center_row.DEPOSIT_TICKET_REORDER DEPOSIT_TICKET_REORDER ,
                                     v_cost_center_row.POP_KIT_CODE POP_KIT_CODE ,
                                     v_cost_center_row.SPRAY_EQP_RPR_IND SPRAY_EQP_RPR_IND ,
                                     v_cost_center_row.BOOK_PLN_PROFILE_CD BOOK_PLN_PROFILE_CD ,
                                     v_cost_center_row.ACQUISITION_CODE ACQUISITION_CODE ,
                                     v_cost_center_row.CC_TEMP_CLOSED_CD CC_TEMP_CLOSED_CD ,
                                     v_cost_center_row.COLOR_CONSULTANT_TYPE COLOR_CONSULTANT_TYPE ,
                                     v_cost_center_row.GLOBAL_HIERARCHY_IND GLOBAL_HIERARCHY_IND ,
                                     v_cost_center_row.PCC_PCL_STORE PCC_PCL_STORE ,
                                     v_cost_center_row.POS_NON_STORE_IND POS_NON_STORE_IND ,
                                     v_cost_center_row.PRIM_COST_IDENTIFIER PRIM_COST_IDENTIFIER ,
                                     v_cost_center_row.STD_COST_IDENTIFIER STD_COST_IDENTIFIER)
                        ) AS "result" ,
             XMLELEMENT ( "PrimaryKey",
                          XMLATTRIBUTES (
                                         'http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                                         'http://www.oracle.com/Employee.xsd' AS
                                         "xsi:nonamespaceSchemaLocation" ),
                          XMLForest(
                                    v_cost_center_row.COST_CENTER_CODE COST_CENTER_CODE )) AS "primaryKey",
             ('|'
             || v_cost_center_row.COST_CENTER_CODE
             || '|' ) transaction_id
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
            'COST_CENTER' ,
            v_primaryKey ,
            v_rowdata ,
            'TR_COST_CENTER_UPD'
         );
      --END IF;
      BEGIN
         IF :NEW.CATEGORY = 'T' THEN
             POS_DATA_GENERATION.G_MUT_POS_DOWNLOAD_CC_IND := 'Y';
             --conditionally defaulting the below field to Y for territories
             :NEW.POS_DOWNLOAD_CC_IND := 'Y';
         ELSE
             POS_DATA_GENERATION.G_MUT_POS_DOWNLOAD_CC_IND := :OLD.POS_DOWNLOAD_CC_IND;
         END IF;
         IF INSERTING THEN
             IF :NEW.CATEGORY = 'S' THEN
                 POS_DATA_GENERATION.POS_TRG_EVENT_LOG(v_cost_center_row.COST_CENTER_CODE, 'COST_CENTER', 'ADD', 'POS_STORE_UPDATE' );
             ELSIF :NEW.CATEGORY = 'T' THEN
                 POS_DATA_GENERATION.POS_TRG_EVENT_LOG(v_cost_center_row.COST_CENTER_CODE, 'COST_CENTER', 'ADD', 'POS_TERRITORY_UPDATE' );
             END IF;
         ELSIF UPDATING THEN
             IF :NEW.CATEGORY = 'S' THEN
                 IF NVL(:OLD.COST_CENTER_NAME, 'XXX')  <> NVL(:NEW.COST_CENTER_NAME, 'XXX') OR
                    NVL(:OLD.CURRENCY_CODE, 'XXX')     <> NVL(:NEW.CURRENCY_CODE, 'XXX') OR
                    NVL(:OLD.COUNTRY_CODE, 'XXX')      <>  NVL(:NEW.COUNTRY_CODE, 'XXX') OR
                    NVL(:OLD.STATEMENT_TYPE, 'XXX')    <> NVL(:NEW.STATEMENT_TYPE, 'XXX') THEN
                     POS_DATA_GENERATION.POS_TRG_EVENT_LOG(v_cost_center_row.COST_CENTER_CODE, 'COST_CENTER', 'CHANGE', 'POS_STORE_UPDATE' );
                 END IF;
                 --Added below code to trigger POS PARAM download if Primary or Secondar logo information changes in CCN
                 --Unlike Store and Territory downloads which are sent to all stores in polling 2.0, Param downloads are sent only to its respective store and do not need to be triggered as part of store creation
                 --That is the reason why the changes are only during trigger update flow
                 IF NVL(:OLD.PRI_LOGO_GROUP_IND, 'XXX') <> NVL(:NEW.PRI_LOGO_GROUP_IND, 'XXX') OR
                    NVL(:OLD.SCD_LOGO_GROUP_IND, 'XXX') <> NVL(:NEW.SCD_LOGO_GROUP_IND, 'XXX') THEN
                     POS_DATA_GENERATION.POS_TRG_EVENT_LOG(v_cost_center_row.COST_CENTER_CODE, 'COST_CENTER', 'CHANGE', 'POS_PARAM_UPDATE' );
                 END IF;
             END IF;
         END IF;
         POS_DATA_GENERATION.G_MUT_POS_DOWNLOAD_CC_IND := NULL;
      EXCEPTION
          WHEN OTHERS THEN
              ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE, 'TR_COST_CENTER_UPD', SQLERRM, v_cost_center_row.COST_CENTER_CODE );
              POS_DATA_GENERATION.G_MUT_POS_DOWNLOAD_CC_IND := NULL;
      END;
   END TR_COST_CENTER_UPD;