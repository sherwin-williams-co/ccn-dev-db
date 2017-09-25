/************************************************************************************
This script will delete all the address records for "T" and "D" category cost centers
from the following tables
   ADDRESS_USA
   ADDRESS_CAN
   ADDRESS_BRB
   ADDRESS_MEX
   ADDRESS_OTHER
   
CREATED : 09/25/2017 sxh487 CCN Project team....
*************************************************************************************/
SET SERVEROUTPUT ON;
BEGIN
   FOR REC IN (SELECT * FROM ADDRESS_USA A
                WHERE EXISTS (SELECT 1 
                                FROM COST_CENTER 
                               WHERE COST_CENTER_CODE = A.COST_CENTER_CODE 
                                 AND CATEGORY IN ('D', 'T'))) LOOP
                                 
       DELETE FROM ADDRESS_USA WHERE COST_CENTER_CODE = REC.COST_CENTER_CODE;
   END LOOP;
   COMMIT;
   FOR REC IN (SELECT * FROM ADDRESS_CAN A
                WHERE EXISTS (SELECT 1 
                                FROM COST_CENTER 
                               WHERE COST_CENTER_CODE = A.COST_CENTER_CODE 
                                 AND CATEGORY IN ('D', 'T'))) LOOP
                                 
       DELETE FROM ADDRESS_CAN WHERE COST_CENTER_CODE = REC.COST_CENTER_CODE;
   END LOOP;
   COMMIT;
   FOR REC IN (SELECT * FROM ADDRESS_BRB A
                WHERE EXISTS (SELECT 1 
                                FROM COST_CENTER 
                               WHERE COST_CENTER_CODE = A.COST_CENTER_CODE 
                                 AND CATEGORY IN ('D', 'T'))) LOOP
                                 
       DELETE FROM ADDRESS_BRB WHERE COST_CENTER_CODE = REC.COST_CENTER_CODE;
   END LOOP;
   COMMIT;
   FOR REC IN (SELECT * FROM ADDRESS_MEX A
                WHERE EXISTS (SELECT 1 
                                FROM COST_CENTER 
                               WHERE COST_CENTER_CODE = A.COST_CENTER_CODE 
                                 AND CATEGORY IN ('D', 'T'))) LOOP
                                 
       DELETE FROM ADDRESS_MEX WHERE COST_CENTER_CODE = REC.COST_CENTER_CODE;
   END LOOP;
   COMMIT;
   FOR REC IN (SELECT * FROM ADDRESS_OTHER A
                WHERE EXISTS (SELECT 1 
                                FROM COST_CENTER 
                               WHERE COST_CENTER_CODE = A.COST_CENTER_CODE 
                                 AND CATEGORY IN ('D', 'T'))) LOOP
                                 
       DELETE FROM ADDRESS_OTHER WHERE COST_CENTER_CODE = REC.COST_CENTER_CODE;
   END LOOP;
   COMMIT;
END;
/
