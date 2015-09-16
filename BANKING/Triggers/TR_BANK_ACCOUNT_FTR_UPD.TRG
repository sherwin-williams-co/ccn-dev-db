CREATE OR REPLACE TRIGGER TR_BANK_ACCOUNT_FTR_UPD
BEFORE INSERT OR UPDATE ON BANK_ACCOUNT_FUTURE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_bank_account_ftr_row bank_account_future%ROWTYPE;
     
    
begin

         v_bank_account_ftr_row.BANK_ACCOUNT_NBR := :NEW.BANK_ACCOUNT_NBR;
         v_bank_account_ftr_row.EFFECTIVE_DATE   := :NEW.EFFECTIVE_DATE;
         v_bank_account_ftr_row.EXPIRATION_DATE  := :NEW.EXPIRATION_DATE;
         v_bank_account_ftr_row.BANK_NAME        := :NEW.BANK_NAME;
         v_bank_account_ftr_row.BOOK_KEEPER_NBR  := :NEW.BOOK_KEEPER_NBR;
         v_bank_account_ftr_row.BANK_AUTO_RECON_IND  := :NEW.BANK_AUTO_RECON_IND;
         v_bank_account_ftr_row.RECON_START_DATE := :NEW.RECON_START_DATE;
         v_bank_account_ftr_row.RECON_BANK_ACCOUNT_NBR := :NEW.RECON_BANK_ACCOUNT_NBR;
         v_bank_account_ftr_row.JV_BOOK_KEEPER_REF := :NEW.JV_BOOK_KEEPER_REF;
         v_bank_account_ftr_row.JV_BANK_SHORT_NAME := :NEW.JV_BANK_SHORT_NAME;
         v_bank_account_ftr_row.IDI_BOOKKEEPER_REF := :NEW.IDI_BOOKKEEPER_REF;
         v_bank_account_ftr_row.IDI_BANK_SHORT_NAME := :NEW.IDI_BANK_SHORT_NAME;
         v_bank_account_ftr_row.ROUTING_NBR := :NEW.ROUTING_NBR;
         v_bank_account_ftr_row.UPDATE_DATE := :NEW.UPDATE_DATE;
         v_bank_account_ftr_row.LAST_UPD_USER_ID := :NEW.LAST_UPD_USER_ID;
         v_bank_account_ftr_row.FUTURE_ID := :NEW.FUTURE_ID;
	    
	SELECT XMLELEMENT ( "BANK_ACCOUNT_FUTURE",               
		  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                         "xsi:nonamespaceSchemaLocation" ),
	       xmlforest(
			 v_bank_account_ftr_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
			,to_char(v_bank_account_ftr_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
			,to_char(v_bank_account_ftr_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
			,v_bank_account_ftr_row.BANK_NAME BANK_NAME
			,v_bank_account_ftr_row.BOOK_KEEPER_NBR BOOK_KEEPER_NBR
			,v_bank_account_ftr_row.BANK_AUTO_RECON_IND BANK_AUTO_RECON_IND
      ,to_char(v_bank_account_ftr_row.RECON_START_DATE, 'yyyymmdd') RECON_START_DATE
      ,v_bank_account_ftr_row.RECON_BANK_ACCOUNT_NBR RECON_BANK_ACCOUNT_NBR
      ,v_bank_account_ftr_row.JV_BOOK_KEEPER_REF JV_BOOK_KEEPER_REF
      ,v_bank_account_ftr_row.JV_BANK_SHORT_NAME JV_BANK_SHORT_NAME
      ,v_bank_account_ftr_row.IDI_BOOKKEEPER_REF IDI_BOOKKEEPER_REF
      ,v_bank_account_ftr_row.IDI_BANK_SHORT_NAME IDI_BANK_SHORT_NAME
      ,v_bank_account_ftr_row.ROUTING_NBR ROUTING_NBR
      ,to_char(v_bank_account_ftr_row.UPDATE_DATE, 'yyyymmdd') UPDATE_DATE
      ,v_bank_account_ftr_row.LAST_UPD_USER_ID LAST_UPD_USER_ID
      ,v_bank_account_ftr_row.FUTURE_ID FUTURE_ID
			)) AS "result" 
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
				 v_bank_account_ftr_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
        ,v_bank_account_ftr_row.FUTURE_ID FUTURE_ID
			)) AS "primaryKey"
			,('|' || v_bank_account_ftr_row.BANK_ACCOUNT_NBR || 
        '|' || v_bank_account_ftr_row.FUTURE_ID  || '|') transaction_id					
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
                , 'BANK_ACCOUNT_FUTURE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_BANK_ACCOUNT_FTR_UPD');
     
END TR_BANK_ACCOUNT_FTR_UPD;

