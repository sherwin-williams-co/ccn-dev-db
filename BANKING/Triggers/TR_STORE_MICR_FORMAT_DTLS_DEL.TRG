CREATE OR REPLACE TRIGGER TR_STORE_MICR_FORMAT_DTLS_DEL
BEFORE DELETE ON STORE_MICR_FORMAT_DTLS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_store_micr_format_dtls_row store_micr_format_dtls%ROWTYPE;
    
begin
         v_store_micr_format_dtls_row.BANK_ACCOUNT_NBR := :OLD.BANK_ACCOUNT_NBR;
         v_store_micr_format_dtls_row.MICR_FORMAT_ID   := :OLD.MICR_FORMAT_ID;
         v_store_micr_format_dtls_row.COST_CENTER_CODE   := :OLD.COST_CENTER_CODE;
         v_store_micr_format_dtls_row.MICR_COST_CNTR := :OLD.MICR_COST_CNTR;
         v_store_micr_format_dtls_row.MICR_ROUTING_NBR  := :OLD.MICR_ROUTING_NBR;
         v_store_micr_format_dtls_row.MICR_FORMAT_ACCT_NBR  := :OLD.MICR_FORMAT_ACCT_NBR;
         v_store_micr_format_dtls_row.EFFECTIVE_DATE   := :OLD.EFFECTIVE_DATE;
         v_store_micr_format_dtls_row.EXPIRATION_DATE  := :OLD.EXPIRATION_DATE;
         
	SELECT XMLELEMENT ( "STORE_MICR_FORMAT_DTLS",               
                      XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                      'http://www.oracle.com/Employee.xsd' AS
                                      "xsi:nonamespaceSchemaLocation" ),
                      XMLFOREST( 'Delete' UPD_TYPE
                                 ,v_store_micr_format_dtls_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
                                 ,v_store_micr_format_dtls_row.MICR_FORMAT_ID MICR_FORMAT_ID
                                 ,v_store_micr_format_dtls_row.COST_CENTER_CODE COST_CENTER_CODE
                                 ,v_store_micr_format_dtls_row.MICR_COST_CNTR MICR_COST_CNTR
                                 ,v_store_micr_format_dtls_row.MICR_ROUTING_NBR MICR_ROUTING_NBR
                                 ,v_store_micr_format_dtls_row.MICR_FORMAT_ACCT_NBR MICR_FORMAT_ACCT_NBR
                                 ,to_char(v_store_micr_format_dtls_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
                                 ,to_char(v_store_micr_format_dtls_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
                                 )) AS "result", 
                    XMLELEMENT ( "PrimaryKey",               
                                 XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                 'http://www.oracle.com/Employee.xsd' AS
                                                 "xsi:nonamespaceSchemaLocation" ),
                                 XMLFOREST( v_store_micr_format_dtls_row.COST_CENTER_CODE COST_CENTER_CODE
                                          )) AS "primaryKey"
                                          ,('|' || v_store_micr_format_dtls_row.COST_CENTER_CODE || '|') transaction_id					
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
                , SYSDATE
                , 'STORE_MICR_FORMAT_DTLS'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_STORE_MICR_FORMAT_DTLS_DEL');
     
END TR_STORE_MICR_FORMAT_DTLS_DEL;

