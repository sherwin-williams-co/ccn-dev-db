/* this block is to update effective_date column in Polling table */

DECLARE
    CNT NUMBER;
    CURSOR CUR IS SELECT DISTINCT COST_CENTER_CODE FROM POLLING;
BEGIN
    FOR REC IN CUR LOOP
        SELECT COUNT(POLLING_STATUS_CODE)
          INTO CNT 
          FROM POLLING
         WHERE COST_CENTER_CODE = REC.COST_CENTER_CODE;
        
        IF CNT = 1 THEN
           UPDATE POLLING 
              SET EFFECTIVE_DATE = SYSDATE
            WHERE POLLING_STATUS_CODE = 'I'
              AND COST_CENTER_CODE = REC.COST_CENTER_CODE ;
        END IF;
        
        IF CNT = 2  THEN 
           UPDATE POLLING
              SET EFFECTIVE_DATE = SYSDATE
            WHERE POLLING_STATUS_CODE = 'Q'
              AND COST_CENTER_CODE = REC.COST_CENTER_CODE;
         
           UPDATE POLLING 
              SET EFFECTIVE_DATE =  SYSDATE - 1 
            WHERE POLLING_STATUS_CODE = 'I'
              AND COST_CENTER_CODE = REC.COST_CENTER_CODE;
        END IF;
         
        IF CNT = 3  THEN 
            UPDATE POLLING
               SET EFFECTIVE_DATE = SYSDATE
             WHERE POLLING_STATUS_CODE = 'P'
               AND COST_CENTER_CODE = REC.COST_CENTER_CODE;
            
            UPDATE POLLING
               SET EFFECTIVE_DATE = SYSDATE - 1
             WHERE POLLING_STATUS_CODE = 'Q'
              AND COST_CENTER_CODE = REC.COST_CENTER_CODE;
            
            UPDATE POLLING
               SET EFFECTIVE_DATE = SYSDATE - 2
             WHERE POLLING_STATUS_CODE = 'I'
               AND COST_CENTER_CODE  = REC.COST_CENTER_CODE;
        END IF;
        
     END LOOP;
    COMMIT;
END;