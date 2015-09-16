CREATE OR REPLACE TRIGGER TR_BANK_ACCOUNT_DEL
BEFORE DELETE ON BANK_ACCOUNT 
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_bank_account_row bank_account%ROWTYPE;
    
BEGIN
         v_bank_account_row.BANK_ACCOUNT_NBR := :OLD.BANK_ACCOUNT_NBR;
         v_bank_account_row.EFFECTIVE_DATE   := :OLD.EFFECTIVE_DATE;
         v_bank_account_row.EXPIRATION_DATE  := :OLD.EXPIRATION_DATE;
         v_bank_account_row.BANK_NAME        := :OLD.BANK_NAME;
         v_bank_account_row.BOOK_KEEPER_NBR  := :OLD.BOOK_KEEPER_NBR;
         v_bank_account_row.BANK_AUTO_RECON_IND  := :OLD.BANK_AUTO_RECON_IND;
         v_bank_account_row.RECON_START_DATE := :OLD.RECON_START_DATE;
         v_bank_account_row.RECON_BANK_ACCOUNT_NBR := :OLD.RECON_BANK_ACCOUNT_NBR;
         v_bank_account_row.JV_BOOK_KEEPER_REF := :OLD.JV_BOOK_KEEPER_REF;
         v_bank_account_row.JV_BANK_SHORT_NAME := :OLD.JV_BANK_SHORT_NAME;
         v_bank_account_row.IDI_BOOKKEEPER_REF := :OLD.IDI_BOOKKEEPER_REF;
         v_bank_account_row.IDI_BANK_SHORT_NAME := :OLD.IDI_BANK_SHORT_NAME;
         v_bank_account_row.ROUTING_NBR := :OLD.ROUTING_NBR;
         v_bank_account_row.UPDATE_DATE := :OLD.UPDATE_DATE;
         v_bank_account_row.LAST_UPD_USER_ID := :OLD.LAST_UPD_USER_ID;
	    
	SELECT XMLELEMENT ( "BANK_ACCOUNT",               
                      XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                      'http://www.oracle.com/Employee.xsd' AS
                                      "xsi:nonamespaceSchemaLocation" ),
                      XMLFOREST( 'Delete' UPD_TYPE
                                ,v_bank_account_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
                                ,to_char(v_bank_account_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
                                ,to_char(v_bank_account_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
                                ,v_bank_account_row.BANK_NAME BANK_NAME
                                ,v_bank_account_row.BOOK_KEEPER_NBR BOOK_KEEPER_NBR
                                ,v_bank_account_row.BANK_AUTO_RECON_IND BANK_AUTO_RECON_IND
                                ,to_char(v_bank_account_row.RECON_START_DATE, 'yyyymmdd') RECON_START_DATE
                                ,v_bank_account_row.RECON_BANK_ACCOUNT_NBR RECON_BANK_ACCOUNT_NBR
                                ,v_bank_account_row.JV_BOOK_KEEPER_REF JV_BOOK_KEEPER_REF
                                ,v_bank_account_row.JV_BANK_SHORT_NAME JV_BANK_SHORT_NAME
                                ,v_bank_account_row.IDI_BOOKKEEPER_REF IDI_BOOKKEEPER_REF
                                ,v_bank_account_row.IDI_BANK_SHORT_NAME IDI_BANK_SHORT_NAME
                                ,v_bank_account_row.ROUTING_NBR ROUTING_NBR
                                ,to_char(v_bank_account_row.UPDATE_DATE, 'yyyymmdd') UPDATE_DATE
                                ,v_bank_account_row.LAST_UPD_USER_ID LAST_UPD_USER_ID
                                )) AS "result" ,
                      XMLELEMENT ( "PrimaryKey",               
                                   XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                   'http://www.oracle.com/Employee.xsd' AS
                                                   "xsi:nonamespaceSchemaLocation" ),
                                   XMLFOREST(  v_bank_account_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
                                            )) AS "primaryKey"
                                  ,('|' || v_bank_account_row.BANK_ACCOUNT_NBR || '|') transaction_id					
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
               ((SELECT NVL(MAX(LOG_ID), 0) + 1 FROM AUDIT_LOG)
                ,v_transaction_id
                , SYSDATE
                , 'BANK_ACCOUNT'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_BANK_ACCOUNT_DEL');
     
END TR_BANK_ACCOUNT_DEL;

