create or replace TRIGGER TR_NON_TAXWARE_RATES_USA_UPD
/**********************************************************
created : 09/11/2017  rxv940 CCN Project Team....
Modified: 11/10/2017 rxv940 CCN Project Team....
        : Changed condition for processing Dates
**********************************************************/
BEFORE INSERT OR UPDATE ON COSTCNTR.NON_TAXWARE_RATES_USA
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW
DECLARE

    v_transaction_id            varchar2(500);
    v_rowdata                   sys.xmltype;
    v_primaryKey                sys.xmltype;
    v_non_taxware_rates_usa_row NON_TAXWARE_RATES_USA%ROWTYPE;
     
BEGIN

    v_non_taxware_rates_usa_row.COUNTRY_CODE         := :NEW.COUNTRY_CODE;
    v_non_taxware_rates_usa_row.STATEMENT_TYPE       := :NEW.STATEMENT_TYPE;      
    v_non_taxware_rates_usa_row.TAX_TYPE             := :NEW.TAX_TYPE;
    v_non_taxware_rates_usa_row.TAX_CODE             := :NEW.TAX_CODE;
    v_non_taxware_rates_usa_row.TAX_RATE             := :NEW.TAX_RATE;
    v_non_taxware_rates_usa_row.TAX_RATE_DESCRIPTION := :NEW.TAX_RATE_DESCRIPTION;
    v_non_taxware_rates_usa_row.REGISTRATION_NUMBER  := :NEW.REGISTRATION_NUMBER;
    v_non_taxware_rates_usa_row.EFFECTIVE_DATE       := :NEW.EFFECTIVE_DATE;
    v_non_taxware_rates_usa_row.EXPIRATION_DATE      := :NEW.EXPIRATION_DATE;
    v_non_taxware_rates_usa_row.STATE_CODE           := :NEW.STATE_CODE;

    BEGIN
    
        IF INSERTING THEN
            POS_DATA_GENERATION_NON_TAXWAR.POS_TRG_EVENT_LOG(v_non_taxware_rates_usa_row.COUNTRY_CODE,
                                                            'NON_TAXWARE_RATES',
                                                            'ADD',
                                                            'POS_NON_TXWR_RT_UPDATE'
                                                            );
        ELSIF UPDATING THEN
            IF NVL(:OLD.TAX_CODE,'-99999999')              <> NVL(:NEW.TAX_CODE,'-99999999') OR 
               NVL(:OLD.TAX_RATE,'-99.999')                <> NVL(:NEW.TAX_RATE,'-99.999') OR
               NVL(:OLD.TAX_RATE_DESCRIPTION,'XXX')        <> NVL(:NEW.TAX_RATE_DESCRIPTION,'XXX') OR
               NVL(:OLD.REGISTRATION_NUMBER,'-99999999')   <> NVL(:NEW.REGISTRATION_NUMBER,'-99999999') OR
               NVL(:OLD.COUNTRY_CODE,'XXX')                <> NVL(:NEW.COUNTRY_CODE,'XXX') OR
               NVL(:OLD.STATE_CODE,'XX')                   <> NVL(:NEW.STATE_CODE,'XX') OR
               NVL(:OLD.STATEMENT_TYPE,'XX')               <> NVL(:NEW.STATEMENT_TYPE,'XX') OR               
               NVL(:OLD.TAX_TYPE,'XXX')                    <> NVL(:NEW.TAX_TYPE,'XXX') OR               
               NVL(:OLD.EFFECTIVE_DATE, '12-JAN-1112')     <> NVL(:NEW.EFFECTIVE_DATE, '12-JAN-1112')  OR 
               NVL(:OLD.EXPIRATION_DATE, '12-JAN-1112')    <> NVL(:NEW.EXPIRATION_DATE,'12-JAN-1112')  THEN     
               
                   POS_DATA_GENERATION_NON_TAXWAR.POS_TRG_EVENT_LOG(v_non_taxware_rates_usa_row.COUNTRY_CODE,
                                                                   'NON_TAXWARE_RATES', 
                                                                   'CHANGE', 
                                                                   'POS_NON_TXWR_RT_UPDATE'
                                                                   );
            END IF;
    
        END IF;

    EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                   'TR_NON_TAXWARE_RATES_USA_UPD',
                                   SQLERRM,
                                   v_non_taxware_rates_usa_row.COUNTRY_CODE
                                   );
    END;
END TR_NON_TAXWARE_RATES_USA_UPD;