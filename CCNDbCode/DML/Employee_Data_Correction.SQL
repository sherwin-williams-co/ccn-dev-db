--ALTER TABLE EMPLOYEE_DETAILS ADD FULL_PART_CODE VARCHAR2(1);
--EMPLOYEE_DETAILS_ROWTYPE_SP
--SYNC_HR_EMPLOYEE_DETAILS
--SYNC_MANAGER_EMPLOYEE_DTLS
--SYNC_TERRITORY_EMPLOYEE_DTLS
/*
GRANT SELECT ON EMPLOYEE_DETAILS TO STORDRFT;
GRANT SELECT ON EMPLOYEE_DETAILS TO CCN_UTILITY;
CREATE OR REPLACE SYNONYM EMPLOYEE_DETAILS FOR COSTCNTR.EMPLOYEE_DETAILS; --in both CCN_UTILITY and STORDRFT
*/
BEGIN
    COMMON_TOOLS.ALTER_ALL_TRIGGERS('DISABLE');

    FOR REC IN (SELECT * FROM EMPLOYEE_DETAILS) LOOP
        UPDATE EMPLOYEE_DETAILS
           SET FULL_PART_CODE = (SELECT DECODE(EMPLOYMENT_CATEGORY,'Full Time','F',
                                                                   'Part Time','P',
                                                                   NULL) FULL_PART_CODE
                                   FROM SWC_HR_GENERIC_V
                                  WHERE EMPLOYEE_NUMBER = rec.EMPLOYEE_NUMBER
                                    AND ROWNUM < 2)
         WHERE EMPLOYEE_NUMBER = rec.EMPLOYEE_NUMBER;
    END LOOP;
    COMMIT;

    FOR REC IN (SELECT * FROM MANAGER_EMPLOYEE) LOOP
        FOR REC1 IN (SELECT * FROM EMPLOYEE_DETAILS WHERE EMPLOYEE_NUMBER = REC.GEMS_ID_NUMBER) LOOP
            UPDATE MANAGER_EMPLOYEE
               SET EMP_JOB_CODE = (SELECT JOB_CODE
                                     FROM JOB_CODE_TRANSALATION
                                    WHERE UPPER(JOB_TITLE_SEGMENT) = UPPER(REC1.JOB_TITLE) 
                                      AND UPPER(JOB_FAMILY_SEGMENT) = UPPER(REC1.JOB_FAMILY)
                                      AND UPPER(ORG_UNIT_NAME) LIKE '%' ||UPPER(REC1.JOB_TYPE) ||'%'
                                      AND ROWNUM < 2),
                   FULL_PART_CODE = REC1.FULL_PART_CODE
             WHERE GEMS_ID_NUMBER = REC.GEMS_ID_NUMBER;
        END LOOP;
    END LOOP;
    COMMIT;

    FOR REC IN (SELECT * FROM TERRITORY_EMPLOYEE) LOOP
        FOR REC1 IN (SELECT * FROM EMPLOYEE_DETAILS WHERE EMPLOYEE_NUMBER = REC.GEMS_ID_NUMBER) LOOP
            UPDATE TERRITORY_EMPLOYEE
               SET EMP_JOB_CODE = (SELECT JOB_CODE
                                     FROM JOB_CODE_TRANSALATION
                                    WHERE UPPER(JOB_TITLE_SEGMENT) = UPPER(REC1.JOB_TITLE) 
                                      AND UPPER(JOB_FAMILY_SEGMENT) = UPPER(REC1.JOB_FAMILY)
                                      AND UPPER(ORG_UNIT_NAME) LIKE '%' ||UPPER(REC1.JOB_TYPE) ||'%'
                                      AND ROWNUM < 2),
                   FULL_PART_CODE = REC1.FULL_PART_CODE
             WHERE GEMS_ID_NUMBER = REC.GEMS_ID_NUMBER;
        END LOOP;
    END LOOP;
    COMMIT;

    COMMON_TOOLS.ALTER_ALL_TRIGGERS('ENABLE');
END;
/

DECLARE
PROCEDURE tr_manager_employee_upd (v_manager_employee_row IN manager_employee%rowtype)
    IS
    v_transaction_id         varchar2(500);
    v_rowdata                sys.xmltype;
    v_primarykey             sys.xmltype;
    
BEGIN
    SELECT XMLELEMENT ( "MANAGER_EMPLOYEE",
                        XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                        'http://www.oracle.com/Employee.xsd' AS
                                        "xsi:nonamespaceSchemaLocation" ),
                        XMLFOREST(v_manager_employee_row.gems_id_number                        GEMS_ID_NUMBER
                                  ,v_manager_employee_row.cost_center_code                     COST_CENTER_CODE
                                  ,to_char(v_manager_employee_row.effective_date, 'yyyymmdd')  EFFECTIVE_DATE
                                  ,v_manager_employee_row.employee_first_name                  EMPLOYEE_FIRST_NAME
                                  ,v_manager_employee_row.employee_last_name                   EMPLOYEE_LAST_NAME
                                  ,v_manager_employee_row.employee_middle_name                 EMPLOYEE_MIDDLE_NAME
                                  ,v_manager_employee_row.state_cd                             STATE_CD
                                  ,v_manager_employee_row.full_part_code                       FULL_PART_CODE
                                  ,v_manager_employee_row.emp_job_code                         EMP_JOB_CODE
                                  ,v_manager_employee_row.emp_payroll_status                   EMP_PAYROLL_STATUS
                                  ,to_char(v_manager_employee_row.term_date, 'yyyymmdd')       TERM_DATE
                                  )) AS "result",
                        XMLELEMENT ( "PrimaryKey",
                                     XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                     'http://www.oracle.com/Employee.xsd' AS
                                                     "xsi:nonamespaceSchemaLocation" ),
                                     XMLFOREST(v_manager_employee_row.gems_id_number           GEMS_ID_NUMBER)) AS "primaryKey",
                        ('|' || v_manager_employee_row.gems_id_number || '|') tran_id
      INTO V_ROWDATA
           ,v_primarykey
           ,v_transaction_id
      FROM DUAL;

          INSERT INTO audit_log
               (log_id
               , transaction_id
               , transaction_date
               , table_name
               , table_pk_value
               , table_row_data
               , change_by)
          VALUES
               ((SELECT NVL(MAX(LOG_ID), 0) + 1 FROM AUDIT_LOG),
                v_transaction_id
                , sysdate
                , 'MANAGER_EMPLOYEE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_MANAGER_EMPLOYEE_UPD');
END tr_manager_employee_upd;

PROCEDURE tr_territory_employee_upd(v_territory_employee_row IN territory_employee%rowtype)
IS
    v_transaction_id         varchar2(500);
    v_rowdata                sys.xmltype;
    v_primarykey             sys.xmltype;
BEGIN
    SELECT XMLELEMENT ( "TERRITORY_EMPLOYEE",
                        XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                        'http://www.oracle.com/Employee.xsd' AS
                                        "xsi:nonamespaceSchemaLocation" ),
                        XMLFOREST(v_territory_employee_row.gems_id_number                        GEMS_ID_NUMBER
                                  ,v_territory_employee_row.cost_center_code                     COST_CENTER_CODE
                                  ,to_char(v_territory_employee_row.effective_date, 'yyyymmdd')  EFFECTIVE_DATE
                                  ,v_territory_employee_row.employee_first_name                  EMPLOYEE_FIRST_NAME
                                  ,v_territory_employee_row.employee_last_name                   EMPLOYEE_LAST_NAME
                                  ,v_territory_employee_row.employee_middle_name                 EMPLOYEE_MIDDLE_NAME
                                  ,v_territory_employee_row.state_cd                             STATE_CD
                                  ,v_territory_employee_row.full_part_code                       FULL_PART_CODE
                                  ,v_territory_employee_row.emp_job_code                         EMP_JOB_CODE
                                  ,v_territory_employee_row.emp_payroll_status                   EMP_PAYROLL_STATUS
                                  ,to_char(v_territory_employee_row.term_date, 'yyyymmdd')       TERM_DATE
                                  )) AS "result",
                        XMLELEMENT ( "PrimaryKey",
                                     XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                     'http://www.oracle.com/Employee.xsd' AS
                                                     "xsi:nonamespaceSchemaLocation" ),
                                     XMLFOREST(v_territory_employee_row.gems_id_number           GEMS_ID_NUMBER)) AS "primaryKey",
                        ('|' || v_territory_employee_row.gems_id_number || '|') tran_id
      INTO V_ROWDATA
           ,v_primarykey
           ,v_transaction_id
      FROM DUAL;

          INSERT INTO audit_log
               (log_id
               , transaction_id
               , transaction_date
               , table_name
               , table_pk_value
               , table_row_data
               , change_by)
          VALUES
               ((SELECT NVL(MAX(LOG_ID), 0) + 1 FROM AUDIT_LOG),
                v_transaction_id
                , sysdate
                , 'TERRITORY_EMPLOYEE'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_TERRITORY_EMPLOYEE_UPD');
END tr_territory_employee_upd;
BEGIN
   COMMON_TOOLS.ALTER_ALL_TRIGGERS('DISABLE');
   FOR rec IN (SELECT SUBSTR(GEMS_ID_NUMBER,3) GEMS_ID_NUMBER,
                      NULL COST_CENTER_CODE,
                      DECODE(EFFECTIVE_DATE,'00000000',NULL,TO_DATE(EFFECTIVE_DATE,'RRRRMMDD')) EFFECTIVE_DATE,
                      EMPLOYEE_FIRST_NAME,
                      EMPLOYEE_LAST_NAME,
                      EMPLOYEE_MIDDLE_NAME,
                      DECODE(EXPIRATION_DATE,'00000000',NULL,TO_DATE(EXPIRATION_DATE,'RRRRMMDD')) EXPIRATION_DATE,
                      FULL_PART_CODE,
                      EMPLOYEE_STATE_CODE
                 FROM TEMP_EMPLOYEE_DETAILS) LOOP
       FOR rec2 IN (select COST_CENTER_CODE
                      from TEMP_EMPLOYEE_POSITION_DETAILS 
                     where SUBSTR(GEMS_ID_NUMBER,3) = rec.GEMS_ID_NUMBER
                     ORDER BY DECODE(EXPIRATION_DATE,'00000000',NULL,TO_DATE(EXPIRATION_DATE,'RRRRMMDD')) desc) LOOP
           rec.COST_CENTER_CODE := rec2.COST_CENTER_CODE;
           EXIT;
       END LOOP;
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
               OR UPPER(NVL(rec1.EMP_JOB_CODE,'X'))         <> UPPER(NVL(NULL,'X'))
               --OR UPPER(NVL(rec1.EMP_PAYROLL_STATUS,'X')) <> UPPER(NVL(rec.,'X'))
               OR NVL(rec1.TERM_DATE, TRUNC(SYSDATE))       <> NVL(rec.EXPIRATION_DATE, TRUNC(SYSDATE)) THEN
               DELETE
                 FROM AUDIT_LOG
                WHERE TRANSACTION_ID LIKE '%'||rec1.GEMS_ID_NUMBER||'%'
                  AND TABLE_NAME = 'MANAGER_EMPLOYEE';
               UPDATE MANAGER_EMPLOYEE
                  SET ROW = rec1
                WHERE GEMS_ID_NUMBER = rec1.GEMS_ID_NUMBER;
               IF NVL(rec1.COST_CENTER_CODE,'X') = NVL(rec.COST_CENTER_CODE,'X') THEN
                   rec1.COST_CENTER_CODE := '      ';
               END IF;
               IF NVL(rec1.EFFECTIVE_DATE,TRUNC(SYSDATE)) = NVL(rec.EFFECTIVE_DATE, TRUNC(SYSDATE)) THEN
                   rec1.EFFECTIVE_DATE := NULL;
               END IF;
               IF UPPER(NVL(rec1.EMPLOYEE_FIRST_NAME,'X')) = UPPER(NVL(rec.EMPLOYEE_FIRST_NAME,'X')) THEN
                   rec1.EMPLOYEE_FIRST_NAME := NULL;
               END IF;
               IF UPPER(NVL(rec1.EMPLOYEE_LAST_NAME,'X')) = UPPER(NVL(rec.EMPLOYEE_LAST_NAME,'X')) THEN
                   rec1.EMPLOYEE_LAST_NAME := NULL;
               END IF;
               IF UPPER(NVL(rec1.EMPLOYEE_MIDDLE_NAME,'X')) = UPPER(NVL(rec.EMPLOYEE_MIDDLE_NAME,'X')) THEN
                   rec1.EMPLOYEE_MIDDLE_NAME := NULL;
               END IF;
               IF UPPER(NVL(rec1.STATE_CD,'X')) = UPPER(NVL(rec.EMPLOYEE_STATE_CODE,'X')) THEN
                   rec1.STATE_CD := NULL;
               END IF;
               IF UPPER(NVL(rec1.FULL_PART_CODE,'X')) = UPPER(NVL(rec.FULL_PART_CODE,'X')) THEN
                   rec1.FULL_PART_CODE := NULL;
               END IF;
               IF NVL(rec1.TERM_DATE,TRUNC(SYSDATE)) = NVL(rec.EXPIRATION_DATE, TRUNC(SYSDATE)) THEN
                   rec1.TERM_DATE := NULL;
               END IF;
               tr_manager_employee_upd(rec1);
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
               OR UPPER(NVL(rec1.EMP_JOB_CODE,'X'))         <> UPPER(NVL(NULL,'X'))
               --OR UPPER(NVL(rec1.EMP_PAYROLL_STATUS,'X')) <> UPPER(NVL(rec.,'X'))
               OR NVL(rec1.TERM_DATE, TRUNC(SYSDATE))       <> NVL(rec.EXPIRATION_DATE, TRUNC(SYSDATE)) THEN
               DELETE
                 FROM AUDIT_LOG
                WHERE TRANSACTION_ID LIKE '%'||rec1.GEMS_ID_NUMBER||'%'
                  AND TABLE_NAME = 'TERRITORY_EMPLOYEE';
               UPDATE TERRITORY_EMPLOYEE
                  SET ROW = rec1
                WHERE GEMS_ID_NUMBER = rec1.GEMS_ID_NUMBER;
               IF NVL(rec1.COST_CENTER_CODE,'X') = NVL(rec.COST_CENTER_CODE,'X') THEN
                   rec1.COST_CENTER_CODE := '      ';
               END IF;
               IF NVL(rec1.EFFECTIVE_DATE,TRUNC(SYSDATE)) = NVL(rec.EFFECTIVE_DATE, TRUNC(SYSDATE)) THEN
                   rec1.EFFECTIVE_DATE := NULL;
               END IF;
               IF UPPER(NVL(rec1.EMPLOYEE_FIRST_NAME,'X')) = UPPER(NVL(rec.EMPLOYEE_FIRST_NAME,'X')) THEN
                   rec1.EMPLOYEE_FIRST_NAME := NULL;
               END IF;
               IF UPPER(NVL(rec1.EMPLOYEE_LAST_NAME,'X')) = UPPER(NVL(rec.EMPLOYEE_LAST_NAME,'X')) THEN
                   rec1.EMPLOYEE_LAST_NAME := NULL;
               END IF;
               IF UPPER(NVL(rec1.EMPLOYEE_MIDDLE_NAME,'X')) = UPPER(NVL(rec.EMPLOYEE_MIDDLE_NAME,'X')) THEN
                   rec1.EMPLOYEE_MIDDLE_NAME := NULL;
               END IF;
               IF UPPER(NVL(rec1.STATE_CD,'X')) = UPPER(NVL(rec.EMPLOYEE_STATE_CODE,'X')) THEN
                   rec1.STATE_CD := NULL;
               END IF;
               IF UPPER(NVL(rec1.FULL_PART_CODE,'X')) = UPPER(NVL(rec.FULL_PART_CODE,'X')) THEN
                   rec1.FULL_PART_CODE := NULL;
               END IF;
               IF NVL(rec1.TERM_DATE,TRUNC(SYSDATE)) = NVL(rec.EXPIRATION_DATE, TRUNC(SYSDATE)) THEN
                   rec1.TERM_DATE := NULL;
               END IF;
               tr_territory_employee_upd(rec1);
           END IF;
       END LOOP;
       COMMIT;
   END LOOP;
   COMMON_TOOLS.ALTER_ALL_TRIGGERS('ENABLE');
END;
/
