/*---------------------------------------------------------------------------------------------------------
Script to check the data source tables to confirm data are loaded for given runcycle.

USED BY  :  pos_data_check.sh
Created  :  07/20/2017 nxk927
-----------------------------------------------------------------------------------------------------------*/
SET SERVEROUTPUT ON
SET FEEDBACK OFF

DECLARE
    V_DATA_CHECK     NUMBER;
BEGIN
    SELECT COUNT(RLS_RUN_CYCLE)
      INTO V_DATA_CHECK
      FROM PNP_CCN_LOAD_STATUS
     WHERE RLS_RUN_CYCLE > (SELECT MAX(RLS_RUN_CYCLE) - DECODE(TO_CHAR(TRUNC(SYSDATE), 'D'),3,3,1)
                              FROM POS_CCN_LOAD_STATUS)
       and STATUS_CODE = 'C';

    IF V_DATA_CHECK = 0 THEN
       DBMS_OUTPUT.PUT_LINE('NOTREADY'); 
    ELSE
       IF TO_CHAR(TRUNC(SYSDATE), 'D') = 3 AND V_DATA_CHECK <> 3 THEN
          DBMS_OUTPUT.PUT_LINE('NOTREADY');
       ELSE
          DBMS_OUTPUT.PUT_LINE('READY');
       END IF;
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('NOTREADY');
END;
/