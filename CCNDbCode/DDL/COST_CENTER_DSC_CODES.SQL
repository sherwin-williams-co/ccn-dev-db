-- This code is to run in non-PROD environments only
CREATE OR REPLACE  VIEW COST_CENTER_DSC_CODES (COST_CENTER_CODE, SECONDARY_DSC, SEC_DSC_DESCR, PRIMARY_DSC, PRI_DSC_DESCR) AS
/*******************************************************************************
This view is to return the Discount code information through the DB Link

Created : 05/19/2017 rxv940 CCN Project....
Changed : 05/15/2018 sxg151 Added new fields (SEC_DSC_DESCR/PRI_DSC_DESCR
*******************************************************************************/
SELECT STORE   AS COST_CENTER_CODE,
       SEC_DSC AS SECONDARY_DSC,
       SEC_DSC_DESCR,
       PRI_DSC AS PRIMARY_DSC,
       PRI_DSC_DESCR  
  FROM EHDA.V_AXESP0549@AOM_QA.WORLD;


-- This is to run only in PROD
CREATE OR REPLACE  VIEW COST_CENTER_DSC_CODES (COST_CENTER_CODE, SECONDARY_DSC, SEC_DSC_DESCR, PRIMARY_DSC, PRI_DSC_DESCR) AS
/*******************************************************************************
This view is to return the Discount code information through the DB Link

Created : 05/19/2017 rxv940 CCN Project....
Changed : 05/15/2018 sxg151 Added new fields (SEC_DSC_DESCR/PRI_DSC_DESCR
*******************************************************************************/
SELECT STORE   AS COST_CENTER_CODE,
       SEC_DSC AS SECONDARY_DSC,
       SEC_DSC_DESCR,
       PRI_DSC AS PRIMARY_DSC,
       PRI_DSC_DESCR  
  FROM EHDA.V_AXESP0549@@AOM_PROD.WORLD;