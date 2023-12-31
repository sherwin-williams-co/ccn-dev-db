BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TEMP_EMPLOYEE_DETAILS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

  CREATE TABLE TEMP_EMPLOYEE_DETAILS 
     (	GEMS_ID_NUMBER VARCHAR2(9 BYTE), 
  	EFFECTIVE_DATE VARCHAR2(8 BYTE), 
  	EXPIRATION_DATE VARCHAR2(8 BYTE), 
  	EMPLOYEE_FIRST_NAME VARCHAR2(12 BYTE), 
  	EMPLOYEE_MIDDLE_NAME VARCHAR2(2 BYTE), 
  	EMPLOYEE_LAST_NAME VARCHAR2(17 BYTE), 
  	EMPLOYEE_STATE_CODE VARCHAR2(2 BYTE), 
  	LAST_WORKED_DATE VARCHAR2(8 BYTE), 
  	FULL_PART_CODE VARCHAR2(1 BYTE)
     ) 
     ORGANIZATION EXTERNAL 
      ( TYPE ORACLE_LOADER
        DEFAULT DIRECTORY CCN_LOAD_FILES
        ACCESS PARAMETERS
        ( RECORDS DELIMITED BY NEWLINE
          badfile CCN_LOAD_FILES:'TEMP_EMPLOYEE_DETAILS.bad'
          logfile CCN_LOAD_FILES:'TEMP_EMPLOYEE_DETAILS.log'
          discardfile CCN_LOAD_FILES:'TEMP_EMPLOYEE_DETAILS.dsc'
            FIELDS
            missing field values are null
    ( 
      GEMS_ID_NUMBER        CHAR(9), 
      EFFECTIVE_DATE        CHAR(8),
      EXPIRATION_DATE       CHAR(8),
      EMPLOYEE_FIRST_NAME   CHAR(12),
      EMPLOYEE_MIDDLE_NAME  CHAR(2),
      EMPLOYEE_LAST_NAME    CHAR(17),
      EMPLOYEE_STATE_CODE   CHAR(2),
      LAST_WORKED_DATE      CHAR(8),
      FULL_PART_CODE        CHAR(1)
    ) 
                                      )
        LOCATION
         ( 'CCN99CTR_EMPS.TXT'
         )
    );

BEGIN
   FOR rec IN (SELECT SUBSTR(GEMS_ID_NUMBER,3) GEMS_ID_NUMBER,
                      NULL COST_CENTER_CODE,
                      DECODE(EFFECTIVE_DATE,'00000000',NULL,TO_DATE(EFFECTIVE_DATE,'RRRRMMDD')) EFFECTIVE_DATE,
                      EMPLOYEE_FIRST_NAME,
                      EMPLOYEE_LAST_NAME,
                      EMPLOYEE_MIDDLE_NAME,
                      DECODE(EXPIRATION_DATE,'00000000',NULL,TO_DATE(EXPIRATION_DATE,'RRRRMMDD')) EXPIRATION_DATE
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
            IF NVL(rec1.GEMS_ID_NUMBER,'X')          <> NVL(rec.GEMS_ID_NUMBER,'X')
               OR NVL(rec1.COST_CENTER_CODE,'X')     <> NVL(rec.COST_CENTER_CODE,'X') 
               OR NVL(rec1.EFFECTIVE_DATE,TRUNC(SYSDATE)) <> NVL(rec.EFFECTIVE_DATE, TRUNC(SYSDATE))
               OR UPPER(NVL(rec1.EMPLOYEE_FIRST_NAME,'X'))   <> UPPER(NVL(rec.EMPLOYEE_FIRST_NAME,'X'))
               OR UPPER(NVL(rec1.EMPLOYEE_LAST_NAME,'X'))   <> UPPER(NVL(rec.EMPLOYEE_LAST_NAME,'X')) 
               OR UPPER(NVL(rec1.EMPLOYEE_MIDDLE_NAME,'X')) <> UPPER(NVL(rec.EMPLOYEE_MIDDLE_NAME,'X'))
               --OR NVL(V_TEMP_REC.STATE_CD,'X')             <> NVL(rec.HOME_STATE,'X') 
               --WE WILL HAVE NULL THEY WILL HAVE VALUES
               --OR NVL(V_TEMP_REC.FULL_PART_CODE,'X')       <> NVL(rec.FULL_PART_CODE,'X')
               --OR NVL(V_TEMP_REC.EMP_JOB_CODE,'X')         <> NVL(rec.JOB_CODE,'X') 
               --OR NVL(V_TEMP_REC.EMP_PAYROLL_STATUS,'X')   <> NVL(rec.EMP_PAYROLL_STATUS,'X')
               OR NVL(rec1.TERM_DATE, TRUNC(SYSDATE))            <> NVL(rec.EXPIRATION_DATE, TRUNC(SYSDATE))THEN
               UPDATE MANAGER_EMPLOYEE
                  SET ROW = rec1
                WHERE GEMS_ID_NUMBER = rec1.GEMS_ID_NUMBER;
            END IF;
       END LOOP;
       --Territory checks
       FOR rec1 IN (SELECT * FROM TERRITORY_EMPLOYEE WHERE GEMS_ID_NUMBER = rec.GEMS_ID_NUMBER) LOOP
            IF NVL(rec1.GEMS_ID_NUMBER,'X')          <> NVL(rec.GEMS_ID_NUMBER,'X')
               OR NVL(rec1.COST_CENTER_CODE,'X')     <> NVL(rec.COST_CENTER_CODE,'X') 
               OR NVL(rec1.EFFECTIVE_DATE,TRUNC(SYSDATE)) <> NVL(rec.EFFECTIVE_DATE, TRUNC(SYSDATE))
               OR UPPER(NVL(rec1.EMPLOYEE_FIRST_NAME,'X'))   <> UPPER(NVL(rec.EMPLOYEE_FIRST_NAME,'X'))
               OR UPPER(NVL(rec1.EMPLOYEE_LAST_NAME,'X'))   <> UPPER(NVL(rec.EMPLOYEE_LAST_NAME,'X')) 
               OR UPPER(NVL(rec1.EMPLOYEE_MIDDLE_NAME,'X')) <> UPPER(NVL(rec.EMPLOYEE_MIDDLE_NAME,'X'))
               --OR NVL(V_TEMP_REC.STATE_CD,'X')             <> NVL(rec.HOME_STATE,'X') 
               --OR NVL(V_TEMP_REC.FULL_PART_CODE,'X')       <> NVL(rec.FULL_PART_CODE,'X') 
               --OR NVL(V_TEMP_REC.EMP_JOB_CODE,'X')         <> NVL(rec.JOB_CODE,'X') 
               --OR NVL(V_TEMP_REC.EMP_PAYROLL_STATUS,'X')   <> NVL(rec.EMP_PAYROLL_STATUS,'X')
               OR NVL(rec1.TERM_DATE, TRUNC(SYSDATE))            <> NVL(rec.EXPIRATION_DATE, TRUNC(SYSDATE))THEN
               UPDATE TERRITORY_EMPLOYEE
                  SET ROW = rec1
                WHERE GEMS_ID_NUMBER = rec1.GEMS_ID_NUMBER;
            END IF;
       END LOOP;
       COMMIT;
   END LOOP;
END;
/