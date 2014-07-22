--------------------------------------------------------
--  File created - Tuesday-July-22-2014   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for View COST_CENTER_VW
--------------------------------------------------------

CREATE OR REPLACE VIEW "COSTCNTR"."COST_CENTER_VW" 
AS 
SELECT
/* ---comments
This View holds all the required data for a cost_center its country_code, Mission_type_code along with their descriptions
and also Acquisition_code from COST_CENTER table
created  : 03/18/2014 for CCN project and 
Modified : 07/18/14 Added ACQUISITION_CODE column.
revisions: 07/21/2014
*/ 
COST_CENTER_CODE,
COST_CENTER_NAME,
CATEGORY,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('CATEGORY','COD',CATEGORY),'N/A') CATEGORY_DESCRIPTION,
STATEMENT_TYPE,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('STATEMENT_TYPE','COD',STATEMENT_TYPE),'N/A') STATEMENT_TYPE_DESCRIPTION,
COUNTRY_CODE,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('COUNTRY_CODE','COD',COUNTRY_CODE),'N/A') COUNTRY_CODE_DESCRIPTION,
BEGIN_DATE,
OPEN_DATE,
MOVE_DATE,
CLOSE_DATE,
MISSION_TYPE_CODE,
NVL(CCN_PICK_LIST_PKG.GET_CODE_DETAIL_VALUE_DSCRPTN('MISSION_TYPE_CODE','COD',MISSION_TYPE_CODE),'N/A') MISSION_TYPE_CODE_DESCRIPTION,
DUNS_NUMBER,
ACQUISITION_CODE
FROM cost_center;
