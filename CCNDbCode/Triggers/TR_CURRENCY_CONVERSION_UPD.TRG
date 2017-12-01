CREATE OR REPLACE TRIGGER TR_CURRENCY_CONVERSION_UPD
/**********************************************************
created : 09/11/2017 rxv940 CCN Project Team....
Modified: 11/10/2017 rxv940 CCN Project Team....
        : Changed condition for processing Dates
**********************************************************/
BEFORE INSERT OR UPDATE ON COSTCNTR.CURRENCY_CONVERSION
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

    v_transaction_id varchar2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;
    v_currency_conv_row CURRENCY_CONVERSION%ROWTYPE;
     
    
BEGIN

    v_currency_conv_row.COUNTRY_CODE      := :NEW.COUNTRY_CODE;
    v_currency_conv_row.EFFECTIVE_DATE    := :NEW.EFFECTIVE_DATE;      
    v_currency_conv_row.EXPIRATION_DATE   := :NEW.EXPIRATION_DATE;
    v_currency_conv_row.CONVERSION_RATE   := :NEW.CONVERSION_RATE;
    v_currency_conv_row.DISPLAY_VAT_FLAG  := :NEW.DISPLAY_VAT_FLAG;
    v_currency_conv_row.CURRENCY_TYPE     := :NEW.CURRENCY_TYPE;
    v_currency_conv_row.TAXID_NUMBER      := :NEW.TAXID_NUMBER;
    v_currency_conv_row.TAXID_DESCRIPTION := :NEW.TAXID_DESCRIPTION;
    v_currency_conv_row.VAT_TAX_ID        := :NEW.VAT_TAX_ID;

    BEGIN
    
        IF INSERTING THEN
            POS_DATA_GENERATION_NON_TAXWAR.POS_TRG_EVENT_LOG(v_currency_conv_row.COUNTRY_CODE,
                                                            'CURRENCY_CONVERSION',
                                                            'ADD',
                                                            'POS_NON_TXWR_RT_UPDATE',
                                                            NULL
                                                            );
        ELSIF UPDATING THEN
            IF NVL(:OLD.DISPLAY_VAT_FLAG,'XXX')         <>       NVL(:NEW.DISPLAY_VAT_FLAG,'XXX')         OR 
               NVL(:OLD.CURRENCY_TYPE,'XXX')            <>       NVL(:NEW.CURRENCY_TYPE,'XXX')            OR
               NVL(:OLD.TAXID_NUMBER,'XXX')             <>       NVL(:NEW.TAXID_NUMBER,'XXX')             OR
               NVL(:OLD.TAXID_DESCRIPTION,'XXX')        <>       NVL(:NEW.TAXID_DESCRIPTION,'XXX')        OR
               NVL(:OLD.VAT_TAX_ID,'XXX')               <>       NVL(:NEW.VAT_TAX_ID,'XXX')               OR
               NVL(:OLD.CONVERSION_RATE,'-99.999')      <>       NVL(:NEW.CONVERSION_RATE,'-99.999')      OR
               NVL(:OLD.COUNTRY_CODE, 'XXX')            <>       NVL(:NEW.COUNTRY_CODE, 'XXX')            OR
               NVL(:OLD.EFFECTIVE_DATE, '12-JAN-1112')  <>       NVL(:NEW.EFFECTIVE_DATE, '12-JAN-1112')  OR 
               NVL(:OLD.EXPIRATION_DATE, '12-JAN-1112') <>       NVL(:NEW.EXPIRATION_DATE,'12-JAN-1112')  THEN       
                   POS_DATA_GENERATION_NON_TAXWAR.POS_TRG_EVENT_LOG(v_currency_conv_row.COUNTRY_CODE,'CURRENCY_CONVERSION', 'CHANGE', 'POS_NON_TXWR_RT_UPDATE', NULL);
            END IF;
    
        END IF;

    EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                   'TR_CURRENCY_CONVERSION_UPD',
                                   SQLERRM,
                                   v_currency_conv_row.COUNTRY_CODE
                                   );
    END;
END TR_CURRENCY_CONVERSION_UPD;