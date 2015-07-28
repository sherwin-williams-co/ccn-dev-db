  CREATE OR REPLACE VIEW FACTS_DIVISION_DETAIL_VIEW AS 
  SELECT STATEMENT_TYPE,HRCHY_HDR_NAME,COST_CENTER_CODE,HRCHY_DTL_EFF_DATE,HRCHY_DTL_EXP_DATE,DOMAIN,"GROUP",DIVISION,DOMAIN_NAME,GROUP_NAME,DIVISION_NAME,COST_CENTER_NAME
/*******************************************************************************
This View will give all the details of FACTS hierarchy linked to the cost center

Created  : 07/28/2015 nxk927 CCN Project....
Modified : 
*******************************************************************************/
    FROM HIERARCHY_DETAIL_VIEW
   WHERE HRCHY_HDR_NAME = 'FACTS_DIVISION';
/   
   
