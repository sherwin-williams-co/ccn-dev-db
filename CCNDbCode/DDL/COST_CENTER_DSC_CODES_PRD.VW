CREATE OR REPLACE VIEW COST_CENTER_DSC_CODES (COST_CENTER_CODE, SECONDARY_DSC, PRIMARY_DSC) AS 
/*******************************************************************************
This view is to return the Discount code information thru' the DB Link
This is to run only in PROD
Created : 05/19/2017 rxv940 CCN Project....
Changed :
*******************************************************************************/
SELECT STORE, SEC_DSC, PRI_DSC FROM EHDA.V_AXESP0549@AOM_PROD.WORLD;