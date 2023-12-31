create or replace TRIGGER TR_GEN_LEDGE_ACCOUNTS_IUD
   /***************************************************************************
   ***
   TR_GEN_LEDGE_ACCOUNTS_IUD.TRG
   This trigger will insert records into POS_DOWNLOADS_GL_PS table for logging changes
   happened on GEN_LEDGE_ACCOUNTS table.
   Created : 03/31/2017 rxv940 CCN Project....
   ****************************************************************************
   **/
BEFORE INSERT OR UPDATE OR DELETE ON GENERAL_LEDGER_ACCOUNTS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

    BEGIN
        IF INSERTING THEN 
            PRIME_SUB_PROCESS.POS_TRG_EVENT_LOG(NVL(:NEW.GL_ACCOUNT_NUMBER, :OLD.GL_ACCOUNT_NUMBER), 'GL_ACCNT_NBR', 'ADD', 'POS_PRIMESUB_UPDATE' );
        ELSIF UPDATING THEN
            IF  :OLD.GL_ACCOUNT_NUMBER           <>       :NEW.GL_ACCOUNT_NUMBER OR
                NVL(:OLD.DESCRIPTION, 'XXX')     <>       NVL(:NEW.DESCRIPTION, 'XXX') OR
                NVL(:OLD.PROFIT_OR_LOSS, 'XXX')  <>       NVL(:NEW.PROFIT_OR_LOSS, 'XXX') THEN
                    PRIME_SUB_PROCESS.POS_TRG_EVENT_LOG(NVL(:NEW.GL_ACCOUNT_NUMBER, :OLD.GL_ACCOUNT_NUMBER), 'GL_ACCNT_NBR', 'CHANGE', 'POS_PRIMESUB_UPDATE' );
            END IF;
        ELSE 
            PRIME_SUB_PROCESS.POS_TRG_EVENT_LOG(NVL(:NEW.GL_ACCOUNT_NUMBER, :OLD.GL_ACCOUNT_NUMBER), 'GL_ACCNT_NBR', 'DELETE', 'POS_PRIMESUB_UPDATE' );
        END IF;
    END;