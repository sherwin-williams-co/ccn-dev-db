CREATE OR REPLACE VIEW ADMIN_TO_SALES_DIST_HRCHY_VW AS
SELECT
/*******************************************************************************
This View will give all the details of Admin_to_sales_district hierarchies for linked to the cost center
Created  : 10/28/2015 SXG151 CCN
*******************************************************************************/
*
FROM ADMIN_TO_SALES_HIERARCHY_VW
WHERE HRCHY_HDR_NAME = 'ADMIN_TO_SALES_DISTRICT';