CREATE OR REPLACE VIEW MISCTRAN_PRIMESUB
AS
SELECT 
/*******************************************************************************
  This view gives details about the misc transaction file along with prime sub and JV/IDE details

Created : 10/10/2016 jxc517 CCN Project Team....
Changed : 
*******************************************************************************/
       *
  FROM MISCTRAN_DETAILS
 ORDER BY COST_CENTER_CODE, LOAD_DATE, DB_CR_CODE;
/
