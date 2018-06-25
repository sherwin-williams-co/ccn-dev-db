/*
Created : 06/25/2018 nxk927
          Updating Open_date as begin date for the cost centers with 3 characters as K.

Update as per Pat's email below
Nirajan,
1.   Only active.  Any Kxxx with a closed date does not need to be changed.
2.   Only update those open Kxxx cost centers if the Open date = 01-JAN-2099.
Thanks,.
Pat
Patricia M. Malloy

SELECT */*insert*/ FROM COST_CENTER WHERE SUBSTR(COST_CENTER_CODE,3) LIKE 'K%' AND CLOSE_DATE IS NULL AND OPEN_DATE = '01-JAN-2099';
*/


SELECT COST_CENTER_CODE, COST_CENTER_NAME, CATEGORY, BEGIN_DATE, OPEN_DATE, CLOSE_DATE 
 FROM COST_CENTER
WHERE SUBSTR(COST_CENTER_CODE,3) LIKE 'K%' 
  AND CLOSE_DATE IS NULL
  AND OPEN_DATE = '01-JAN-2099';

UPDATE COST_CENTER 
   SET OPEN_DATE = BEGIN_DATE 
 WHERE SUBSTR(COST_CENTER_CODE,3) LIKE 'K%'
   AND CLOSE_DATE IS NULL
   AND OPEN_DATE = '01-JAN-2099';


COMMIT;