/*******************************************************************************
Report (query) to get all the stores which are having their polling start date prior to their begin date in CCN.

CREATED : 08/31/2018 pxa852 CCN Project...
*******************************************************************************/

   SELECT P.COST_CENTER_CODE, P.POLLING_START_DATE, C.BEGIN_DATE, P.POLLING_STATUS_CODE
  FROM COST_CENTER C, POLLING P
   WHERE C.COST_CENTER_CODE   = P.COST_CENTER_CODE
     AND P.CURRENT_FLAG       = 'Y'
     AND C.CLOSE_DATE IS NULL
     AND P.POLLING_START_DATE < C.BEGIN_DATE;
