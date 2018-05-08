CREATE OR REPLACE VIEW MARKETING_VW
AS
SELECT
/*******************************************************************************
This View will give all the details of MARKETING linked to the cost center
Created  : 08/05/2015 axk326 CCN Project....
Modified : 05/08/2018 sxg151 CCN Team... 
           Added new fields (TOTAL_SQ_FT,SALES_SQ_FT,WAREHOUSE_SQ_FT)
*******************************************************************************/
       COST_CENTER_CODE,
       CATEGORY,
       MARKETING_TYPE,
       EFFECTIVE_DATE,
       EXPIRATION_DATE,
       MKT_BRAND,
       MKT_MISSION,
       MKT_SALES_FLOOR_SIZE,
       MKT_WAREHOUSE_SIZE,
       MKT_REAL_ESTATE_SETTING,
       TOTAL_SQ_FT,
       SALES_SQ_FT,
       WAREHOUSE_SQ_FT
  FROM MARKETING;