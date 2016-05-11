CREATE OR REPLACE VIEW SDD_STOPPED_PAY_VW
AS
SELECT
/*******************************************************************************
This view is used to get all the draft details for a store draft

Created  : 04/27/2016 jxc517 CCN Project Team....
Modified : 
*******************************************************************************/
       *
  FROM STORE_DRAFTS_DETAIL
 WHERE CHECK_SERIAL_NUMBER IN (SELECT CHECK_SERIAL_NUMBER
                                 FROM STORE_DRAFTS
                                WHERE STOP_PAY_MARKED_BY_CCN_IND IS NOT NULL);