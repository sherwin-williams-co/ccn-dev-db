CREATE OR REPLACE VIEW ADMINORG_HIERARCHY_ATTRBT_VW AS
  SELECT  
/*******************************************************************************
This View will give all the Admin Org Hierarchy details for the cost center passed

Created  : 01/09/2017 vxv336 CCN Project
Modified : 12/13/2017 mxv711 CCN Project
           02/13/2017 mxv711 CCN project
           fixed the view to consider the hierachy values upto cost center level only
           05/08/2018 nxk927 CCN project
           Hierarchy level description changed
           05/08/2018 nxk927 CCN project
           View update to pull the data from ADMINORG_HIERARCHY_DTL_VIEW
*******************************************************************************/
       H.*
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN,
                                                                                     H.DOMAIN||NVL(H.DIVISION,H.COST_CENTER_CODE),
                                                                                     '~~~'),
                                                'EmployeeName') DOMAIN_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION,
                                                                                     H.DOMAIN||H.DIVISION||NVL(H.CONTROL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN),
                                                'GEMS_ID') DIVISION_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION,
                                                                                     H.DOMAIN||H.DIVISION||NVL(H.CONTROL,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN),
                                                'EmployeeName') DIVISION_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||NVL(H.BUDGET,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN||H.DIVISION),
                                                'GEMS_ID') CONTROL_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||NVL(H.BUDGET,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN||H.DIVISION),
                                                'EmployeeName') CONTROL_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||NVL(H.FUNCTIONAL_1,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL),
                                                'GEMS_ID') BUDGET_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||NVL(H.FUNCTIONAL_1,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL),
                                                'EmployeeName') BUDGET_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||NVL(H.FUNCTIONAL_2,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET),
                                                'GEMS_ID') FUNCTIONAL_1_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||NVL(H.FUNCTIONAL_2,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET),
                                                'EmployeeName') FUNCTIONAL_1_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||H.FUNCTIONAL_2,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||H.FUNCTIONAL_2|| NVL(H.FUNCTIONAL_3,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1),
                                                'GEMS_ID') CITY_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||H.FUNCTIONAL_2,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||H.FUNCTIONAL_2||NVL(H.FUNCTIONAL_3,H.COST_CENTER_CODE),
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1),
                                                'EmployeeName') CITY_EMP_NAME

       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||H.FUNCTIONAL_2||H.FUNCTIONAL_3,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||H.FUNCTIONAL_2||H.FUNCTIONAL_3||H.COST_CENTER_CODE,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||H.FUNCTIONAL_2),
                                                'GEMS_ID') FUNCTIONAL_3_GEMS_ID
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||H.FUNCTIONAL_2||H.FUNCTIONAL_3,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||H.FUNCTIONAL_2||H.FUNCTIONAL_3||H.COST_CENTER_CODE,
                                                                                     H.DOMAIN||H.DIVISION||H.CONTROL||H.BUDGET||H.FUNCTIONAL_1||H.FUNCTIONAL_2),
                                                'EmployeeName') FUNCTIONAL_3_EMP_NAME
FROM ADMINORG_HIERARCHY_DTL_VIEW H;