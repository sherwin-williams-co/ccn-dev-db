--Script to delete the employees from TERRITORY_EMPLOYEE who have changed their cost center Category from 'T'(Territory) to a NON-Territory
BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
    COMMON_TOOLS.ALTER_ALL_TRIGGERS ('DISABLE');
END;
/

SELECT COUNT(*) FROM territory_employee 
WHERE gems_id_number IN 
(SELECT employee_number FROM employee_details ed, cost_center cc
  WHERE cc.cost_center_code = ed.cost_center_code
    AND cc.CATEGORY <>'T')
--23 rows selected

DELETE FROM TERRITORY_EMPLOYEE
 WHERE gems_id_number IN 
 (SELECT employee_number FROM employee_details ed, cost_center cc
   WHERE cc.cost_center_code = ed.cost_center_code
    AND cc.CATEGORY <>'T')

COMMIT;

BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
    COMMON_TOOLS.ALTER_ALL_TRIGGERS ('ENABLE');
END;
/