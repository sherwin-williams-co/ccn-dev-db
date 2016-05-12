CREATE OR REPLACE VIEW SD_STOPPED_PAY_VW
AS
SELECT
/*******************************************************************************
This view is used to get all the draft details for a store draft that is 90 days
old and not paid yet which has been marked as stop paid from CCN side

Created  : 04/27/2016 jxc517 CCN Project Team....
Modified : 
*******************************************************************************/
       *
  FROM STORE_DRAFTS
 WHERE STOP_PAY_MARKED_BY_CCN_IND IS NOT NULL;