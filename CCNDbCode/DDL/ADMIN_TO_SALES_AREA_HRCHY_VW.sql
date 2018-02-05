CREATE OR REPLACE VIEW ADMIN_TO_SALES_AREA_HRCHY_VW AS
SELECT
/*******************************************************************************
This View will give all the details of ADMIN_TO_SALES_AREA hierarchy associated to the cost center

Created  : 2/2/2018 jxc517 CCN Project Team ....
*******************************************************************************/
STATEMENT_TYPE, STATEMENT_TYPE_DESCRIPTION, HRCHY_HDR_NAME, COST_CENTER_CODE, HRCHY_DTL_EFF_DATE, HRCHY_DTL_EXP_DATE, DOMAIN, "GROUP", DIVISION, AREA, DOMAIN_NAME, GROUP_NAME, DIVISION_NAME, AREA_NAME, COST_CENTER_NAME
FROM ADMIN_TO_SALES_HIERARCHY_VW
WHERE HRCHY_HDR_NAME = 'ADMIN_TO_SALES_AREA';