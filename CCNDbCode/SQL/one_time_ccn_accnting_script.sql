/* 
   created: axt754 
   Creation date: 07/05/2017
   Modified date: 08/01/2017 axt754 Changed date to run one time on july 31st. 
   one time script to run cccn_accounting_view and report */

DECLARE
    IN_DATE DATE := TO_DATE('07/31/2017','MM/DD/YYYY');
BEGIN
  CCN_ACCOUNTING_PKG.LOAD_CCN_ACCOUNTING_TABLE( IN_DATE);
END;
/

BEGIN
  CCN_ACCOUNTING_PKG.GEN_CCN_ACCOUNTING_REPORT();
END;
/