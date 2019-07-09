/********************************************************************************** 
This script is used to populate the DESIGNATED_TERMINAL_NUMBER Column of STORE
Table with the first assigned value of TERMINAL_NUMBER Column from
the TERMINAL Table.

Run this script in COSTCNTR Schema

Created : 07/08/2019 axm868 CCN Project CCNCC-2....
Modified: 
**********************************************************************************/
SET SERVEROUTPUT ON SIZE UNLIMITED
DECLARE
    V_BULK_LOAD_LKUP_ID               NUMBER;
BEGIN
    POS_DATA_GENERATION.SET_FLAG_POLLING_BULK_LOADS('CCNCC2_BULK_STORE_DESG_TML_NBR_LOAD', V_BULK_LOAD_LKUP_ID);
    FOR C1 IN (SELECT COST_CENTER_CODE FROM COST_CENTER WHERE CATEGORY = 'S') LOOP
        UPDATE STORE S
           SET S.DESIGNATED_TERMINAL_NUMBER = (SELECT LPAD(TO_CHAR(MIN(TO_NUMBER(T.TERMINAL_NUMBER))), 5, '0')
                                                 FROM TERMINAL T
                                               WHERE /*T.EXPIRATION_DATE IS NULL
                                               AND */T.COST_CENTER_CODE = C1.COST_CENTER_CODE
                                               AND EXISTS (SELECT 1
                                                             FROM POLLING P
                                                           WHERE P.COST_CENTER_CODE = T.COST_CENTER_CODE
                                                             AND P.POLL_STATUS_EXP_DT IS NULL
                                                             AND P.POLLING_STATUS_CODE = T.POLLING_STATUS_CODE))
        WHERE COST_CENTER_CODE = C1.COST_CENTER_CODE;
        COMMIT;
    END LOOP;
    POS_DATA_GENERATION.RESET_FLAG_POLLING_BULK_LOADS(V_BULK_LOAD_LKUP_ID);
EXCEPTION
    WHEN OTHERS THEN
        -- The below call to reset the flag should always be the first line of the exception block
        -- If re-set doesn't happen, polling process will be turned off for that duration. By putting
	    -- this call in the first line of exception block we make sure no other errors blocks the reset process	 
        POS_DATA_GENERATION.RESET_FLAG_POLLING_BULK_LOADS(V_BULK_LOAD_LKUP_ID);
        -- Logging of error
        errpkg.raise_err(SQLCODE, substr(SQLERRM,1, 500) ||'  CCNCC2_BULK_STORE_DESG_TML_NBR_LOAD '  || ' errors found');
END;