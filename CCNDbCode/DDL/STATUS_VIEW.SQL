
  CREATE OR REPLACE FORCE VIEW "COSTCNTR"."STATUS_VIEW" ("COST_CENTER_CODE", "STATUS_CODE", "STATUS_CODE_DESCRIPTION", "EFFECTIVE_DATE", "EXPIRATION_DATE") AS 
  SELECT
/*******************************************************************************
This View holds all the required data for a cost_center_code,status_code
status_code_description,effective_date and expiration_date.

Created  : 06/30/2016 MXR916 CCN Project.
*******************************************************************************/
COST_CENTER_CODE,
STATUS_CODE,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATUS_CODE','COD',STATUS_CODE),'N/A') STATUS_CODE_DESCRIPTION,
EFFECTIVE_DATE,
EXPIRATION_DATE
FROM STATUS;
