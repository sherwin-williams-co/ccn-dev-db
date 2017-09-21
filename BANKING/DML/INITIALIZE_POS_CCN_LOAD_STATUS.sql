/*
Script Name: INITIALIZE_POS_CCN_LOAD_STATUS.sql
Purpose    : This scripts inserts previous run's load cycle data from PNP_CCN_LOAD_STATUS into POS_CCN_LOAD_STATUS 
              This script is applicable only for QA and PROD because DEV and TEST have already been initialized
Created    : 09/31/2017 rxa457 CCN Project....
*/

INSERT INTO POS_CCN_LOAD_STATUS 
     SELECT CH.*, 
	        TRUNC(SYSDATE) 
	   FROM PNP_CCN_LOAD_STATUS CH 
	  WHERE CH.RLS_RUN_CYCLE = (SELECT MAX(RLS_RUN_CYCLE) 
	                              FROM PNP_CCN_LOAD_STATUS);

COMMIT;
