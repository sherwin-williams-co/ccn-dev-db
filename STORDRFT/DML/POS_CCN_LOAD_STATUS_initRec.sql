/*
Script Name: POS_CCN_LOAD_STATUS_initRec.sql
Purpose    : This scripts inserts previous run's load cycle data from PNP_CCN_LOAD_STATUS into POS_CCN_LOAD_STATUS 
Created    : 09/26/2017 NXK927 CCN Project....
*/

INSERT INTO POS_CCN_LOAD_STATUS
SELECT CLS.*, TRUNC(SYSDATE)
  FROM PNP_CCN_LOAD_STATUS CLS
 WHERE CLS.RLS_RUN_CYCLE = (SELECT MAX(RLS_RUN_CYCLE)
                              FROM PNP_CCN_LOAD_STATUS);

COMMIT;
