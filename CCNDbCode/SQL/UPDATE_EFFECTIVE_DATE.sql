/* this block is to update effective_date and expiration_date column in Polling table based on conditions */
DECLARE
    V_DATE DATE;
BEGIN
    FOR rec IN (SELECT * FROM POLLING WHERE CURRENT_FLAG = 'Y') LOOP
        V_DATE := SYSDATE;
        UPDATE POLLING
           SET EFFECTIVE_DATE = V_DATE
         WHERE COST_CENTER_CODE    = rec.COST_CENTER_CODE
           AND POLLING_STATUS_CODE = rec.POLLING_STATUS_CODE;
        FOR in_rec IN (SELECT *
                         FROM POLLING
                        WHERE COST_CENTER_CODE = rec.COST_CENTER_CODE
                          AND CURRENT_FLAG <> 'Y'
                        ORDER BY DECODE(POLLING_STATUS_CODE, 'I', 1, DECODE(POLLING_STATUS_CODE, 'Q', 2, 3)) DESC) LOOP
            V_DATE := V_DATE - 1;
            UPDATE POLLING
               SET EFFECTIVE_DATE  = V_DATE,
                   EXPIRATION_DATE = V_DATE + 1
             WHERE COST_CENTER_CODE    = rec.COST_CENTER_CODE
               AND POLLING_STATUS_CODE = in_rec.POLLING_STATUS_CODE;
        END LOOP;
        COMMIT;
    END LOOP;
END;