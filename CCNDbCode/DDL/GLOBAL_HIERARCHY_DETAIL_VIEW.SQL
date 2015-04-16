CREATE OR REPLACE VIEW GLOBAL_HIERARCHY_DETAIL_VIEW AS 
  SELECT 
/*******************************************************************************
This View will give all the details of global hierarchy linked to the cost center

Created  : 04/16/2015 jxc517 CCN Project....
Modified : 
*******************************************************************************/
         *
    FROM HIERARCHY_DETAIL_VIEW
   WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY';
