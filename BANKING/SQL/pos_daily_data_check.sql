/*---------------------------------------------------------------------------------------------------------
Script to check the data source tables to confirm data are loaded for given runcycle.

USED BY  :  banking_pos_data_load_cbp.sh
Created  :  06/08/2017 gxg192 CCN Project....
-----------------------------------------------------------------------------------------------------------*/
SET SERVEROUTPUT ON
SET FEEDBACK OFF

DECLARE
    V_DATA_CHECK     NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO V_DATA_CHECK
      FROM PNP_CCN_LOAD_STATUS
     WHERE TRUNC(START_TS) > (SELECT MAX(TRUNC(END_TS))
                                FROM POS_CCN_LOAD_STATUS)
       AND STATUS_CODE = 'C';

    IF V_DATA_CHECK = 0 THEN
       DBMS_OUTPUT.PUT_LINE('NOTREADY'); 
    ELSE
       DBMS_OUTPUT.PUT_LINE('READY'); 
    END IF;
    
EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('NOTREADY');
END;
/

