-- created 03/09/2018 sxh487
-- Run this in COSTCNTR
 
GRANT SELECT ON HIERARCHY_DETAIL_VIEW TO CSTMR_DPSTS;
CREATE OR REPLACE SYNONYM HIERARCHY_DETAIL_VIEW FOR COSTCNTR.HIERARCHY_DETAIL_VIEW;
/