  CREATE OR REPLACE VIEW COST_CENTER_PCC_PCL_VW(COST_CENTER_CODE, PCC_COST_CENTER_CODE, PCL_COST_CENTER_CODE) AS 
  SELECT 
/************************************************************************
This script will create a view which will be eventually used to generate 
report to get cost center and their PCC and PCL

Created : 05/20/2019 akj899 ASP-1200 
Update  : 
*************************************************************************/
           COST_CENTER_CODE,
           EXTRACTVALUE(PCC_PCL_STORE, '/PCC_PCL_STR/PCC/CC') PCC_COST_CENTER_CODE,
           EXTRACTVALUE(PCC_PCL_STORE, '/PCC_PCL_STR/PCL/CC') PCL_COST_CENTER_CODE
      FROM COST_CENTER
     WHERE (EXTRACTVALUE(PCC_PCL_STORE, '/PCC_PCL_STR/PCC/CC') IS NOT NULL
            OR
            EXTRACTVALUE(PCC_PCL_STORE, '/PCC_PCL_STR/PCL/CC') IS NOT NULL);
