create or replace TRIGGER tr_manager_employee_upd 
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