  CREATE OR REPLACE VIEW PRICE_DISTRICT_DETAIL_VIEW AS 
  SELECT HRCHY_DTL_CURR_ROW_VAL COST_CENTER,HRCHY_DTL_PREV_LVL_VAL PRICE_DISTRICT,HRCHY_DTL_CURR_LVL_VAL CURRENT_LEVEL,HRCHY_DTL_EFF_DATE EFFECTIVE_DATE,HRCHY_DTL_EXP_DATE EXPIRATION_DATE,HRCHY_DTL_DESC PRICE_DSTRCT_LEVEL_DESC
/*******************************************************************************
This View will give all the details of PRICE DISTRICT hierarchy 

Created  : 08/31/2015 nxk927 CCN Project....
Modified : 
*******************************************************************************/
    FROM HIERARCHY_DETAIL
   WHERE HRCHY_HDR_NAME = 'PRICE_DISTRICT'
     AND HRCHY_DTL_LEVEL = 2;