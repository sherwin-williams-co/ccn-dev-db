CREATE OR REPLACE VIEW CREDIT_HIERARCHY_DETAIL_VIEW
AS
  SELECT
/*******************************************************************************
This View will give all the credit hierarchy details for the cost center passed

Created  : 03/23/2016 jxc517 CCN Project....
Modified : 08/19/2016 vxv336 Removed SYSOUT
*******************************************************************************/
       DISTINCT
        CC.STATEMENT_TYPE
       ,H.HRCHY_HDR_NAME
       ,CC.COST_CENTER_CODE
       ,H.HRCHY_DTL_EFF_DATE
       ,H.HRCHY_DTL_EXP_DATE
       ,H.GROUP_VAL "GROUP"
       ,H.DIVISION_VAL DIVISION
       ,H.AREA_VAL AREA
       ,H.DISTRICT_VAL DISTRICT
       ,H.DCO_VAL DCO
       ,H.COST_CENTER_CODE AS COST_CENTER
       ,H.GROUP_VAL_NAME GROUP_NAME
       ,H.DIVISION_VAL_NAME DIVISION_NAME
       ,H.AREA_VAL_NAME AREA_NAME
       ,H.DISTRICT_VAL_NAME DISTRICT_NAME
       ,H.DCO_VAL_NAME DCO_NAME
       ,CC.COST_CENTER_NAME
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL || H.AREA_VAL,
                                                                                     H.GROUP_VAL ),
                                                'RCM') RCM
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL || H.DISTRICT_VAL,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL || H.DISTRICT_VAL || H.DCO_VAL,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL),
                                                'ACM') ACM
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL || H.DISTRICT_VAL,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL || H.DISTRICT_VAL || H.DCO_VAL,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL),
                                                'ACM_MGR') ACM_MGR
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL || H.DISTRICT_VAL,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL || H.DISTRICT_VAL || H.DCO_VAL,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL),
                                                'DCM') DCM
       ,CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(COMMON_TOOLS.GET_UPPER_LVL_VER_VALUE(H.HRCHY_HDR_NAME,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL || H.DISTRICT_VAL,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL || H.DISTRICT_VAL || H.DCO_VAL,
                                                                                     H.GROUP_VAL || H.DIVISION_VAL ||H.AREA_VAL),
                                                'DCM_MGR') DCM_MGR
  FROM COST_CENTER CC,
        --inner sub query "T" gives all the hierarchy details with all the levels
        --present in the CCN system by joining the header, description and detail tables
       (WITH T AS (SELECT HDESC.HRCHY_HDR_LVL_DESC DESCRIPTION,
                          HD.HRCHY_DTL_CURR_ROW_VAL COST_CENTER_CODE,
                          HD.HRCHY_HDR_NAME,
                          HD.HRCHY_DTL_EFF_DATE,
                          HD.HRCHY_DTL_EXP_DATE,
                          HD.HRCHY_DTL_CURR_LVL_VAL,
                          --1 + sum of level values till that level - level value for that level = starting point for this level
                          SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1 + HDESC.SUM_VAL - HDESC.LVL_VALUE_SIZE, HDESC.LVL_VALUE_SIZE) VAL,
                          (SELECT HRCHY_DTL_DESC
                             FROM HIERARCHY_DETAIL
                            WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1, HDESC.SUM_VAL)
                              AND HRCHY_HDR_NAME  = HDESC.HRCHY_HDR_NAME
                              AND HRCHY_DTL_LEVEL = HDESC.HRCHY_HDR_LVL_NBR
                              AND ROWNUM < 2)  VAL_NAME
                     FROM HIERARCHY_DETAIL HD,
                          HIERARCHY_HEADER HH,
                          (SELECT HRCHY_HDR_NAME,
                                  HRCHY_HDR_LVL_NBR,
                                  HRCHY_HDR_LVL_DESC,
                                  LVL_VALUE_SIZE,
                                  SUM(LVL_VALUE_SIZE) OVER (PARTITION BY HRCHY_HDR_NAME ORDER BY HRCHY_HDR_LVL_NBR) SUM_VAL
                             FROM HIERARCHY_DESCRIPTION) HDESC
                    WHERE HD.HRCHY_HDR_NAME  = HDESC.HRCHY_HDR_NAME
                      AND HD.HRCHY_HDR_NAME  = HH.HRCHY_HDR_NAME
                      AND HD.HRCHY_DTL_LEVEL = HH.HRCHY_HDR_LEVELS
                      AND HD.HRCHY_HDR_NAME  = 'CREDIT_HIERARCHY'
                      AND NVL(HD.HRCHY_DTL_NEXT_LVL_VAL, '~~~') = '~~~')
             SELECT *
               FROM T
                    --PIVOT function convers this entire result set into a transpose (level of rows to level of columns)
                    --so that we get one record for each hierarchy with all level values as its columns
                    PIVOT 
                    (MAX(VAL) AS VAL,
                     MAX(VAL_NAME) AS VAL_NAME FOR (DESCRIPTION) IN ('Group' AS "GROUP",
                                                                     'Division' AS DIVISION,
                                                                     'Area' AS AREA,
                                                                     'District' AS DISTRICT,
                                                                     'DCO' AS DCO))) H
--Finally result of the above two steps(WITH T and PIVOT) will be a new result set "H" which can be used as any other
--table in a join condition
 WHERE CC.COST_CENTER_CODE = H.COST_CENTER_CODE
 ORDER BY COST_CENTER_CODE, HRCHY_HDR_NAME;
