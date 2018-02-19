CREATE OR REPLACE VIEW STORE_HOURS_VW
    AS 
SELECT 
/*******************************************************************************
This View holds all the Store hours data
created  : 02/12/2018 sxg151 CCN Team...
Modified : 02/19/2018 Added outer join to fetch all records from COST_CENTER table
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
FROM
   STORE_HOURS_V SH,COST_CENTER C
 WHERE SH.STORE_NBR(+) = SUBSTR(C.COST_CENTER_CODE,3);