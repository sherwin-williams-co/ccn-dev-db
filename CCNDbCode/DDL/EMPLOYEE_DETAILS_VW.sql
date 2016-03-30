CREATE OR REPLACE VIEW EMPLOYEE_DETAILS_VW
AS 
SELECT 
/*******************************************************************************
This view holds required data for an Employee
Such as Employee Number, Cost Center, Employee Name and Job title who's
Payroll status is Active.

Created  : 12/10/2014 SXT410 CCN project
Modified : 
*******************************************************************************/
      EMPLOYEE_NUMBER,
      COST_CENTER_CODE,      
      EMPLOYEE_NAME,
      JOB_TITLE
FROM  EMPLOYEE_DETAILS
WHERE UPPER(EMP_PAYROLL_STATUS) = 'ACTIVE';