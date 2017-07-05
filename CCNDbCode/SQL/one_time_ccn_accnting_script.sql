/* 
   created: axt754 
   Creation date: 07/05/2017
   one time script to run cccn_accounting_view and report */

DECLARE
    IN_DATE DATE := TO_DATE('06/30/2017','MM/DD/YYYY');
BEGIN
  CCN_ACCOUNTING_PKG.LOAD_CCN_ACCOUNTING_TABLE( IN_DATE);
END;
/

BEGIN
  CCN_ACCOUNTING_PKG.GEN_CCN_ACCOUNTING_REPORT();
END;
/