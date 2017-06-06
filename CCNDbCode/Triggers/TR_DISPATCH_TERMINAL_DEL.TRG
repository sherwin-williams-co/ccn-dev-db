CREATE OR REPLACE TRIGGER TR_DISPATCH_TERMINAL_DEL BEFORE DELETE ON DISPATCH_TERMINAL REFERENCING NEW AS NEW OLD AS OLD FOR EACH ROW
/**********************************************************
created : rxa457 -- 4/12/2017
Handle error log during record deletion
**********************************************************/
DECLARE
    V_USERNAME     VARCHAR2(10);
    V_TEXT         CLOB;
BEGIN
    --Get the User Name from system OS Context
    SELECT SYS_CONTEXT('USERENV', 'OS_USER') INTO V_USERNAME FROM DUAL;
    --Get the Primary Key Data
    V_TEXT := :OLD.COST_CENTER_CODE;
    ERRPKG.INSERT_ERROR_LOG_SP('000000','TR_DISPATCH_TERMINAL_DEL','USER '||V_USERNAME||' HAS DELETED RECORD - '||SUBSTR(V_TEXT,1,450),'DELETE');
END;

/

