DECLARE

	  v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primarykey sys.xmltype;
    v_polling_dwld_rsn_hist_row polling_dwld_rsn_hist%rowtype; 
    
BEGIN

/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      FROM AUDIT_LOG;             
*/

		v_polling_dwld_rsn_hist_row.cost_center_code           := :new.cost_center_code;
		v_polling_dwld_rsn_hist_row.polling_status_code        := :new.polling_status_code;
		v_polling_dwld_rsn_hist_row.effective_date             := :new.effective_date;
		v_polling_dwld_rsn_hist_row.download_date              := :new.download_date;
		v_polling_dwld_rsn_hist_row.pos_download_reason        := :new.pos_download_reason;
	
	SELECT XMLELEMENT (  "POLLING_DWLD_RSN_HIST",
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	 "xsi:nonamespaceSchemaLocation" ),
       		XMLForest(
				 v_polling_dwld_rsn_hist_row.cost_center_code      cost_center_code
				,v_polling_dwld_rsn_hist_row.polling_status_code   polling_status_code
				,to_char(v_polling_dwld_rsn_hist_row.EFFECTIVE_DATE, 'yyyymmdd')   EFFECTIVE_DATE
				,to_char(v_polling_dwld_rsn_hist_row.DOWNLOAD_DATE, 'yyyymmdd')    DOWNLOAD_DATE
		    ,v_polling_dwld_rsn_hist_row.pos_download_reason   pos_download_reason
        )) AS  "result"
        
			,XMLELEMENT (  "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			 "xsi:nonamespaceSchemaLocation" ),
	       XMLFOREST(         
				 v_polling_dwld_rsn_hist_row.cost_center_code           cost_center_code
        ,v_polling_dwld_rsn_hist_row.polling_status_code        polling_status_code
        ,v_polling_dwld_rsn_hist_row.effective_date             effective_date
			)) AS  "primaryKey",
      
      ('|' || V_POLLING_DWLD_RSN_HIST_ROW.COST_CENTER_CODE || 
       '|' || V_POLLING_DWLD_RSN_HIST_ROW.POLLING_STATUS_CODE || --'|') transaction_id
       '|' || TO_CHAR(v_polling_dwld_rsn_hist_row.effective_date,'DD-MON-YY') || '|') transaction_id
			INTO v_rowdata
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
                , sysdate
                , 'POLLING_DWLD_RSN_HIST'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_POLLING_DWLD_RSN_HIST_UPD');
     --END IF;      
      
END TR_POLLING_DWLD_RSN_HIST_UPD;
/

