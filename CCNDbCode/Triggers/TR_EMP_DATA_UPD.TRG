DECLARE

	v_transaction_id VARCHAR2(500);
    v_rowdata sys.xmltype;
    v_primaryKey sys.xmltype;    
    v_EMP_DATA_row EMP_DATA%ROWTYPE; 
    
BEGIN
/*
	SELECT NVL(MAX(TRANSACTION_ID), 0) + 1 
      INTO v_transaction_id 
      from audit_log;             
*/

	v_emp_Data_row.NATIONAL_IDENTIFIER	:=	:NEW.NATIONAL_IDENTIFIER;
	v_emp_Data_row.RECORD_TYPE	:=	:NEW.RECORD_TYPE;
	v_emp_Data_row.COMPANY_CODE	:=	:NEW.COMPANY_CODE;
	v_emp_Data_row.FILE_NUMBER	:=	:NEW.FILE_NUMBER;
	v_emp_Data_row.EMPLOYEE_NAME	:=	:NEW.EMPLOYEE_NAME;
	v_emp_Data_row.LAST_NAME	:=	:NEW.LAST_NAME;
	v_emp_Data_row.FIRST_NAME	:=	:NEW.FIRST_NAME;
	v_emp_Data_row.MIDDLE_INITIAL	:=	:NEW.MIDDLE_INITIAL;
	v_emp_Data_row.HOME_ADDRESS_LINE1	:=	:NEW.HOME_ADDRESS_LINE1;
	v_emp_Data_row.HOME_ADDRESS_LINE2	:=	:NEW.HOME_ADDRESS_LINE2;
	v_emp_Data_row.HOME_CITY_STATE	:=	:NEW.HOME_CITY_STATE;
	v_emp_Data_row.HOME_CITY	:=	:NEW.HOME_CITY;
	v_emp_Data_row.HOME_STATE	:=	:NEW.HOME_STATE;
	v_emp_Data_row.HOME_POSTAL_CODE	:=	:NEW.HOME_POSTAL_CODE;
	v_emp_Data_row.HOME_PHONE	:=	:NEW.HOME_PHONE;
	v_emp_Data_row.SEX	:=	:NEW.SEX;
	v_emp_Data_row.EMP_PAYROLL_STATUS	:=	:NEW.EMP_PAYROLL_STATUS;
	v_emp_Data_row.EMP_ASSIGNMENT_STATUS	:=	:NEW.EMP_ASSIGNMENT_STATUS;
	v_emp_Data_row.EMP_DIVISION	:=	:NEW.EMP_DIVISION;
	v_emp_Data_row.ACCOUNT_NUMBER	:=	:NEW.ACCOUNT_NUMBER;
	v_emp_Data_row.FLSA_CODE	:=	:NEW.FLSA_CODE;
	v_emp_Data_row.EMPLOYEE_NUMBER	:=	:NEW.EMPLOYEE_NUMBER;
	v_emp_Data_row.PAYROLL_EMP_RPT_SEQ_ID	:=	:NEW.PAYROLL_EMP_RPT_SEQ_ID;
	
	SELECT XMLELEMENT (  "EMP_DATA",               
	  XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                          "xsi:nonamespaceSchemaLocation" ),
       XMLForest(
		v_emp_Data_row.NATIONAL_IDENTIFIER	NATIONAL_IDENTIFIER
		,v_emp_Data_row.RECORD_TYPE	RECORD_TYPE
		,v_emp_Data_row.COMPANY_CODE	COMPANY_CODE
		,v_emp_Data_row.FILE_NUMBER	FILE_NUMBER
		,v_emp_Data_row.EMPLOYEE_NAME	EMPLOYEE_NAME
		,v_emp_Data_row.LAST_NAME	LAST_NAME
		,v_emp_Data_row.FIRST_NAME	FIRST_NAME
		,v_emp_Data_row.MIDDLE_INITIAL	MIDDLE_INITIAL
		,v_emp_Data_row.HOME_ADDRESS_LINE1	HOME_ADDRESS_LINE1
		,v_emp_Data_row.HOME_ADDRESS_LINE2	HOME_ADDRESS_LINE2
		,v_emp_Data_row.HOME_CITY_STATE	HOME_CITY_STATE
		,v_emp_Data_row.HOME_CITY	HOME_CITY
		,v_emp_Data_row.HOME_STATE	HOME_STATE
		,v_emp_Data_row.HOME_POSTAL_CODE	HOME_POSTAL_CODE
		,v_emp_Data_row.HOME_PHONE	HOME_PHONE
		,v_emp_Data_row.SEX	SEX
		,v_emp_Data_row.EMP_PAYROLL_STATUS	EMP_PAYROLL_STATUS
		,v_emp_Data_row.EMP_ASSIGNMENT_STATUS	EMP_ASSIGNMENT_STATUS
		,v_emp_Data_row.EMP_DIVISION	EMP_DIVISION
		,v_emp_Data_row.ACCOUNT_NUMBER	ACCOUNT_NUMBER
		,v_emp_Data_row.FLSA_CODE	FLSA_CODE
		,v_emp_Data_row.EMPLOYEE_NUMBER	EMPLOYEE_NUMBER
		,v_emp_Data_row.PAYROLL_EMP_RPT_SEQ_ID	PAYROLL_EMP_RPT_SEQ_ID
		)) AS  "result"
		,XMLELEMENT (  "PRIMARY_KEY",               
	  		XMLATTRIBUTES ( 'http://www.w3.org/2001/XMLSchema' AS  "xmlns:xsi",
                  'http://www.oracle.com/Employee.xsd' AS
                          "xsi:nonamespaceSchemaLocation" ),
       		XMLForest(
				v_emp_Data_row.EMPLOYEE_NUMBER	EMPLOYEE_NUMBER
			)) AS  "PrimaryKey" 
			,('|' || v_emp_Data_row.EMPLOYEE_NUMBER ||
			  '|' ) transaction_id
			INTO v_rowdata
			,v_primaryKey
			,v_transaction_id
			FROM DUAL;
      
     /* -- for   Column -- */
     --IF (:OLD.CATEGORY != :NEW.CATEGORY) THEN

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
                , SYSDATE
                , 'EMP_DATA'
                , v_primaryKey--:NEW.EMPLOYEE_NUMBER
                ,v_rowdata
                ,'TR_EMP_DATA_UPD');
     --END IF;      
      
END TR_EMP_DATA_UPD;
/

