create or replace TRIGGER BANKING.TR_LEAD_BANK_CC_UPD
BEFORE INSERT OR UPDATE ON BANKING.LEAD_BANK_CC
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_lead_bank_cc_row lead_bank_cc%ROWTYPE;
     
    
begin

         v_lead_bank_cc_row.LEAD_BANK_ACCOUNT_NBR := :NEW.LEAD_BANK_ACCOUNT_NBR;
         v_lead_bank_cc_row.LEAD_STORE_NBR        := :NEW.LEAD_STORE_NBR;
         v_lead_bank_cc_row.EFFECTIVE_DATE        := :NEW.EFFECTIVE_DATE;
         v_lead_bank_cc_row.EXPIRATION_DATE       := :NEW.EXPIRATION_DATE;
         v_lead_bank_cc_row.BANK_BRANCH_NBR       := :NEW.BANK_BRANCH_NBR;
         v_lead_bank_cc_row.BANK_TYPE_CODE        := :NEW.BANK_TYPE_CODE;
         v_lead_bank_cc_row.UPDATE_DATE           := :NEW.UPDATE_DATE;
         v_lead_bank_cc_row.LAST_UPD_USER_ID      := :NEW.LAST_UPD_USER_ID;
	    
	SELECT XMLELEMENT ( "LEAD_BANK_CC",               
                      XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                      'http://www.oracle.com/Employee.xsd' AS
                                      "xsi:nonamespaceSchemaLocation" ),
                      XMLFOREST(
                           v_lead_bank_cc_row.LEAD_BANK_ACCOUNT_NBR LEAD_BANK_ACCOUNT_NBR
                          ,v_lead_bank_cc_row.LEAD_STORE_NBR LEAD_STORE_NBR
                          ,to_char(v_lead_bank_cc_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
                          ,to_char(v_lead_bank_cc_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
                          ,v_lead_bank_cc_row.BANK_BRANCH_NBR BANK_BRANCH_NBR
                          ,v_lead_bank_cc_row.BANK_TYPE_CODE BANK_TYPE_CODE
                          ,to_char(v_lead_bank_cc_row.UPDATE_DATE, 'yyyymmdd') UPDATE_DATE
                          ,v_lead_bank_cc_row.LAST_UPD_USER_ID LAST_UPD_USER_ID
                          )) AS "result",
                      XMLELEMENT ( "PrimaryKey",               
                                    XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                    'http://www.oracle.com/Employee.xsd' AS
                                                    "xsi:nonamespaceSchemaLocation" ),
                                    XMLFOREST(
                                               v_lead_bank_cc_row.LEAD_BANK_ACCOUNT_NBR LEAD_BANK_ACCOUNT_NBR
                                              ,v_lead_bank_cc_row.LEAD_STORE_NBR LEAD_STORE_NBR
                                              )) AS "primaryKey",
                                    ('|' || v_lead_bank_cc_row.LEAD_BANK_ACCOUNT_NBR || 
                                      '|' || v_lead_bank_cc_row.LEAD_STORE_NBR  || '|') transaction_id					
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
                ,'LEAD_BANK_CC'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_LEAD_BANK_CC_UPD');

BEGIN
    IF TRUNC(v_lead_bank_cc_row.EFFECTIVE_DATE) = TRUNC(v_lead_bank_cc_row.UPDATE_DATE) THEN
        -- For future records effective_date > update date
        -- For current records EFFECTIVE_DATE = UPDATE_DATE

        IF INSERTING THEN
            POS_DATA_GENERATION.POS_TRG_EVENT_LOG(v_lead_bank_cc_row.LEAD_STORE_NBR,
                                                  'LEAD_BANK_CC',
                                                  'ADD',
                                                  'POS_PARAM_UPDATE'
                                                  );
        END IF;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                   'TR_LEAD_BANK_CC_UPD',
                                   SQLERRM,
                                   v_lead_bank_cc_row.LEAD_BANK_ACCOUNT_NBR,
                                   v_lead_bank_cc_row.LEAD_STORE_NBR,
                                   'LEAD_BANK_CC'
                                   );
    END;
END TR_LEAD_BANK_CC_UPD;