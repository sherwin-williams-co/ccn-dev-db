CREATE OR REPLACE VIEW STORE_HOURS_VW
    AS
SELECT
/*******************************************************************************
This View holds all the Store hours data
created  : 02/12/2018 sxg151 CCN Team...
Modified : 02/19/2018 Added outer join to fetch all records from COST_CENTER table
           Also added logic to consider only active store category cost centers with current polling status as P or Q
         : 03/14/2019 sxg151 CCN Team
           ASP-1227 : ECOMM7.STORE_HOURS_V has been changed to 6-digit cost center instead of the 4 digit store numbers.
********************************************************************************/
         C.COST_CENTER_CODE,
         SH.MON_OPEN,
         SH.MON_CLOSE,
         SH.TUE_OPEN,
         SH.TUE_CLOSE,
         SH.WED_OPEN,
         SH.WED_CLOSE,
         SH.THU_OPEN,
         SH.THU_CLOSE,
         SH.FRI_OPEN,
         SH.FRI_CLOSE,
         SH.SAT_OPEN,
         SH.SAT_CLOSE,
         SH.SUN_OPEN,
         SH.SUN_CLOSE
    FROM STORE_HOURS_V SH,
         COST_CENTER C,
         POLLING P
   WHERE C.COST_CENTER_CODE           = SH.STORE_NBR(+)
     AND C.CATEGORY                   = 'S'
     AND C.COST_CENTER_CODE           = P.COST_CENTER_CODE
     AND C.CLOSE_DATE IS NULL
     AND P.POLLING_STATUS_CODE IN ('P','Q')
     AND P.CURRENT_FLAG = 'Y';