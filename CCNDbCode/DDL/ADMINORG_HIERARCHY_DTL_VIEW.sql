CREATE OR REPLACE VIEW ADMINORG_HIERARCHY_DTL_VIEW AS
  SELECT  
/*******************************************************************************
This View will give all the Admin Org Hierarchy details for the cost center passed

Created  : 05/08/2018 nxk927 CCN project
Modified : 
*******************************************************************************/
       DISTINCT
        CC.STATEMENT_TYPE
       ,H.HRCHY_HDR_NAME
       ,CC.COST_CENTER_CODE
       ,H.HRCHY_DTL_EFF_DATE
       ,H.HRCHY_DTL_EXP_DATE
       ,H.DOMAIN_VAL DOMAIN
       ,H.DIVISION_VAL "DIVISION"
       ,H.CONTROL_VAL CONTROL
       ,H.BUDGET_VAL BUDGET
       ,H.FUNCTIONAL_1_VAL FUNCTIONAL_1
       ,H.FUNCTIONAL_2_VAL FUNCTIONAL_2
       ,H.FUNCTIONAL_3_VAL "FUNCTIONAL_3"
       ,H.COST_CENTER_CODE AS COST_CENTER
       ,H.DOMAIN_VAL_NAME DOMAIN_NAME
       ,H.DIVISION_VAL_NAME DIVISION_NAME
       ,H.CONTROL_VAL_NAME CONTROL_NAME
       ,H.BUDGET_VAL_NAME BUDGET_NAME
       ,H.FUNCTIONAL_1_VAL_NAME FUNCTIONAL_1_NAME
       ,H.FUNCTIONAL_2_VAL_NAME FUNCTIONAL_2_NAME
       ,H.FUNCTIONAL_3_VAL_NAME FUNCTIONAL_3_NAME
       ,CC.COST_CENTER_NAME
FROM COST_CENTER CC,
        --inner sub query "T" gives all the hierarchy details with all the levels
        --present in the CCN system by joining the header, description and detail tables
       (WITH T AS (SELECT HDESC.HRCHY_HDR_LVL_DESC DESCRIPTION,
                          HD.HRCHY_DTL_CURR_ROW_VAL COST_CENTER_CODE,
                          HD.HRCHY_HDR_NAME,
                          HD.HRCHY_DTL_EFF_DATE,
                          HD.HRCHY_DTL_EXP_DATE,
                          HD.HRCHY_DTL_CURR_LVL_VAL,
                          -- 1 + sum of level values till that level - level value for that level = starting point for this level
                          -- Curr level value length - Already substringed = Remaining length
                          -- get the hierachy values upto cost center level skip the non existent values.
                          SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1 + HDESC.SUM_VAL - HDESC.LVL_VALUE_SIZE, CASE WHEN floor(LENGTH(HD.HRCHY_DTL_CURR_LVL_VAL)/4) < HRCHY_HDR_LVL_NBR+1  THEN 0 ELSE HDESC.LVL_VALUE_SIZE END) VAL,
                          --Get the description upto the existing levels only.
                          (SELECT HRCHY_DTL_DESC
                             FROM HIERARCHY_DETAIL
                            WHERE HRCHY_DTL_CURR_LVL_VAL = SUBSTR(HD.HRCHY_DTL_CURR_LVL_VAL, 1, HDESC.SUM_VAL)
                              AND HRCHY_DTL_LEVEL <  floor(LENGTH(HD.HRCHY_DTL_CURR_LVL_VAL)/4)
                              AND HRCHY_HDR_NAME  = HDESC.HRCHY_HDR_NAME
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
                      AND HD.HRCHY_HDR_NAME  = 'ADMINORG_HIERARCHY'
                      AND NVL(HD.HRCHY_DTL_NEXT_LVL_VAL, '~~~') = '~~~')
             SELECT *
               FROM T
                    --PIVOT function convers this entire result set into a transpose (level of rows to level of columns)
                    --so that we get one record for each hierarchy with all level values as its columns
                    PIVOT 
                    (MAX(VAL) AS VAL,
                     MAX(VAL_NAME) AS VAL_NAME FOR (DESCRIPTION) IN ('Domain'   AS DOMAIN,
                                                                     'Division' AS "DIVISION",
                                                                     'Control'  AS CONTROL,
                                                                     'Budget'   AS BUDGET,
                                                                     'Functional 1' AS FUNCTIONAL_1,
                                                                     'Functional 2' AS FUNCTIONAL_2,
                                                                     'Functional 3' AS "FUNCTIONAL_3"))) H
--Finally result of the above two steps(WITH T and PIVOT) will be a new result set "H" which can be used as any other
--table in a join condition
WHERE CC.COST_CENTER_CODE = H.COST_CENTER_CODE
ORDER BY COST_CENTER_CODE, HRCHY_HDR_NAME;