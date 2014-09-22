create or replace TRIGGER tr_employee_admin_details_upd 
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