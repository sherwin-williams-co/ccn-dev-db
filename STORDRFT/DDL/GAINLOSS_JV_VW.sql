CREATE OR REPLACE VIEW GAINLOSS_JV_VW
AS 
SELECT 
/*******************************************************************************
This view holds all the required monthly Gain and Loss data for the cost center.

Created  : 02/04/2015 SXT410 CCN Project Team...
Modified : 
*******************************************************************************/
       COST_CENTER_CODE,
       NET_AMOUNT,
       BOOK_DATE
  FROM GAINLOSS_JV;