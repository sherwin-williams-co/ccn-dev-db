/*
Below script created to move all the store drafts that are unattached (terminal number on them is Null) 
from STORE_DRAFTS table back to UNATTACHED_MNL_DRFT_DTL table
Also remove the records from UNATTACHED_MNL_DRFT_DTL_HST from them and clean up the stop pay details.

Created : 03/03/2017 gxg192 CCN Project Team....
Changed : 03/03/2017 gxg192 Changes to set few fields if STOP_PAY_MARKED_BY_CCN_IND is Y
*/
SET SERVEROUTPUT ON
DECLARE
    CURSOR STOREDRAFT_CLNUP_CUR
    IS
    SELECT * 
      FROM STORE_DRAFTS 
     WHERE TERMINAL_NUMBER IS NULL;

    rec_cnt      NUMBER := 0;
    rec_clnd_cnt NUMBER := 0;

BEGIN

    FOR rec IN STOREDRAFT_CLNUP_CUR LOOP

        rec_cnt := rec_cnt + 1;

        BEGIN

            IF rec.STOP_PAY_MARKED_BY_CCN_IND = 'Y' THEN
                rec.VOID_INDICATOR := 'N';
                rec.PAY_INDICATOR  := 'N';
                rec.STOP_INDICATOR := 'N';
                rec.OPEN_INDICATOR := 'Y';
                rec.STOP_PAY_DATE  := NULL;
                rec.STOP_PAY_MARKED_BY_CCN_IND := NULL;
            END IF;
            
            --Insert into UNATTACHED_MNL_DRFT_DTL table
            INSERT INTO UNATTACHED_MNL_DRFT_DTL VALUES rec;
            
            --Delete from UNATTACHED_MNL_DRFT_DTL_HST table
            DELETE FROM UNATTACHED_MNL_DRFT_DTL_HST
             WHERE CHECK_SERIAL_NUMBER = rec.CHECK_SERIAL_NUMBER;
             
            --Delete from STORE_DRAFTS table
            DELETE FROM STORE_DRAFTS
             WHERE CHECK_SERIAL_NUMBER = rec.CHECK_SERIAL_NUMBER; 

            rec_clnd_cnt := rec_clnd_cnt + 1;
            
            IF MOD(rec_clnd_cnt,500) = 0 THEN
                COMMIT;
            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'STOREDRFT_CLEANUP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           NVL(rec.CHECK_SERIAL_NUMBER,'')||':'||
                                           NVL(rec.TRANSACTION_DATE,'')||':'||
                                           NVL(rec.STOP_INDICATOR,''));
        END;
    END LOOP;
    
    COMMIT;

    dbms_output.put_line('Total number of records to be cleaned up = ' ||rec_cnt);
    dbms_output.put_line('Number of records successfully cleaned up = '||rec_clnd_cnt);
    
EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                   'STOREDRFT_CLEANUP',
                                   SQLERRM,
                                   '000000',
                                   '0000000000');
END;