/*---------------------------------------------------------------------------------------------------------
Script to check the data source tables to confirm data are loaded for given runcycle.

USED BY  :  sd_data_status_check.sh
Created  :  06/02/2017 nxk927
-----------------------------------------------------------------------------------------------------------*/
SET SERVEROUTPUT ON
SET FEEDBACK OFF

DECLARE
    V_RLS_CYCLE     VARCHAR2(10) := NULL;
BEGIN
    SELECT RLS_RUN_CYCLE
	  INTO V_RLS_CYCLE
      FROM PNP_CCN_LOAD_STATUS
     WHERE RLS_RUN_CYCLE > (SELECT MAX(RLS_RUN_CYCLE)
                              FROM POS_CCN_LOAD_STATUS)
       AND STATUS_CODE = 'C';
    
       DBMS_OUTPUT.PUT_LINE(V_RLS_CYCLE); 
    
EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(0);
END;
/