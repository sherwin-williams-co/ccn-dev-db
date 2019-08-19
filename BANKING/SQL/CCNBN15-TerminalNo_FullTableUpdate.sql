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

-- Count of Rows with trailing 0 in Terminal Number BEFORE UPDATE :

  SELECT COUNT(*)
    FROM POS_DPST_TICKET_COUNTS
   where LENGTH(TERMINAL_NUMBER) > 5
     and SUBSTR(TERMINAL_NUMBER,-1) = '0';
   
   UPDATE POS_DPST_TICKET_COUNTS
    SET TERMINAL_NUMBER = substr(TERMINAL_NUMBER,1,5)
   where LENGTH(TERMINAL_NUMBER) > 5
     and SUBSTR(TERMINAL_NUMBER,-1) = '0';

-- Count of Rows with trailing 0 in Terminal Number AFTER UPDATE :
 
   SELECT COUNT(*)
    FROM POS_DPST_TICKET_COUNTS
   where LENGTH(TERMINAL_NUMBER) > 5
     and SUBSTR(TERMINAL_NUMBER,-1) = '0';
   
COMMIT;
 








