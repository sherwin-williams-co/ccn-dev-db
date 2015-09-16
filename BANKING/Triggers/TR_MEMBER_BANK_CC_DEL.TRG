CREATE OR REPLACE TRIGGER TR_MEMBER_BANK_CC_DEL
BEFORE DELETE ON MEMBER_BANK_CC 
REFERENCING OLD AS OLD NEW AS NEW
FOR EACH ROW

DECLARE

	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_member_bank_cc_row member_bank_cc%ROWTYPE;
   
begin
         v_member_bank_cc_row.LEAD_BANK_ACCOUNT_NBR := :OLD.LEAD_BANK_ACCOUNT_NBR;
         v_member_bank_cc_row.LEAD_STORE_NBR        := :OLD.LEAD_STORE_NBR;
         v_member_bank_cc_row.MEMBER_STORE_NBR      := :OLD.MEMBER_STORE_NBR;
         v_member_bank_cc_row.EFFECTIVE_DATE        := :OLD.EFFECTIVE_DATE;
         v_member_bank_cc_row.EXPIRATION_DATE       := :OLD.EXPIRATION_DATE;
         v_member_bank_cc_row.MEMBER_BANK_ACCOUNT_NBR := :OLD.MEMBER_BANK_ACCOUNT_NBR;
         v_member_bank_cc_row.BANK_BRANCH_NBR  := :OLD.BANK_BRANCH_NBR;
         v_member_bank_cc_row.UPDATE_DATE      := :OLD.UPDATE_DATE;
         v_member_bank_cc_row.LAST_UPD_USER_ID := :OLD.LAST_UPD_USER_ID;
         
	SELECT XMLELEMENT ( "MEMBER_BANK_CC",               
		  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                      'http://www.oracle.com/Employee.xsd' AS
                      "xsi:nonamespaceSchemaLocation" ),
                      XMLFOREST( 'Delete' UPD_TYPE
                                ,v_member_bank_cc_row.LEAD_BANK_ACCOUNT_NBR LEAD_BANK_ACCOUNT_NBR
                                ,v_member_bank_cc_row.LEAD_STORE_NBR LEAD_STORE_NBR
                                ,v_member_bank_cc_row.MEMBER_STORE_NBR MEMBER_STORE_NBR
                                ,to_char(v_member_bank_cc_row.EFFECTIVE_DATE, 'yyyymmdd') EFFECTIVE_DATE
                                ,to_char(v_member_bank_cc_row.EXPIRATION_DATE, 'yyyymmdd') EXPIRATION_DATE
                                ,v_member_bank_cc_row.MEMBER_BANK_ACCOUNT_NBR MEMBER_BANK_ACCOUNT_NBR
                                ,v_member_bank_cc_row.BANK_BRANCH_NBR BANK_BRANCH_NBR
                                ,to_char(v_member_bank_cc_row.UPDATE_DATE, 'yyyymmdd') UPDATE_DATE
                                ,v_member_bank_cc_row.LAST_UPD_USER_ID LAST_UPD_USER_ID
                                )) AS "result", 
                      XMLELEMENT ( "PrimaryKey",               
                                   XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                    'http://www.oracle.com/Employee.xsd' AS
                                                    "xsi:nonamespaceSchemaLocation" ),
                                   XMLFOREST( v_member_bank_cc_row.LEAD_BANK_ACCOUNT_NBR LEAD_BANK_ACCOUNT_NBR
                                             ,v_member_bank_cc_row.LEAD_STORE_NBR LEAD_STORE_NBR
                                             ,v_member_bank_cc_row.MEMBER_STORE_NBR MEMBER_STORE_NBR
                                            )) AS "primaryKey"
                                            ,('|' || v_member_bank_cc_row.LEAD_BANK_ACCOUNT_NBR || 
                                              '|' || v_member_bank_cc_row.LEAD_STORE_NBR ||
                                              '|' || v_member_bank_cc_row.MEMBER_STORE_NBR  || '|') transaction_id					
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
                , 'MEMBER_BANK_CC'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_MEMBER_BANK_CC_DEL');
     
END TR_MEMBER_BANK_CC_DEL;

