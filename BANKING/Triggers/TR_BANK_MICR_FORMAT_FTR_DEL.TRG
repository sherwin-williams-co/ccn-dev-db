CREATE OR REPLACE TRIGGER TR_BANK_MICR_FORMAT_FTR_DEL
BEFORE DELETE ON BANK_MICR_FORMAT_FUTURE
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_bank_micr_format_ftr_row bank_micr_format_future%ROWTYPE;
    
begin
         v_bank_micr_format_ftr_row.BANK_ACCOUNT_NBR       := :OLD.BANK_ACCOUNT_NBR;
         v_bank_micr_format_ftr_row.FORMAT_NAME            := :OLD.FORMAT_NAME;
         v_bank_micr_format_ftr_row.DJDE_FORM_PARM         := :OLD.DJDE_FORM_PARM;
         v_bank_micr_format_ftr_row.DJDE_FEED_PARM         := :OLD.DJDE_FEED_PARM;
         v_bank_micr_format_ftr_row.MICR_COST_CNTR         := :OLD.MICR_COST_CNTR;
         v_bank_micr_format_ftr_row.MICR_ROUTING_NBR       := :OLD.MICR_ROUTING_NBR;
         v_bank_micr_format_ftr_row.MICR_FORMAT_ACTNBR     := :OLD.MICR_FORMAT_ACTNBR;
         v_bank_micr_format_ftr_row.EFFECTIVE_DATE         := :OLD.EFFECTIVE_DATE;
         v_bank_micr_format_ftr_row.EXPIRATION_DATE        := :OLD.EXPIRATION_DATE;
         v_bank_micr_format_ftr_row.LAST_MAINTENANCE_DATE  := :OLD.LAST_MAINTENANCE_DATE;
         v_bank_micr_format_ftr_row.LAST_MAINT_USER_ID     := :OLD.LAST_MAINT_USER_ID;
         v_bank_micr_format_ftr_row.UPDATE_DATE            := :OLD.UPDATE_DATE;
         v_bank_micr_format_ftr_row.LAST_UPD_USER_ID       := :OLD.LAST_UPD_USER_ID;
         v_bank_micr_format_ftr_row.FUTURE_ID              := :OLD.FUTURE_ID;
         v_bank_micr_format_ftr_row.MICR_FORMAT_ID         := :OLD.MICR_FORMAT_ID;
         
	SELECT XMLELEMENT ( "BANK_MICR_FORMAT_FUTURE",               
                       XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                       'http://www.oracle.com/Employee.xsd' AS
                                       "xsi:nonamespaceSchemaLocation" ),
                       XMLFOREST( 'Delete' UPD_TYPE
                                  ,v_bank_micr_format_ftr_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
                                  ,v_bank_micr_format_ftr_row.FORMAT_NAME FORMAT_NAME
                                  ,v_bank_micr_format_ftr_row.DJDE_FORM_PARM DJDE_FORM_PARM
                                  ,v_bank_micr_format_ftr_row.DJDE_FEED_PARM DJDE_FEED_PARM
                                  ,v_bank_micr_format_ftr_row.MICR_COST_CNTR MICR_COST_CNTR
                                  ,v_bank_micr_format_ftr_row.MICR_ROUTING_NBR MICR_ROUTING_NBR
                                  ,v_bank_micr_format_ftr_row.MICR_FORMAT_ACTNBR MICR_FORMAT_ACTNBR
                                  ,to_char(v_bank_micr_format_ftr_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
                                  ,to_char(v_bank_micr_format_ftr_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
                                  ,to_char(v_bank_micr_format_ftr_row.LAST_MAINTENANCE_DATE, 'yyyymmdd') LAST_MAINTENANCE_DATE
                                  ,v_bank_micr_format_ftr_row.LAST_MAINT_USER_ID LAST_MAINT_USER_ID
                                  ,to_char(v_bank_micr_format_ftr_row.UPDATE_DATE, 'yyyymmdd') UPDATE_DATE
                                  ,v_bank_micr_format_ftr_row.LAST_UPD_USER_ID LAST_UPD_USER_ID
                                  ,v_bank_micr_format_ftr_row.FUTURE_ID FUTURE_ID
                                  ,v_bank_micr_format_ftr_row.MICR_FORMAT_ID MICR_FORMAT_ID
                                  )) AS "result", 
                       XMLELEMENT ( "PrimaryKey",               
                                     XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                     'http://www.oracle.com/Employee.xsd' AS
                                                     "xsi:nonamespaceSchemaLocation" ),
                                     XMLForest( v_bank_micr_format_ftr_row.MICR_FORMAT_ID MICR_FORMAT_ID
                                               ,v_bank_micr_format_ftr_row.BANK_ACCOUNT_NBR BANK_ACCOUNT_NBR
                                               ,v_bank_micr_format_ftr_row.FUTURE_ID FUTURE_ID
                                              )) AS "primaryKey"
                                          ,('|' || v_bank_micr_format_ftr_row.MICR_FORMAT_ID ||
                                            '|' || v_bank_micr_format_ftr_row.BANK_ACCOUNT_NBR  || 
                                            '|' || v_bank_micr_format_ftr_row.FUTURE_ID  || '|') transaction_id					
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
                , 'BANK_MICR_FORMAT_FUTURE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_BANK_MICR_FORMAT_FTR_DEL');
     
END TR_BANK_MICR_FORMAT_FTR_DEL;

