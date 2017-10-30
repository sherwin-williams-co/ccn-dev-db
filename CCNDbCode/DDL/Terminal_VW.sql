CREATE OR REPLACE VIEW TERMINAL_VW AS
SELECT 
/*******************************************************************************
This View holds all the ACTIVE TERMINALS for cost centers

Created  : 10/30/2017 axt754 CCN project Team....
Modified :
********************************************************************************/  
T.COST_CENTER_CODE
,T.POLLING_STATUS_CODE
,T.TERMINAL_NUMBER
,T.EFFECTIVE_DATE
,T.POS_LAST_TRAN_DATE
,T.POS_LAST_TRAN_NUMBER
  FROM TERMINAL T 
 WHERE T.EXPIRATION_DATE IS NULL 
   AND T.POLLING_STATUS_CODE IN (SELECT P.POLLING_STATUS_CODE
                                   FROM POLLING P
                                  WHERE T.COST_CENTER_CODE = P.COST_CENTER_CODE
                                    AND P.CURRENT_FLAG = 'Y' );