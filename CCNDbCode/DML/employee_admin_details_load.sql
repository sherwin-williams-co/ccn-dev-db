SET SERVEROUTPUT ON;
BEGIN
    
    --lock all users out
    CCN_BATCH_PKG.LOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION;
    
    FOR rec IN (SELECT DISTINCT SUBSTR(GEMS_ID_NUMBER,3) GEMS_ID_NUMBER, 
                                COST_CENTER_CODE,
                                TO_DATE(DECODE(EFFECTIVE_DATE,'00000000',
                                               NULL,
                                               EFFECTIVE_DATE),
                                        'RRRRMMDD') EFFECTIVE_DATE,
                                TO_DATE(DECODE(EXPIRATION_DATE,'00000000',
                                               NULL,
                                               EXPIRATION_DATE),
                                        'RRRRMMDD') EXPIRATION_DATE
                 FROM TEMP_EMPLOYEE_POSITION_DETAILS
                WHERE EMPLOYEE_JOB_CODE = 'ADMIN') LOOP
        BEGIN
            INSERT INTO EMPLOYEE_ADMIN_DETAILS (EMPLOYEE_NUMBER,
                                                ADMIN_COST_CENTER_CODE,
                                                EFFECTIVE_DATE,
                                                EXPIRATION_DATE,
                                                ADMIN_JOB_CODE)
                                                VALUES(rec.GEMS_ID_NUMBER,
                                                      rec.COST_CENTER_CODE,
                                                      rec.EFFECTIVE_DATE,
                                                      rec.EXPIRATION_DATE,
                                                      'ADMIN');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(rec.COST_CENTER_CODE || '-' || rec.GEMS_ID_NUMBER || '-' || SQLERRM);
        END;
    END LOOP;
    
    UPDATE EMPLOYEE_ADMIN_DETAILS A
       SET (EMPLOYEE_FIRST_NAME, EMPLOYEE_LAST_NAME, EMPLOYEE_MIDDLE_NAME, JOB_TYPE, DESCRIPTION)
           = (SELECT FIRST_NAME, LAST_NAME, MIDDLE_INITIAL, JOB_TYPE, NULL
                FROM EMPLOYEE_DETAILS
               WHERE EMPLOYEE_NUMBER = A.EMPLOYEE_NUMBER
                 AND ROWNUM < 2);
                 
    UPDATE AUDIT_LOG
       SET AUDIT_REC_FLAG = 'R'
     WHERE TABLE_NAME IN ('EMPLOYEE_ADMIN_DETAILS');
    
COMMIT;

    --unlock all users
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION; 
    
END;