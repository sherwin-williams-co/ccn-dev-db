/*---------------------------------------------------------------------------------------------------------
Script to check the data source tables to confirm data are loaded for given runcycle.
    sysdate is used in the decode as if anything fails we won't run this script and go to next step.
    dcode is used to handle for the tuesday run. as tuesday run will include the 3 days data
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
     WHERE RLS_RUN_CYCLE > (SELECT MAX(RLS_RUN_CYCLE) - DECODE(TO_CHAR(SYSDATE, 'D'),3,3,1)--checking on if tuesday, we need 3 days of data
                              FROM POS_CCN_LOAD_STATUS)
       and STATUS_CODE = 'C';

    IF V_DATA_CHECK = 0 -- if no data present
       OR (TO_CHAR(SYSDATE, 'D') = 3 AND V_DATA_CHECK <> 3)--If tuesday and we don't have 3 days of data.
       THEN
       DBMS_OUTPUT.PUT_LINE('NOTREADY'); 
    ELSE
       DBMS_OUTPUT.PUT_LINE('READY');
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('NOTREADY');
END;
/