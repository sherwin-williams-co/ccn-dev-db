CREATE OR REPLACE TRIGGER TR_LEAD_BANK_CC_FTR_UPD
BEFORE INSERT OR UPDATE ON LEAD_BANK_CC_FUTURE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_lead_bank_cc_ftr_row lead_bank_cc_future%ROWTYPE;
     
    
begin

         v_lead_bank_cc_ftr_row.LEAD_BANK_ACCOUNT_NBR := :NEW.LEAD_BANK_ACCOUNT_NBR;
         v_lead_bank_cc_ftr_row.LEAD_STORE_NBR   := :NEW.LEAD_STORE_NBR;
         v_lead_bank_cc_ftr_row.EFFECTIVE_DATE   := :NEW.EFFECTIVE_DATE;
         v_lead_bank_cc_ftr_row.EXPIRATION_DATE  := :NEW.EXPIRATION_DATE;
         v_lead_bank_cc_ftr_row.BANK_BRANCH_NBR  := :NEW.BANK_BRANCH_NBR;
         v_lead_bank_cc_ftr_row.BANK_TYPE_CODE        := :NEW.BANK_TYPE_CODE;
         v_lead_bank_cc_ftr_row.UPDATE_DATE  := :NEW.UPDATE_DATE;
         v_lead_bank_cc_ftr_row.LAST_UPD_USER_ID := :NEW.LAST_UPD_USER_ID;
	       v_lead_bank_cc_ftr_row.FUTURE_ID := :NEW.FUTURE_ID;
         
	SELECT XMLELEMENT ( "LEAD_BANK_CC_FUTURE",               
		  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
	       xmlforest(
             v_lead_bank_cc_ftr_row.LEAD_BANK_ACCOUNT_NBR LEAD_BANK_ACCOUNT_NBR
            ,v_lead_bank_cc_ftr_row.LEAD_STORE_NBR LEAD_STORE_NBR
            ,to_char(v_lead_bank_cc_ftr_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
            ,to_char(v_lead_bank_cc_ftr_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
            ,v_lead_bank_cc_ftr_row.BANK_BRANCH_NBR BANK_BRANCH_NBR
            ,v_lead_bank_cc_ftr_row.BANK_TYPE_CODE BANK_TYPE_CODE
            ,to_char(v_lead_bank_cc_ftr_row.UPDATE_DATE, 'yyyymmdd') UPDATE_DATE
            ,v_lead_bank_cc_ftr_row.LAST_UPD_USER_ID LAST_UPD_USER_ID
            ,v_lead_bank_cc_ftr_row.FUTURE_ID FUTURE_ID
            )) AS "result" 
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				 v_lead_bank_cc_ftr_row.LEAD_BANK_ACCOUNT_NBR LEAD_BANK_ACCOUNT_NBR
        ,v_lead_bank_cc_ftr_row.LEAD_STORE_NBR LEAD_STORE_NBR
        ,v_lead_bank_cc_ftr_row.FUTURE_ID FUTURE_ID
			)) AS "primaryKey"
			,('|' || v_lead_bank_cc_ftr_row.LEAD_BANK_ACCOUNT_NBR || 
        '|' || v_lead_bank_cc_ftr_row.LEAD_STORE_NBR ||
        '|' || v_lead_bank_cc_ftr_row.FUTURE_ID  || '|') transaction_id					
	INTO v_rowdata
		,v_primaryKey
		,v_transaction_id
	FROM DUAL;	
      
     /* -- for   Column -- */
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
                , SYSDATE
                , 'LEAD_BANK_CC_FUTURE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_LEAD_BANK_CC_FTR_UPD');
     
END TR_LEAD_BANK_CC_FTR_UPD;

