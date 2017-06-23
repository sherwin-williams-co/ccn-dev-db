CREATE OR REPLACE TRIGGER TR_DT_STORE_DEL BEFORE DELETE ON DISPATCH_TERMINAL REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
   /***************************************************************************
   TR_DT_STORE_DEL.TRG
   This trigger will insert records into error_log table for logging deletion changes
   on Dispatch terminal table. This is in addition to the existing audit trigger TR_DISAPTCH_TERMINAL_DEL on the table
   The purpose is to disable backfeed for DISPATCH_terminal and send the backfeed on DISPATCH_TERMINAL TO MAinframe as A "STORE" record.
   Created : 06/23/2017 rxa457
   ****************************************************************************/
DECLARE
    V_USERNAME     VARCHAR2(10);
    V_TEXT         CLOB;
BEGIN
    --Get the User Name from system OS Context
    SELECT SYS_CONTEXT('USERENV', 'OS_USER') INTO V_USERNAME FROM DUAL;
    --Get the Primary Key Data
    V_TEXT := :OLD.COST_CENTER_CODE;
    ERRPKG.INSERT_ERROR_LOG_SP('000000','TR_DT_STORE_DEL','USER '||V_USERNAME||' HAS DELETED RECORD - '||SUBSTR(V_TEXT,1,450),'DELETE');
END;

