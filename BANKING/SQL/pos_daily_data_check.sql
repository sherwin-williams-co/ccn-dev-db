/*---------------------------------------------------------------------------------------------------------
Script to check the data source tables to confirm data are loaded for given runcycle.

USED BY  :  banking_pos_data_load_cbp.sh
Created  :  06/08/2017 gxg192 CCN Project....
Changed  :   09/27/2017 rxa457 CCN Project Team...
             Function GET_LATEST_POS_RUN_CYCLE called to check for new run cycles 
-----------------------------------------------------------------------------------------------------------*/
SET SERVEROUTPUT ON
SET FEEDBACK OFF

DECLARE
   V_RLS_RUN_CYCLE POS_CCN_LOAD_STATUS.RLS_RUN_CYCLE%TYPE;
BEGIN
    V_RLS_RUN_CYCLE := POS_BANKING_DAILY_LOAD.GET_LATEST_POS_RUN_CYCLE;
    
    IF V_RLS_RUN_CYCLE IS NULL THEN
       DBMS_OUTPUT.PUT_LINE('NOTREADY'); 
    ELSE
       DBMS_OUTPUT.PUT_LINE('READY'); 
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('NOTREADY');
END;
/

