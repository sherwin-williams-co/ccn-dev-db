/*
Temporary tables:
	TEMP_EMPLOYEE_POSITION_DETAILS
		CCN99CTR_EMPPOS.TXT
	TEMP_EMPLOYEE_DETAILS
		CCN99CTR_EMPS.TXT
*/
--below intermediate tables are for performance improvement, will be dropped once the process completes
CREATE TABLE TEMP_EMPLOYEE_POS_DETAILS_T AS SELECT * FROM TEMP_EMPLOYEE_POSITION_DETAILS;
CREATE TABLE TEMP_EMPLOYEE_DETAILS_T AS SELECT * FROM TEMP_EMPLOYEE_DETAILS;
CREATE INDEX TEMP_EMPLOYEE_POS_DETAILS_TIND ON TEMP_EMPLOYEE_POS_DETAILS_T(GEMS_ID_NUMBER);

--delete all the audit records for the tables under consideration - manager_employee, territory_employee, employee_admin_details
DELETE FROM AUDIT_LOG WHERE TABLE_NAME IN ('MANAGER_EMPLOYEE','TERRITORY_EMPLOYEE','EMPLOYEE_ADMIN_DETAILS');
COMMIT;
--truncate the tables under consideration, to reload [manager_employee, territory_employee, employee_admin_details]
TRUNCATE TABLE MANAGER_EMPLOYEE;
TRUNCATE TABLE TERRITORY_EMPLOYEE;
TRUNCATE TABLE EMPLOYEE_ADMIN_DETAILS;
--delete all the records from employee_details, to reload
DELETE FROM EMPLOYEE_DETAILS;
COMMIT;

INSERT INTO EMPLOYEE_DETAILS
SELECT SUBSTR(GEMS_ID_NUMBER,3) EMPLOYEE_NUMBER,
       NULL COST_CENTER_CODE,
       EMPLOYEE_LAST_NAME||','||EMPLOYEE_FIRST_NAME||' '||EMPLOYEE_MIDDLE_NAME EMPLOYEE_NAME,
       EMPLOYEE_LAST_NAME LAST_NAME,
       EMPLOYEE_FIRST_NAME FIRST_NAME,
       EMPLOYEE_MIDDLE_NAME MIDDLE_INITIAL,
       NULL HOME_ADDRESS_LINE1,
       NULL HOME_ADDRESS_LINE2,
       NULL HOME_CITY_STATE,
       NULL HOME_CITY,
       NULL HOME_STATE,
       NULL HOME_POSTAL_CODE,
       NULL HOME_PHONE,
       NULL COMPANY_CODE,
       NULL SEX,
       NULL EMP_PAYROLL_STATUS,
       NULL EMP_ASSIGNMENT_STATUS,
       NULL EMP_DIVISION,
       DECODE(EFFECTIVE_DATE,'00000000',NULL,TO_DATE(EFFECTIVE_DATE,'RRRRMMDD')) HIRE_DATE,
       DECODE(EXPIRATION_DATE,'00000000',NULL,TO_DATE(EXPIRATION_DATE,'RRRRMMDD')) TERM_DATE,
       NULL ADJUSTED_SERVICE_DATE,
       NULL JOB_CODE,
       NULL JOB_DIVISION,
       NULL JOB_FAMILY,
       NULL JOB_TITLE,
       NULL JOB_TYPE,
       NULL JOB_LEVEL,
       NULL JOB_FUNCTION,
       NULL DAD_CODE,
       FULL_PART_CODE FULL_PART_CODE
  FROM TEMP_EMPLOYEE_DETAILS_T
 WHERE EXPIRATION_DATE <> '00000000';
 /*WHERE NOT EXISTS (SELECT *
                     FROM EMPLOYEE_DETAILS
                    WHERE EMPLOYEE_NUMBER = SUBSTR(GEMS_ID_NUMBER,3));*/
COMMIT;

--below call will populate employee_details, manager_employee, territory_employee from view
EXEC CCN_EMPLOYEE_DETAILS_PKG.SYNC_EMPLOYEE_DETAILS();

--load employee_admin_details details from the file sent from mainframe
SET SERVEROUTPUT ON
BEGIN
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
                 FROM TEMP_EMPLOYEE_POS_DETAILS_T
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
    COMMIT;
END;
/

SET SERVEROUTPUT ON;
BEGIN
   FOR rec IN (SELECT GEMS_ID_NUMBER,
                      NULL COST_CENTER_CODE,
                      DECODE(EFFECTIVE_DATE,'00000000',NULL,TO_DATE(EFFECTIVE_DATE,'RRRRMMDD')) EFFECTIVE_DATE,
                      EMPLOYEE_FIRST_NAME,
                      EMPLOYEE_LAST_NAME,
                      EMPLOYEE_MIDDLE_NAME,
                      EMPLOYEE_STATE_CODE,
                      FULL_PART_CODE,
                      NULL EMP_JOB_CODE,
                      NULL EMP_PAYROLL_STATUS,
                      DECODE(EXPIRATION_DATE,'00000000',NULL,TO_DATE(EXPIRATION_DATE,'RRRRMMDD')) EXPIRATION_DATE
                 FROM TEMP_EMPLOYEE_DETAILS_T
                WHERE EXPIRATION_DATE <> '00000000') LOOP
       BEGIN
           FOR rec2 IN (select COST_CENTER_CODE
                          from TEMP_EMPLOYEE_POS_DETAILS_T 
                         where GEMS_ID_NUMBER = rec.GEMS_ID_NUMBER
                         ORDER BY DECODE(EXPIRATION_DATE,'00000000',NULL,TO_DATE(EXPIRATION_DATE,'RRRRMMDD')) desc) LOOP
               rec.COST_CENTER_CODE := rec2.COST_CENTER_CODE;
               EXIT;
           END LOOP;
           rec.GEMS_ID_NUMBER   := SUBSTR(rec.GEMS_ID_NUMBER,3);
           --Manager checks
           FOR rec1 IN (SELECT * FROM MANAGER_EMPLOYEE WHERE GEMS_ID_NUMBER = rec.GEMS_ID_NUMBER) LOOP
                IF NVL(rec1.GEMS_ID_NUMBER,'X')                 <> NVL(rec.GEMS_ID_NUMBER,'X')
                   OR NVL(rec1.COST_CENTER_CODE,'X')            <> NVL(rec.COST_CENTER_CODE,'X') 
                   OR NVL(rec1.EFFECTIVE_DATE,TRUNC(SYSDATE))   <> NVL(rec.EFFECTIVE_DATE, TRUNC(SYSDATE))
                   OR UPPER(NVL(rec1.EMPLOYEE_FIRST_NAME,'X'))  <> UPPER(NVL(rec.EMPLOYEE_FIRST_NAME,'X'))
                   OR UPPER(NVL(rec1.EMPLOYEE_LAST_NAME,'X'))   <> UPPER(NVL(rec.EMPLOYEE_LAST_NAME,'X')) 
                   OR UPPER(NVL(rec1.EMPLOYEE_MIDDLE_NAME,'X')) <> UPPER(NVL(rec.EMPLOYEE_MIDDLE_NAME,'X'))
                   OR UPPER(NVL(rec1.STATE_CD,'X'))             <> UPPER(NVL(rec.EMPLOYEE_STATE_CODE,'X'))
                   OR UPPER(NVL(rec1.FULL_PART_CODE,'X'))       <> UPPER(NVL(rec.FULL_PART_CODE,'X'))
                   --OR UPPER(NVL(rec1.EMP_JOB_CODE,'X'))         <> UPPER(NVL(rec.EMP_JOB_CODE,'X'))
                   --OR UPPER(NVL(rec1.EMP_PAYROLL_STATUS,'X'))   <> UPPER(NVL(rec.EMP_PAYROLL_STATUS,'X'))
                   OR NVL(rec1.TERM_DATE, TRUNC(SYSDATE))       <> NVL(rec.EXPIRATION_DATE, TRUNC(SYSDATE)) THEN
                   rec.COST_CENTER_CODE   := NVL(rec.COST_CENTER_CODE,rec1.COST_CENTER_CODE);
                   rec.EMP_JOB_CODE       := rec1.EMP_JOB_CODE;
                   rec.EMP_PAYROLL_STATUS := rec1.EMP_PAYROLL_STATUS;
                   DELETE
                     FROM AUDIT_LOG
                    WHERE TRANSACTION_ID LIKE '%'||rec1.GEMS_ID_NUMBER||'%'
                      AND TABLE_NAME = 'MANAGER_EMPLOYEE';
                   UPDATE MANAGER_EMPLOYEE
                      SET ROW = rec
                    WHERE GEMS_ID_NUMBER = rec1.GEMS_ID_NUMBER;
                END IF;
           END LOOP;
           --Territory checks
           FOR rec1 IN (SELECT * FROM TERRITORY_EMPLOYEE WHERE GEMS_ID_NUMBER = rec.GEMS_ID_NUMBER) LOOP
                IF NVL(rec1.GEMS_ID_NUMBER,'X')                 <> NVL(rec.GEMS_ID_NUMBER,'X')
                   OR NVL(rec1.COST_CENTER_CODE,'X')            <> NVL(rec.COST_CENTER_CODE,'X') 
                   OR NVL(rec1.EFFECTIVE_DATE,TRUNC(SYSDATE))   <> NVL(rec.EFFECTIVE_DATE, TRUNC(SYSDATE))
                   OR UPPER(NVL(rec1.EMPLOYEE_FIRST_NAME,'X'))  <> UPPER(NVL(rec.EMPLOYEE_FIRST_NAME,'X'))
                   OR UPPER(NVL(rec1.EMPLOYEE_LAST_NAME,'X'))   <> UPPER(NVL(rec.EMPLOYEE_LAST_NAME,'X')) 
                   OR UPPER(NVL(rec1.EMPLOYEE_MIDDLE_NAME,'X')) <> UPPER(NVL(rec.EMPLOYEE_MIDDLE_NAME,'X'))
                   OR UPPER(NVL(rec1.STATE_CD,'X'))             <> UPPER(NVL(rec.EMPLOYEE_STATE_CODE,'X'))
                   OR UPPER(NVL(rec1.FULL_PART_CODE,'X'))       <> UPPER(NVL(rec.FULL_PART_CODE,'X'))
                   --OR UPPER(NVL(rec1.EMP_JOB_CODE,'X'))         <> UPPER(NVL(rec.EMP_JOB_CODE,'X'))
                   --OR UPPER(NVL(rec1.EMP_PAYROLL_STATUS,'X'))   <> UPPER(NVL(rec.EMP_PAYROLL_STATUS,'X'))
                   OR NVL(rec1.TERM_DATE, TRUNC(SYSDATE))       <> NVL(rec.EXPIRATION_DATE, TRUNC(SYSDATE)) THEN
                   rec.COST_CENTER_CODE   := NVL(rec.COST_CENTER_CODE,rec1.COST_CENTER_CODE);
                   rec.EMP_JOB_CODE       := rec1.EMP_JOB_CODE;
                   rec.EMP_PAYROLL_STATUS := rec1.EMP_PAYROLL_STATUS;
                   DELETE
                     FROM AUDIT_LOG
                    WHERE TRANSACTION_ID LIKE '%'||rec1.GEMS_ID_NUMBER||'%'
                      AND TABLE_NAME = 'TERRITORY_EMPLOYEE';
                   UPDATE TERRITORY_EMPLOYEE
                      SET ROW = rec
                    WHERE GEMS_ID_NUMBER = rec1.GEMS_ID_NUMBER;
               END IF;
           END LOOP;
       EXCEPTION WHEN OTHERS THEN
           DBMS_OUTPUT.PUT_LINE(rec.GEMS_ID_NUMBER);
           ROLLBACK;
       END;
       COMMIT;
   END LOOP;
END;
/

UPDATE AUDIT_LOG
   SET AUDIT_REC_FLAG = 'R'
 WHERE TABLE_NAME IN ('MANAGER_EMPLOYEE','TERRITORY_EMPLOYEE','EMPLOYEE_ADMIN_DETAILS');

COMMIT;

DROP TABLE TEMP_EMPLOYEE_POS_DETAILS_T;
DROP TABLE TEMP_EMPLOYEE_DETAILS_T;
--DROP INDEX TEMP_EMPLOYEE_POS_DETAILS_TIND;

EXEC CCN_EMPLOYEE_DETAILS_PKG.SYNC_EMPLOYEE_DETAILS();

/*
SELECT TABLE_NAME, COUNT(*)
  FROM (SELECT DISTINCT TABLE_NAME,
               TRANSACTION_ID
          FROM AUDIT_LOG
         WHERE AUDIT_REC_FLAG IS NULL
           AND TABLE_NAME IN ('MANAGER_EMPLOYEE','TERRITORY_EMPLOYEE')
           AND (TRANSACTION_DATE >= (SELECT MAX(BATCH_JOB_LAST_RUN_DATE)
                                       FROM BATCH_JOB
                                      WHERE BATCH_JOB_NAME = 'BACKFEED_AUDIT_LOG')
            OR NVL(GLOBAL_HIERARCHY_SKIP_FLAG,'N') = 'Y'))
 GROUP BY TABLE_NAME;

SELECT * FROM ERROR_LOG WHERE TRUNC(ERROR_DATE) = TRUNC(SYSDATE);
*/
