
SELECT COUNT(*) FROM territory_employee 
WHERE gems_id_number IN 
(SELECT employee_number FROM employee_details ed, cost_center cc
  WHERE cc.cost_center_code = ed.cost_center_code
    AND cc.CATEGORY <>'T');

DELETE FROM TERRITORY_EMPLOYEE
 WHERE gems_id_number IN 
 (SELECT employee_number FROM employee_details ed, cost_center cc
   WHERE cc.cost_center_code = ed.cost_center_code
    AND cc.CATEGORY <>'T');

COMMIT;

SELECT COUNT(*) FROM MANAGER_EMPLOYEE 
WHERE gems_id_number IN 
(SELECT employee_number FROM employee_details ed, cost_center cc
  WHERE cc.cost_center_code = ed.cost_center_code
    AND (cc.CATEGORY <>'S' or upper(JOB_TITLE) not like '%MGR%'));

DELETE FROM MANAGER_EMPLOYEE
 WHERE gems_id_number IN 
 (SELECT employee_number FROM employee_details ed, cost_center cc
   WHERE cc.cost_center_code = ed.cost_center_code
    AND (cc.CATEGORY <>'S' or upper(JOB_TITLE) not like '%MGR%'));
    
COMMIT;