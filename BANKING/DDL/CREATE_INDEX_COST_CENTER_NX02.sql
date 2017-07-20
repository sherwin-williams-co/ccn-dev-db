/***************************************************************
Index on COST_CENTER added for Performance Improvement of STR_BNK_DPST_DLY_RCNCL_PROCESS.cost_center_lookup_fnc
Created: - 06/09/2017 RXA457 CCN Project Team...

****************************************************************/
--------------------------------------------------------

  CREATE INDEX COST_CENTER_NX02 ON COST_CENTER (SUBSTR("COST_CENTER_CODE",3));
  