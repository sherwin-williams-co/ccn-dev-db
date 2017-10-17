/*
Below script will update the audit log to make sure these missed records are picked by next audit run

Created : 10/17/2017 jxc517 CCN Project Team....
Changed :
*/

DECLARE
    v_logid NUMBER;
BEGIN
    FOR rec IN (SELECT A.*, rowid
                  FROM AUDIT_LOG A
                 WHERE TRANSACTION_DATE BETWEEN TO_DATE('26-SEP-2017 12:00:01','DD-MON-YYYY HH24:MI:SS') AND TO_DATE('26-SEP-2017 15:42:24','DD-MON-YYYY HH24:MI:SS')
                   AND AUDIT_REC_FLAG IS NULL
                   AND NOT EXISTS (SELECT 1
                                     FROM AUDIT_LOG
                                    WHERE TRANSACTION_ID   = A.TRANSACTION_ID
                                      AND TABLE_NAME       = A.TABLE_NAME
                                       AND AUDIT_REC_FLAG   = 'R'
                                      AND TRANSACTION_DATE >= A.TRANSACTION_DATE)
                 ORDER BY LOG_ID) LOOP
        SELECT NVL(MAX(LOG_ID), 0) + 1
          INTO v_logid
          FROM AUDIT_LOG;
        UPDATE AUDIT_LOG SET LOG_ID = v_logid WHERE rowid = rec.rowid;
    END LOOP;
EXCEPTION
   WHEN OTHERS THEN
       NULL;
END;

--Validate before commiting
COMMIT;
