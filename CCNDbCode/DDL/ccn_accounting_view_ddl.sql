/*
     Created: 06/26/2017 axt754 CCN Project Team..
     This script creates a new view CCN_ACCOUNTING_VIEW for ccn 
     accounting view report
*/

CREATE OR REPLACE VIEW CCN_ACCOUNTING_VIEW AS 
SELECT * 
  FROM CCN_ACCOUNTING_TBL
 WHERE LOAD_DATE = (SELECT MAX(LOAD_DATE)
                      FROM CCN_ACCOUNTING_TBL);