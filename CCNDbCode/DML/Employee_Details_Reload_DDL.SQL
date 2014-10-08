DROP TABLE MANAGER_EMPLOYEE;
DROP TABLE TERRITORY_EMPLOYEE;
DROP TABLE EMPLOYEE_ADMIN_DETAILS;
DROP TABLE EMPLOYEE_DETAILS;

  CREATE TABLE "COSTCNTR"."EMPLOYEE_DETAILS" 
   (	"EMPLOYEE_NUMBER" VARCHAR2(30), 
	"COST_CENTER_CODE" VARCHAR2(150), 
	"EMPLOYEE_NAME" VARCHAR2(360), 
	"LAST_NAME" VARCHAR2(150), 
	"FIRST_NAME" VARCHAR2(150), 
	"MIDDLE_INITIAL" VARCHAR2(60), 
	"HOME_ADDRESS_LINE1" VARCHAR2(100), 
	"HOME_ADDRESS_LINE2" VARCHAR2(100), 
	"HOME_CITY_STATE" VARCHAR2(60), 
	"HOME_CITY" VARCHAR2(60), 
	"HOME_STATE" VARCHAR2(2), 
	"HOME_POSTAL_CODE" VARCHAR2(9), 
	"HOME_PHONE" VARCHAR2(60), 
	"COMPANY_CODE" VARCHAR2(3), 
	"SEX" VARCHAR2(1), 
	"EMP_PAYROLL_STATUS" VARCHAR2(6), 
	"EMP_ASSIGNMENT_STATUS" VARCHAR2(100), 
	"EMP_DIVISION" VARCHAR2(150), 
	"HIRE_DATE" DATE, 
	"TERM_DATE" DATE, 
	"ADJUSTED_SERVICE_DATE" DATE, 
	"JOB_CODE" VARCHAR2(5), 
	"JOB_DIVISION" VARCHAR2(4), 
	"JOB_FAMILY" VARCHAR2(60), 
	"JOB_TITLE" VARCHAR2(60), 
	"JOB_TYPE" VARCHAR2(60), 
	"JOB_LEVEL" VARCHAR2(60), 
	"JOB_FUNCTION" VARCHAR2(60), 
	"DAD_CODE" VARCHAR2(8), 
	 CONSTRAINT "EMP_DETAILS_PK" PRIMARY KEY ("EMPLOYEE_NUMBER") ENABLE
   ) ;


  GRANT SELECT ON "COSTCNTR"."EMPLOYEE_DETAILS" TO "CCN_UTILITY";
  GRANT SELECT ON "COSTCNTR"."EMPLOYEE_DETAILS" TO "STORDRFT";

  CREATE TABLE "COSTCNTR"."EMPLOYEE_ADMIN_DETAILS" 
   (	"EMPLOYEE_NUMBER" VARCHAR2(30), 
	"ADMIN_COST_CENTER_CODE" VARCHAR2(150), 
	"EFFECTIVE_DATE" DATE, 
	"EXPIRATION_DATE" DATE, 
	"ADMIN_JOB_CODE" VARCHAR2(5) DEFAULT 'ADMIN', 
	"EMPLOYEE_FIRST_NAME" VARCHAR2(150), 
	"EMPLOYEE_LAST_NAME" VARCHAR2(150), 
	"EMPLOYEE_MIDDLE_NAME" VARCHAR2(60), 
	"JOB_TYPE" VARCHAR2(60), 
	"DESCRIPTION" VARCHAR2(150), 
	 CONSTRAINT "EMP_ADMIN_PK" PRIMARY KEY ("EMPLOYEE_NUMBER", "ADMIN_COST_CENTER_CODE", "EFFECTIVE_DATE") ENABLE, 
	 CONSTRAINT "EMP_ADMIN_FK2" FOREIGN KEY ("ADMIN_COST_CENTER_CODE") REFERENCES "COSTCNTR"."COST_CENTER" ("COST_CENTER_CODE") ENABLE, 
	 CONSTRAINT "EMP_ADMIN_FK1" FOREIGN KEY ("EMPLOYEE_NUMBER") REFERENCES "COSTCNTR"."EMPLOYEE_DETAILS" ("EMPLOYEE_NUMBER") ENABLE
   ) ;

  CREATE OR REPLACE TRIGGER "COSTCNTR"."TR_EMPLOYEE_ADMIN_DETAILS_UPD" 
before insert or update on employee_admin_details 
referencing old as old new as new
for each row
DECLARE
    v_transaction_id             varchar2(500);
    v_rowdata                    sys.xmltype;
    v_primarykey                 sys.xmltype;
    v_employee_admin_details_row employee_admin_details%rowtype; 
    
BEGIN

    v_employee_admin_details_row.employee_number        := :new.employee_number;
    v_employee_admin_details_row.admin_cost_center_code := :new.admin_cost_center_code;
    v_employee_admin_details_row.effective_date         := :new.effective_date;
    v_employee_admin_details_row.expiration_date        := :new.expiration_date;
    v_employee_admin_details_row.admin_job_code         := :new.admin_job_code;
    v_employee_admin_details_row.employee_first_name    := :new.employee_first_name;
    v_employee_admin_details_row.employee_last_name     := :new.employee_last_name;
    v_employee_admin_details_row.employee_middle_name   := :new.employee_middle_name;
    v_employee_admin_details_row.job_type               := :new.job_type;
    v_employee_admin_details_row.description            := :new.description;

    SELECT XMLELEMENT ( "EMPLOYEE_ADMIN_DETAILS",
                        XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                        'http://www.oracle.com/Employee.xsd' AS
                                        "xsi:nonamespaceSchemaLocation" ),
                        XMLFOREST(v_employee_admin_details_row.employee_number                       EMPLOYEE_NUMBER
                                  ,v_employee_admin_details_row.admin_cost_center_code               ADMIN_COST_CENTER_CODE
                                  ,to_char(v_employee_admin_details_row.effective_date, 'yyyymmdd')  EFFECTIVE_DATE
                                  ,to_char(v_employee_admin_details_row.expiration_date, 'yyyymmdd') EXPIRATION_DATE
                                  ,v_employee_admin_details_row.admin_job_code                       ADMIN_JOB_CODE
                                  ,v_employee_admin_details_row.employee_first_name                  EMPLOYEE_FIRST_NAME
                                  ,v_employee_admin_details_row.employee_last_name                   EMPLOYEE_LAST_NAME
                                  ,v_employee_admin_details_row.employee_middle_name                 EMPLOYEE_MIDDLE_NAME
                                  ,v_employee_admin_details_row.job_type                             JOB_TYPE
                                  ,v_employee_admin_details_row.description                          DESCRIPTION
                                  )) AS "result",
                         XMLELEMENT ( "PrimaryKey",               
                                      XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                                      'http://www.oracle.com/Employee.xsd' AS
                                                      "xsi:nonamespaceSchemaLocation" ),
                                      XMLForest(
                                              v_employee_admin_details_row.employee_number EMPLOYEE_NUMBER
                                             ,v_employee_admin_details_row.ADMIN_COST_CENTER_CODE ADMIN_COST_CENTER_CODE
                                             ,v_employee_admin_details_row.EFFECTIVE_DATE EFFECTIVE_DATE
                                                   )) AS "primaryKey",
                      ('|' || v_employee_admin_details_row.ADMIN_COST_CENTER_CODE || 
                       '|' || v_employee_admin_details_row.EMPLOYEE_NUMBER || 
                       '|' || TO_CHAR(v_employee_admin_details_row.EFFECTIVE_DATE,'DD-MON-YY')  || '|') as tran_id          
                                  
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
                , 'EMPLOYEE_ADMIN_DETAILS'
                ,v_primaryKey
                ,v_rowdata
                ,'TR_EMPLOYEE_ADMIN_DETAILS_UPD');
END tr_employee_admin_details_upd;
/
ALTER TRIGGER "COSTCNTR"."TR_EMPLOYEE_ADMIN_DETAILS_UPD" ENABLE;
GRANT SELECT ON "COSTCNTR"."EMPLOYEE_ADMIN_DETAILS" TO "CCNUSER";


  CREATE TABLE "COSTCNTR"."TERRITORY_EMPLOYEE" 
   (	"GEMS_ID_NUMBER" VARCHAR2(30), 
	"COST_CENTER_CODE" VARCHAR2(150), 
	"EFFECTIVE_DATE" DATE, 
	"EMPLOYEE_FIRST_NAME" VARCHAR2(150), 
	"EMPLOYEE_LAST_NAME" VARCHAR2(150), 
	"EMPLOYEE_MIDDLE_NAME" VARCHAR2(60), 
	"STATE_CD" VARCHAR2(2), 
	"FULL_PART_CODE" VARCHAR2(1), 
	"EMP_JOB_CODE" VARCHAR2(5), 
	"EMP_PAYROLL_STATUS" VARCHAR2(6), 
	"TERM_DATE" DATE, 
	 CONSTRAINT "TERRITORY_EMPLOYEE_PK" PRIMARY KEY ("GEMS_ID_NUMBER") ENABLE
   ) ;

  CREATE OR REPLACE TRIGGER "COSTCNTR"."TR_TERRITORY_EMPLOYEE_UPD" 
before insert or update on territory_employee 
referencing old as old NEW as NEW
for each row
DECLARE
    v_transaction_id         varchar2(500);
    v_rowdata                sys.xmltype;
    v_primarykey             sys.xmltype;
    v_territory_employee_row territory_employee%rowtype; 
    
BEGIN

    v_territory_employee_row.gems_id_number       := :NEW.gems_id_number;
    v_territory_employee_row.cost_center_code     := :NEW.cost_center_code;
    v_territory_employee_row.effective_date       := :NEW.effective_date;
    v_territory_employee_row.employee_first_name  := :NEW.employee_first_name;
    v_territory_employee_row.employee_last_name   := :NEW.employee_last_name;
    v_territory_employee_row.employee_middle_name := :NEW.employee_middle_name;
    v_territory_employee_row.state_cd             := :NEW.state_cd;
    v_territory_employee_row.full_part_code       := :NEW.full_part_code;
    v_territory_employee_row.emp_job_code         := :NEW.emp_job_code;
    v_territory_employee_row.emp_payroll_status   := :NEW.emp_payroll_status;
    v_territory_employee_row.term_date            := :new.term_date;
    
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
/
ALTER TRIGGER "COSTCNTR"."TR_TERRITORY_EMPLOYEE_UPD" ENABLE;

  CREATE TABLE "COSTCNTR"."MANAGER_EMPLOYEE" 
   (	"GEMS_ID_NUMBER" VARCHAR2(30), 
	"COST_CENTER_CODE" VARCHAR2(150), 
	"EFFECTIVE_DATE" DATE, 
	"EMPLOYEE_FIRST_NAME" VARCHAR2(150), 
	"EMPLOYEE_LAST_NAME" VARCHAR2(150), 
	"EMPLOYEE_MIDDLE_NAME" VARCHAR2(60), 
	"STATE_CD" VARCHAR2(2), 
	"FULL_PART_CODE" VARCHAR2(1), 
	"EMP_JOB_CODE" VARCHAR2(5), 
	"EMP_PAYROLL_STATUS" VARCHAR2(6), 
	"TERM_DATE" DATE, 
	 CONSTRAINT "MANAGER_EMPLOYEE_PK" PRIMARY KEY ("GEMS_ID_NUMBER") ENABLE
   );

  CREATE OR REPLACE TRIGGER "COSTCNTR"."TR_MANAGER_EMPLOYEE_UPD" 
before insert or update on manager_employee 
referencing old as old new as new
for each row
DECLARE
    v_transaction_id         varchar2(500);
    v_rowdata                sys.xmltype;
    v_primarykey             sys.xmltype;
    v_manager_employee_row manager_employee%rowtype; 
    
BEGIN

    v_manager_employee_row.gems_id_number       := :new.gems_id_number;
    v_manager_employee_row.cost_center_code     := :new.cost_center_code;
    v_manager_employee_row.effective_date       := :new.effective_date;
    v_manager_employee_row.employee_first_name  := :new.employee_first_name;
    v_manager_employee_row.employee_last_name   := :new.employee_last_name;
    v_manager_employee_row.employee_middle_name := :new.employee_middle_name;
    v_manager_employee_row.state_cd             := :new.state_cd;
    v_manager_employee_row.full_part_code       := :new.full_part_code;
    v_manager_employee_row.emp_job_code         := :new.emp_job_code;
    v_manager_employee_row.emp_payroll_status   := :new.emp_payroll_status;
    v_manager_employee_row.term_date            := :new.term_date;
    
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
/
ALTER TRIGGER "COSTCNTR"."TR_MANAGER_EMPLOYEE_UPD" ENABLE;
GRANT SELECT ON "COSTCNTR"."MANAGER_EMPLOYEE" TO "CCN_UTILITY";