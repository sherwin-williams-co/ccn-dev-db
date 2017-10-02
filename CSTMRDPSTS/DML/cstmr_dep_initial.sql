/***************************************************************
Description : Initial record for the customer deposit
Created  : 09/28/2017 sxh487 CCN Project Team.....
***************************************************************/
--initial record insert
 INSERT INTO POS_CSTMR_DEP_LOAD_STATUS
 SELECT CLS.*, TRUNC(SYSDATE)
   FROM PNP.CCN_LOAD_STATUS CLS
  WHERE CLS.RLS_RUN_CYCLE = (SELECT MAX(RLS_RUN_CYCLE)
                              FROM PNP.CCN_LOAD_STATUS);