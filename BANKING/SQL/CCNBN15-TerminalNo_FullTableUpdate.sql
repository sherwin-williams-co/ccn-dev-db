/*******************************************************************************
CCNBN-15 : One time datafix script to remove trailing 0 from  the terminal_number column of the 
POS_DPST_TICKET_COUNTS table as this is no longer needed. 
Created : 08/19/2019 sxc403
*******************************************************************************/
set serveroutput on size unlimited
set linesize 300
set pagesize 500
SET ECHO ON
SET VERIFY OFF
SET HEADING OFF

SELECT 'Count of Rows with trailing 0 in Terminal Number BEFORE UPDATE :' FROM DUAL;

  SELECT COUNT(*)
    FROM POS_DPST_TICKET_COUNTS
   WHERE SUBSTR(TERMINAL_NUMBER,-1) = '0';
   
   UPDATE POS_DPST_TICKET_COUNTS
    SET TERMINAL_NUMBER = RTRIM(TERMINAL_NUMBER,'0')
    WHERE SUBSTR(TERMINAL_NUMBER,-1) = '0';
    
 SELECT 'Count of Rows with trailing 0 in Terminal Number AFTER UPDATE :' FROM DUAL;   
 
   SELECT COUNT(*)
    FROM POS_DPST_TICKET_COUNTS
   WHERE SUBSTR(TERMINAL_NUMBER,-1) = '0';
   
 COMMIT;




