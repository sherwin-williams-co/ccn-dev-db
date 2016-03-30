CREATE OR REPLACE VIEW TYPE_VW
AS
SELECT
/*******************************************************************************
This View will give all the details of TYPE linked to the cost center

Created  : 08/05/2015 axk326 CCN Project....
Modified :
*******************************************************************************/
       COST_CENTER_CODE,
       TYPE_CODE,
       EFFECTIVE_DATE,
       EXPIRATION_DATE
  FROM TYPE;