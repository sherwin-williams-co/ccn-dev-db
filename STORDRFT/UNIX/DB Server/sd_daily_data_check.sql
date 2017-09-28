/*---------------------------------------------------------------------------------------------------------
Script to check the data source tables to confirm data are loaded for given runcycle.

USED BY  :  sd_data_status_check.sh
Created  :  06/02/2017 nxk927
changed  :  09/28/2017 nxk927
            changed the logic to check the data depending on date
-----------------------------------------------------------------------------------------------------------*/
SET SERVEROUTPUT ON
SET FEEDBACK OFF

DECLARE
    V_DATA_CHECK     VARCHAR2(10);
BEGIN
    V_DATA_CHECK := POS_SD_DAILY_LOAD.GET_LOAD_RUNCYCLE();
    IF V_DATA_CHECK IS NULL THEN
       DBMS_OUTPUT.PUT_LINE('NOTREADY'); 
    ELSE
       DBMS_OUTPUT.PUT_LINE('READY'); 
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('NOTREADY');
END;
/