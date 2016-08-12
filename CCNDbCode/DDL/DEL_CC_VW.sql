CREATE OR REPLACE VIEW DEL_CC_VW AS
SELECT
/*******************************************************************************
This View will give all the details of CC_DELETION_GUIDS linked to the cost center
Created  : 07/28/2016 axk326 CCN Project....
Modified :
*******************************************************************************/
     GUID,
     ARCHIVE_COST_CENTER_CODE,
     COST_CENTER_CODE,
     PROCESS_DATE
FROM CC_DELETION_GUIDS;
