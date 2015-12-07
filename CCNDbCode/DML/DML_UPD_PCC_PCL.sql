-----------------------------------------------------------------------------------------------------------------------
--  Created : 12/07/2015 AXK326 CCN Project Team.... 
--            Update the columns COLOR_CONSULTANT_TYPE, PCC_PCL_STORE to NULL for the two cost centers 703605, 701350
-----------------------------------------------------------------------------------------------------------------------

-- Before Updating these two cost centers:
SELECT COLOR_CONSULTANT_TYPE,
       PCC_PCL_STORE
  FROM COST_CENTER 
 WHERE COST_CENTER_CODE IN ('703605', '701350');

 -- DML to Update the COLOR_CONSULTANT_TYPE, PCC_PCL_STORE to NULL
UPDATE COST_CENTER
   SET COLOR_CONSULTANT_TYPE = NULL,
       PCC_PCL_STORE = NULL
 WHERE COST_CENTER_CODE IN ('703605', '701350');
COMMIT;

-- After Updating these two cost centers
SELECT COLOR_CONSULTANT_TYPE,
       PCC_PCL_STORE
  FROM COST_CENTER 
 WHERE COST_CENTER_CODE IN ('703605', '701350');