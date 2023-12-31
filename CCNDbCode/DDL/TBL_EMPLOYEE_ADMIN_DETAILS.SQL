BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE EMPLOYEE_ADMIN_DETAILS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

  CREATE TABLE EMPLOYEE_ADMIN_DETAILS 
   (	EMPLOYEE_NUMBER VARCHAR2(9),
	ADMIN_COST_CENTER_CODE VARCHAR2(6),
	EFFECTIVE_DATE DATE,
	EXPIRATION_DATE DATE,
	ADMIN_JOB_CODE VARCHAR2(5) DEFAULT 'ADMIN',
	EMPLOYEE_FIRST_NAME VARCHAR2(20),
	EMPLOYEE_LAST_NAME VARCHAR2(20),
	EMPLOYEE_MIDDLE_NAME VARCHAR2(2),
	CONSTRAINT EMP_ADMIN_PK PRIMARY KEY (EMPLOYEE_NUMBER,ADMIN_COST_CENTER_CODE,EFFECTIVE_DATE) ENABLE,
	CONSTRAINT EMP_ADMIN_FK1 FOREIGN KEY (EMPLOYEE_NUMBER)
	 REFERENCES EMPLOYEE_DETAILS (EMPLOYEE_NUMBER) ENABLE,
	CONSTRAINT EMP_ADMIN_FK2 FOREIGN KEY (ADMIN_COST_CENTER_CODE)
	 REFERENCES COST_CENTER (COST_CENTER_CODE) ENABLE
   );
