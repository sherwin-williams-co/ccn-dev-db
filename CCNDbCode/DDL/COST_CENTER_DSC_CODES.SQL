-- This code is to run in non-PROD environments only
CREATE OR REPLACE VIEW COST_CENTER_DSC_CODES (COST_CENTER_CODE, SECONDARY_DSC, PRIMARY_DSC) AS 
/*******************************************************************************
This view is to return the Discount code information through the DB Link

Created : 05/19/2017 rxv940 CCN Project....
Changed :
*******************************************************************************/
SELECT STORE, SEC_DSC, PRI_DSC FROM EHDA.V_AXESP0549@AOM_QA.WORLD;


-- This is to run only in PROD
CREATE OR REPLACE VIEW COST_CENTER_DSC_CODES (COST_CENTER_CODE, SECONDARY_DSC, PRIMARY_DSC) AS 
/*******************************************************************************
This view is to return the Discount code information through the DB Link

Created : 05/19/2017 rxv940 CCN Project....
Changed :
*******************************************************************************/
SELECT STORE, SEC_DSC, PRI_DSC FROM EHDA.V_AXESP0549@AOM_PROD.WORLD;