-- This is a fix to update the polling request ID
-- This creates a new polling record for CC 721107 (to fix Ellen issue regarding the prev req ids for PARAM)
-- created by rxv940 on 10/30/2017
-- run in utils

SET SERVEROUTPUT ON 
BEGIN 

    DELETE FROM POS_DOWNLOADS 
    WHERE POS_ID = 39757;
    DBMS_OUTPUT.PUT_LINE('Delete Completed ...');
    -- Deleting the record 

    INSERT
    INTO POS_DOWNLOADS(POS_ID
                       ,COST_CENTER_CODE
                       ,DATA_SOURCE
                       ,DATA_OPERATION
                       ,FILE_TYPE
                       ,FILE_PROCESSED
                       ,CREATE_DT)
    VALUES (SEQ_POS_DOWNLOADS.NEXTVAL
            ,'721107'
            ,'BANK_CARD'
            ,'ADD'
            ,'POS_PARAM_UPDATE'
            ,'N'
            ,SYSDATE);

    DBMS_OUTPUT.PUT_LINE('Insert Completed ...');

    UPDATE POS_DOWNLOADS
    SET PREREQ_EQUIV_RQST_ID = CHR(13) 
    WHERE POS_ID = 42853;
    -- Update for today prod failure
    DBMS_OUTPUT.PUT_LINE('Update Completed ...');
    
    COMMIT;
    
    POS_DATA_GENERATION.POS_MASTER_SP('721107');

END;