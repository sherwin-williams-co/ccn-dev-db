--Below script will update the Job Titles for all the employees who are 'Mgr'
--but need to be 'Asst Mgr' for employee_details table
--There will also be code changes associated in the CCN_EMPLOYEE_DETAILS_PKG
SELECT COUNT(*)
  FROM EMPLOYEE_DETAILS
 WHERE upper(JOB_LEVEL) = upper('Asst') and upper(JOB_TITLE) = upper('Mgr');
 
--134 Row(s) Selected

Update EMPLOYEE_DETAILS
   set JOB_TITLE ='Asst Mgr'
 Where upper(JOB_LEVEL) = upper('Asst') and upper(JOB_TITLE) = upper('Mgr');
 
--134 Row(s) updated.

COMMIT;
