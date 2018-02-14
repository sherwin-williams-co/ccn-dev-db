create or replace PACKAGE CCN_EPM_FEED_PKG 
AS 
/****************************************************************************** 
This package is intended to create store and reps hierarchy file as an pipe 
delimited file for EPM
created : 1/3/2017 mxv711 -- CCN coding project
******************************************************************************/
TYPE CC_HIER_REC IS RECORD(
     LEGACY_DIVISION                 HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE:='XXX'
    ,LEGACY_DIVISION_NAME            HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE:='XXX'
    ,DOMAIN                          HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE:='XXX'
    ,DOMAIN_NAME                     HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE:='XXX'
    ,"GROUP"                         HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE:='XXX'
    ,GROUP_NAME                      HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE:='XXX'
    ,DIVISION                        HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE:='XX'
    ,DIVISION_NAME                   HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE:='XXX'
    ,AREA                            HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE:='XX'
    ,AREA_NAME                       HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE:='XXX'
    ,DISTRICT                        HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE:='XX'
    ,DISTRICT_NAME                   HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE:='XXX'
    ,CITY_SALES_MANAGER              HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE:='XX'
    ,CITY_SALES_MANAGER_NAME         HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE:='XXX'
    ,"ZONE"                          HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE:='XX'
    ,ZONE_NAME                       HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE:='XXX'
    ,COST_CENTER_CODE                COST_CENTER.COST_CENTER_CODE%TYPE:='XXX'
    ,COST_CENTER_NAME                COST_CENTER.COST_CENTER_NAME%TYPE:='XXX'
    ,"CATEGORY"                      COST_CENTER."CATEGORY"%TYPE:='X'
  );
  


PROCEDURE GENERATE_FILE
/****************************************************************************** 
This PROCEDURE generates the pipe delimited file for cost center information for EPM

created : 12/13/2017 mxv711 -- CCN Project Team...

******************************************************************************/
;
                
END CCN_EPM_FEED_PKG;