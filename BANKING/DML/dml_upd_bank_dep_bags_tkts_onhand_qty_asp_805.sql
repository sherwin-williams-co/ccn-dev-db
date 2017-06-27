/*******************************************************************************
--This script updates Bank deposit tickets/bags -ve onhand quantiry to zero
--Invalid cost centers or status_code <>2 those cost centers will not be applicable for
--place order for deposit tickets/bags, hence those cost centers onhand qty set back to 0
--This is one off script

Created : 06/23/2017 sxp130 - ASP_805 CCN Project Team ....
Changed :
*******************************************************************************/
SELECT * 
  FROM bank_dep_tick 
 WHERE business_rules_pkg.is_placing_dpt_tkt_bag_ord_ok(cost_center_code) = UPPER('N')
   AND dep_tkts_onhand_qty < 0;

UPDATE bank_dep_tick
   SET dep_tkts_onhand_qty = 0
 WHERE business_rules_pkg.is_placing_dpt_tkt_bag_ord_ok(cost_center_code) = UPPER('N')
   AND dep_tkts_onhand_qty < 0;

COMMIT;

SELECT * 
  FROM bank_dep_bag_tick 
 WHERE business_rules_pkg.is_placing_dpt_tkt_bag_ord_ok(cost_center_code) = UPPER('N')
   AND depbag_onhand_qty < 0;

UPDATE bank_dep_bag_tick
   SET depbag_onhand_qty = 0
 WHERE business_rules_pkg.is_placing_dpt_tkt_bag_ord_ok(cost_center_code) = UPPER('N')
   AND depbag_onhand_qty < 0;

COMMIT;

