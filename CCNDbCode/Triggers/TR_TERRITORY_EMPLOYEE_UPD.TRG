create or replace TRIGGER tr_territory_employee_upd 
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