   CREATE OR REPLACE VIEW PRICE_DISTRICT_DETAIL_VIEW AS 
   SELECT
   /*******************************************************************************
    This View will give all the details of PRICE DISTRICT hierarchy 

    Created  : 08/31/2015 nxk927 CCN Project....
    Modified : 
    *******************************************************************************/
    COST_CENTER_CODE, DISTRICT PRICE_DISTRICT, DISTRICT||COST_CENTER_CODE CURRENT_LEVEL, HRCHY_DTL_EFF_DATE EFFECTIVE_DATE,HRCHY_DTL_EXP_DATE EXPIRATION_DATE, DISTRICT_NAME PRICE_DISTRICT_DESC
    FROM HIERARCHY_DETAIL_VIEW
   WHERE HRCHY_HDR_NAME = 'PRICE_DISTRICT';
    