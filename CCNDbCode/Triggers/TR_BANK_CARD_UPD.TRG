CREATE OR REPLACE TRIGGER TR_BANK_CARD_UPD 
before insert or update on BANK_CARD 
referencing old as old new as new 
for each row 

DECLARE

    v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_bank_card_row BANK_CARD%ROWTYPE; 
    
BEGIN
/*
SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/
--This trigger code should be executed only if the corresponding data changes
--If the data got manipulated by osme other table changes we should not consider that for audit_log
IF NVL(CCN_TABLE_IU_PKG.TRIGGER_DISABLE_FLAG,'N') = 'N' THEN
    v_bank_card_row.COST_CENTER_CODE      := :NEW.COST_CENTER_CODE;
    v_bank_card_row.POLLING_STATUS_CODE   := :NEW.POLLING_STATUS_CODE;
    v_bank_card_row.MERCHANT_ID           := :NEW.MERCHANT_ID;
    v_bank_card_row.EFFECTIVE_DATE        := :NEW.EFFECTIVE_DATE;
    v_bank_card_row.EXPIRATION_DATE       := :NEW.EXPIRATION_DATE;
    v_bank_card_row.LAST_MAINT_DATE       := :NEW.LAST_MAINT_DATE;
    v_bank_card_row.LAST_MAINT_METHOD_ID  := :NEW.LAST_MAINT_METHOD_ID;
    v_bank_card_row.LAST_MAINT_USER_ID    := :NEW.LAST_MAINT_USER_ID;
    v_bank_card_row.QUALITY_CODE          := :NEW.QUALITY_CODE;
    v_bank_card_row.AMEX_SE_ID            := :NEW.AMEX_SE_ID;
    v_bank_card_row.DISCOVER_ID           := :NEW.DISCOVER_ID;
			
	SELECT XMLELEMENT ( "BANK_CARD",               
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		XMLForest(
                   v_bank_card_row.COST_CENTER_CODE COST_CENTER_CODE
	                ,v_bank_card_row.POLLING_STATUS_CODE POLLING_STATUS_CODE
                	,v_bank_card_row.MERCHANT_ID MERCHANT_ID
                  ,to_char(v_bank_card_row.EFFECTIVE_DATE, 'yyyymmdd')  EFFECTIVE_DATE
                  ,to_char(v_bank_card_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE
                  ,to_char(v_bank_card_row.LAST_MAINT_DATE, 'yyyymmdd')  LAST_MAINT_DATE
                 	,v_bank_card_row.LAST_MAINT_METHOD_ID LAST_MAINT_METHOD_ID
                	,v_bank_card_row.LAST_MAINT_USER_ID LAST_MAINT_USER_ID
                	,v_bank_card_row.QUALITY_CODE QUALITY_CODE
                	,v_bank_card_row.AMEX_SE_ID AMEX_SE_ID
                	,v_bank_card_row.DISCOVER_ID DISCOVER_ID
        
			)) AS "result"
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLForest(
	       	            v_bank_card_row.COST_CENTER_CODE COST_CENTER_CODE
		           ,v_bank_card_row.POLLING_STATUS_CODE POLLING_STATUS_CODE
                                               --,v_bank_card_row.MERCHANT_ID MERCHANT_ID
                                               ,v_bank_card_row.EFFECTIVE_DATE EFFECTIVE_DATE
                                                   )) AS "primaryKey",
      ('|' || V_BANK_CARD_ROW.COST_CENTER_CODE || 
       '|' || V_BANK_CARD_ROW.POLLING_STATUS_CODE || 
       --'|' || v_bank_card_row.MERCHANT_ID|| --'|')      as tran_id
       '|' || TO_CHAR(V_BANK_CARD_ROW.EFFECTIVE_DATE,'DD-MON-YY')  || '|')      as tran_id
			INTO V_ROWDATA
			,V_PRIMARYKEY
      ,v_transaction_id
			FROM DUAL;	
         
        
     /* -- for   Column -- */
     --IF (:OLD.CATEGORY != :NEW.CATEGORY) THEN

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
                , 'BANK_CARD'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_BANK_CARD_UPD');
     --END IF;      
END IF;
END  TR_BANK_CARD_UPD;

