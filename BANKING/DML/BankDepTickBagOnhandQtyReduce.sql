/*
Below script reduces the oh hand quantity of tickets/bags by 50 as per the request from Pat/Lynda
Condition was added to not have on-hand quantity less than 0

Created : 11/17/2017 jxc517 CCN Project Team....
Changed :
*/
SELECT *
  FROM BANK_DEP_TICK
 WHERE COST_CENTER_CODE NOT IN ('702972','701744');
--4580 Row(s) Selected
UPDATE BANK_DEP_TICK
   SET DEP_TKTS_ONHAND_QTY = GREATEST(NVL(DEP_TKTS_ONHAND_QTY,0) - 50, 0)
 WHERE COST_CENTER_CODE NOT IN ('702972','701744');
--4580 Row(s) Updated

SELECT *
  FROM BANK_DEP_BAG_TICK
 WHERE COST_CENTER_CODE NOT IN ('702972','701744');
--4554 Row(s) Selected
UPDATE BANK_DEP_BAG_TICK
   SET DEPBAG_ONHAND_QTY = GREATEST(NVL(DEPBAG_ONHAND_QTY,0) - 50, 0)
 WHERE COST_CENTER_CODE NOT IN ('702972','701744');
--4554 Row(s) Updated

COMMIT;
