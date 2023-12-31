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
      ( RECORDS FIXED 69
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
