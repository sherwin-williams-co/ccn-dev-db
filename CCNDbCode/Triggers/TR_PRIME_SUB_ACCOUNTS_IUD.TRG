create or replace TRIGGER TR_PRIME_SUB_ACCOUNTS_IUD
   /***************************************************************************
   ***
   TR_PRIME_SUB_ACCOUNTS_IUD.TRG
   This trigger will insert records into POS_DOWNLOADS_GL_PS table for logging changes
   happened on GEN_LEDGE_ACCOUNTS table.
   Created : 03/31/2017 rxv940 CCN Project....
   ****************************************************************************
   **/
BEFORE INSERT OR UPDATE OR DELETE ON GL_PRIME_SUB_ACCOUNT_DTLS
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

    BEGIN
        IF INSERTING THEN
            PRIME_SUB_PROCESS.POS_TRG_EVENT_LOG(:NEW.GL_PS_ACCOUNT_NUMBER, 'GL_ACCNT_NBR', 'ADD', 'POS_PRIMESUB_UPDATE' );
        ELSIF UPDATING THEN 
            IF :OLD.GL_PS_ACCOUNT_NUMBER               <>       :NEW.GL_PS_ACCOUNT_NUMBER        OR
               :OLD.PROGRAM_NAME                       <>       :NEW.PROGRAM_NAME                OR
               NVL(:OLD.SORTED_SEQUENCE, '999999')     <>  NVL(:NEW.SORTED_SEQUENCE, '999999')   OR
               NVL(:OLD.SHARED, 'XXX')                 <> NVL(:NEW.SHARED, 'XXX')                 THEN  
                   PRIME_SUB_PROCESS.POS_TRG_EVENT_LOG(NVL(:NEW.GL_PS_ACCOUNT_NUMBER, :OLD.GL_PS_ACCOUNT_NUMBER), 'GL_ACCNT_NBR', 'CHANGE', 'POS_PRIMESUB_UPDATE' );
            END IF;
        ELSE
            PRIME_SUB_PROCESS.POS_TRG_EVENT_LOG(:OLD.GL_PS_ACCOUNT_NUMBER, 'GL_ACCNT_NBR', 'DELETE', 'POS_PRIMESUB_UPDATE' );
        END IF;
    EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE, 'TR_PRIME_SUB_ACCOUNTS_IUD', SQLERRM, NVL(:NEW.GL_PS_ACCOUNT_NUMBER, :OLD.GL_PS_ACCOUNT_NUMBER));
    END TR_PRIME_SUB_ACCOUNTS_IUD;