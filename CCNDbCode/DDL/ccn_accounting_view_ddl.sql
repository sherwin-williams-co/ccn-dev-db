CREATE OR REPLACE VIEW CCN_ACCOUNTING_VIEW AS
SELECT
/*
     Created: 06/26/2017 axt754 CCN Project Team..
     This script creates a new view CCN_ACCOUNTING_VIEW for ccn 
     accounting view report
     Modified : 06/13/2018 Added BEGIN_DATE,TYPE and TYPE_CODE_DESC in CCN_ACCOUNTING_TBL
*/
     *
  FROM CCN_ACCOUNTING_TBL
 WHERE LOAD_DATE = (SELECT MAX(LOAD_DATE)
                      FROM CCN_ACCOUNTING_TBL);