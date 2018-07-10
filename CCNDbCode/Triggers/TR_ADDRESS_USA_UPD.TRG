create or replace TRIGGER COSTCNTR.TR_ADDRESS_USA_UPD 
/***************************************************************************
   TR_ADDRESS_USA_UPD.TRG
   This trigger will insert records into audit_log table for logging changes
   Created:
   Modified : 10/11/2017 rxa457 CCN Project Team...
              Code added to insert Descartes Address feed trigger action table
   Modified : 11/15/2017 jxc517 CCN Project Team...
              Fixed the code to handle inserts/updates properly
****************************************************************************/
before insert or update ON COSTCNTR.ADDRESS_USA 
referencing old as old new as new 
for each row
DECLARE

    v_transaction_id VARCHAR2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_address_USA_row ADDRESS_USA%ROWTYPE; 
    
begin

    v_address_usa_row.COST_CENTER_CODE  := :NEW.COST_CENTER_CODE;
    v_address_usa_row.ADDRESS_TYPE      := :NEW.ADDRESS_TYPE;
    v_address_usa_row.EFFECTIVE_DATE    := :NEW.EFFECTIVE_DATE;
    v_address_usa_row.EXPIRATION_DATE   := :NEW.EXPIRATION_DATE;
    v_address_usa_row.ADDRESS_LINE_1    := :NEW.ADDRESS_LINE_1;
    v_address_usa_row.ADDRESS_LINE_2    := :NEW.ADDRESS_LINE_2;	
    v_address_usa_row.ADDRESS_LINE_3    := :NEW.ADDRESS_LINE_3;
    v_address_usa_row.CITY              := :NEW.CITY;
    v_address_usa_row.STATE_CODE        := :NEW.STATE_CODE;
    v_address_usa_row.ZIP_CODE          := :NEW.ZIP_CODE;
    v_address_usa_Row.ZIP_CODE_4        := :NEW.ZIP_CODE_4;
    v_address_usa_row.COUNTY            := :NEW.COUNTY;
    v_address_usa_row.FIPS_CODE         := :NEW.FIPS_CODE;
    v_address_usa_row.DESTINATION_POINT := :NEW.DESTINATION_POINT;
    v_address_usa_row.CHECK_DIGIT       := :NEW.CHECK_DIGIT;
    v_address_usa_row.VALID_ADDRESS     := :NEW.VALID_ADDRESS;
    v_address_usa_row.COUNTRY_CODE      := :NEW.COUNTRY_CODE;
    
	
	SELECT XMLELEMENT ( "ADDRESS_USA",               
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
        			          'http://www.oracle.com/Employee.xsd' AS
                    	     	"xsi:nonamespaceSchemaLocation" ),
       		XMLFOREST(
         v_address_usa_row.COST_CENTER_CODE COST_CENTER_CODE
        ,v_address_usa_row.ADDRESS_TYPE ADDRESS_TYPE
        ,to_char(v_address_usa_row.EFFECTIVE_DATE, 'yyyymmdd')  EFFECTIVE_DATE
        ,to_char(v_address_usa_row.EXPIRATION_DATE, 'yyyymmdd')  EXPIRATION_DATE
        ,v_address_usa_row.ADDRESS_LINE_1 ADDRESS_LINE_1
        ,v_address_usa_row.ADDRESS_LINE_2 ADDRESS_LINE_2	
        ,v_address_usa_row.ADDRESS_LINE_3 ADDRESS_LINE_3
        ,v_address_usa_row.CITY CITY
        ,v_address_usa_row.STATE_CODE STATE_CODE
        ,v_address_usa_row.ZIP_CODE ZIP_CODE
        ,v_address_usa_row.ZIP_CODE_4 ZIP_CODE_4
        ,v_address_usa_row.COUNTY COUNTY
        ,v_address_usa_row.FIPS_CODE FIPS_CODE
        ,v_address_usa_row.DESTINATION_POINT DESTINATION_POINT
        ,v_address_usa_row.CHECK_DIGIT CHECK_DIGIT
        ,v_address_usa_row.VALID_ADDRESS VALID_ADDRESS
        ,v_address_usa_row.COUNTRY_CODE COUNTRY_CODE
			)) AS "result"
			,XMLELEMENT ( "PrimaryKey",               
	  			XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                				  'http://www.oracle.com/Employee.xsd' AS
                         			"xsi:nonamespaceSchemaLocation" ),
	       XMLFOREST(
				 v_address_usa_row.COST_CENTER_CODE COST_CENTER_CODE
				,v_address_usa_row.ADDRESS_TYPE ADDRESS_TYPE
				,v_address_usa_row.EFFECTIVE_DATE EFFECTIVE_DATE
			)) AS "primaryKey"
			,('|' || v_address_usa_row.cost_center_code || 
			'|' || v_address_usa_row.ADDRESS_TYPE  || 
			'|' || TO_CHAR(v_address_usa_row.EFFECTIVE_DATE,'DD-MON-YY') || '|') transaction_id
			INTO v_rowdata
			,v_primaryKey
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
                , 'ADDRESS_USA'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_ADDRESS_USA_UPD');
     --END IF;      
BEGIN
IF POS_DATA_GENERATION.CHECK_COST_CENTER_CATEGORY(v_address_usa_Row.COST_CENTER_CODE)='S' AND NVL(:NEW.ADDRESS_TYPE,'XXX') = 'M' THEN
IF INSERTING THEN   
   POS_DATA_GENERATION.POS_TRG_EVENT_LOG(v_address_usa_Row.COST_CENTER_CODE,
                                         'ADDRESS_USA',
                                         'ADD',
                                         'POS_STORE_UPDATE'
                                         );
ELSIF UPDATING THEN
   IF NVL(:OLD.ADDRESS_LINE_1,'XXX') <> NVL(:NEW.ADDRESS_LINE_1,'XXX') OR
      NVL(:OLD.ADDRESS_LINE_2,'XXX') <> NVL(:NEW.ADDRESS_LINE_2,'XXX') OR
      NVL(:OLD.ADDRESS_LINE_3,'XXX') <> NVL(:NEW.ADDRESS_LINE_3,'XXX') OR
      NVL(:OLD.CITY,'XXX')           <> NVL(:NEW.CITY,'XXX')           OR
      NVL(:OLD.STATE_CODE,'XXX')     <> NVL(:NEW.STATE_CODE,'XXX')     OR
      NVL(:OLD.ZIP_CODE,'XXX')       <> NVL(:NEW.ZIP_CODE,'XXX')
      THEN
         POS_DATA_GENERATION.POS_TRG_EVENT_LOG(v_address_usa_Row.COST_CENTER_CODE,
                                               'ADDRESS_USA',
                                               'CHANGE',
                                               'POS_STORE_UPDATE'
                                               );
   END IF;
END IF;
END IF;
---START -- CODE TO HANDLE DESCARTES ADDRESS FEED 
IF :NEW.EXPIRATION_DATE IS NULL AND NVL(:NEW.ADDRESS_TYPE,'XXX') = 'M' THEN
    IF UPDATING THEN
        IF NVL(:NEW.COUNTRY_CODE,'XXX')   <> NVL(:OLD.COUNTRY_CODE,'XXX')   OR
           NVL(:NEW.ZIP_CODE,'XXX')       <> NVL(:OLD.ZIP_CODE,'XXX')       OR
           NVL(:NEW.STATE_CODE,'XXX')     <> NVL(:OLD.STATE_CODE,'XXX')     OR
           NVL(:NEW.CITY,'XXX')           <> NVL(:OLD.CITY,'XXX')           OR
           NVL(:NEW.ADDRESS_LINE_1,'XXX') <> NVL(:OLD.ADDRESS_LINE_1,'XXX') OR
           NVL(:NEW.ADDRESS_LINE_2,'XXX') <> NVL(:OLD.ADDRESS_LINE_2,'XXX') THEN
            CCN_DESCARTES_PROCESS.INSERT_DESCARTES_ADRS_FEED_CC(:NEW.COST_CENTER_CODE);
        END IF;
    ELSIF INSERTING THEN
       CCN_DESCARTES_PROCESS.INSERT_DESCARTES_ADRS_FEED_CC(:NEW.COST_CENTER_CODE);
    END IF;
END IF;
---END-- CODE TO HANDLE DESCARTES ADDRESS FEED
EXCEPTION
WHEN OTHERS THEN
ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                           'TR_ADDRESS_USA_UPD',
                           SQLERRM,
                           v_address_usa_Row.COST_CENTER_CODE
                           );
END;
end  TR_ADDRESS_USA_UPD;