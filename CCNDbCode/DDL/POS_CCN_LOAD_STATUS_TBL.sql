/*
Created : 05/30/2018 nxk927 CCN Project
          Creating the POS_CCN_LOAD_STATUS and loading the table with the latest data
*/
CREATE TABLE POS_CCN_LOAD_STATUS AS
  SELECT CH.*,SYSDATE AS LOAD_DATE
    FROM PNP_CCN_LOAD_STATUS CH
   WHERE RLS_RUN_CYCLE = (SELECT MAX(RLS_RUN_CYCLE)
                            FROM PNP_CCN_LOAD_STATUS);