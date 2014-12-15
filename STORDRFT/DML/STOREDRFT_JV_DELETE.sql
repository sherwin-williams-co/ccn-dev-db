/*-------------------------------------------------------------------------------------
 Anonymous Block to delete all data whose date is not max date from STOREDRFT_JV table
--------------------------------------------------------------------------------------*/
DECLARE
    CURSOR JV_CUR IS SELECT UPDATE_DATE 
                       FROM STOREDRFT_JV
                      WHERE UPDATE_DATE <> (SELECT MAX(UPDATE_DATE) FROM STOREDRFT_JV);
    V_COMMIT NUMBER:=0;    
BEGIN
    FOR JV_REC IN JV_CUR LOOP
        DELETE FROM STOREDRFT_JV 
        WHERE UPDATE_DATE = JV_REC.UPDATE_DATE;

        V_COMMIT := V_COMMIT + 1;
        
        IF V_COMMIT > 1000 THEN
            COMMIT;
            V_COMMIT := 0;
        END IF; 
    END LOOP;
	COMMIT;
END;
/