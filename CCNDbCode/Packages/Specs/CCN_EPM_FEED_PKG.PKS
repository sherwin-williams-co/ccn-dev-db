create or replace PACKAGE CCN_EPM_FEED_PKG 
AS 
/****************************************************************************** 
This package is intended to create EPM hierarchy file as an pipe delimited file

Created : 11/30/2017 sxg151 -- CCN Project Team...
Changed :
******************************************************************************/
TYPE CC_HIER_REC IS RECORD(
     LEGACY_DIVISION                 HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XXX'
    ,LEGACY_DIVISION_NAME            HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,DOMAIN                          HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XXX'
    ,DOMAIN_NAME                     HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,"GROUP"                         HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XXX'
    ,GROUP_NAME                      HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,DIVISION                        HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XX'
    ,DIVISION_NAME                   HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,AREA                            HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XX'
    ,AREA_NAME                       HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,DISTRICT                        HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XX'
    ,DISTRICT_NAME                   HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,CITY_SALES_MANAGER              HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XX'
    ,CITY_SALES_MANAGER_NAME         HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,"ZONE"                          HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XX'
    ,ZONE_NAME                       HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,COST_CENTER_CODE                COST_CENTER.COST_CENTER_CODE%TYPE             :='XXX'
    ,COST_CENTER_NAME                COST_CENTER.COST_CENTER_NAME%TYPE             :='XXX'
  );

TYPE CC_ADMINHIER_REC IS RECORD(
     LEGACY_DIVISION                 HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XXX'
    ,LEGACY_DIVISION_NAME            HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,DOMAIN                          HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XXX'
    ,DOMAIN_NAME                     HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,DIVISION                        HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XX'
    ,DIVISION_NAME                   HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,CONTROL                         HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XXX'
    ,CONTROL_NAME                    HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,BUDGET                          HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XXX'
    ,BUDGET_NAME                     HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,FUNC1                           HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XXX'
    ,FUNC1_NAME                      HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,FUNC2                           HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XXX'
    ,FUNC2_NAME                      HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,FUNC3                           HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE  :='XXX'
    ,FUNC3_NAME                      HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE          :='XXX'
    ,COST_CENTER_CODE                COST_CENTER.COST_CENTER_CODE%TYPE             :='XXX'
    ,COST_CENTER_NAME                COST_CENTER.COST_CENTER_NAME%TYPE             :='XXX'
  );

TYPE CCN_REC IS RECORD(
     COST_CENTER_CODE                COST_CENTER.COST_CENTER_NAME%TYPE
    ,COST_CENTER_NAME                COST_CENTER.COST_CENTER_NAME%TYPE 
    ,DIVISION                        GLBL_FACTS_LEGACY_VIEW.GLOBAL_DIVISION%TYPE
    ,AREA                            GLBL_FACTS_LEGACY_VIEW.GLOBAL_AREA%TYPE
    ,DISTRICT                        GLBL_FACTS_LEGACY_VIEW.GLOBAL_DISTRICT%TYPE
    ,CITY_SALES_MGR                  GLBL_FACTS_LEGACY_VIEW.GLOBAL_CITY_SALES_MGR%TYPE   
    ,MISSION_TYPE_CODE               COST_CENTER.MISSION_TYPE_CODE%TYPE
    ,MISSION_TYPE_CODE_DESC          CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE 
    ,BEGIN_DATE                      COST_CENTER.BEGIN_DATE%TYPE
    ,OPEN_DATE                       COST_CENTER.OPEN_DATE%TYPE  
    ,CLOSE_DATE                      COST_CENTER.CLOSE_DATE%TYPE    
    ,TYPE_CODE                       TYPE.TYPE_CODE%TYPE
    ,TYPE_CODE_DESC                  CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,TYPE_CODE_DESCRIPTION           CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE             
    ,STATUS_CODE                     STATUS.STATUS_CODE%TYPE   
    ,STATUS_CODE_DESC                CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE   
    ,TERRITORY_BUSN_CODE             TERRITORY.TERRITORY_TYPE_BUSN_CODE%TYPE  
    ,TERRITORY_BUSN_CODE_DESC        CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE  
    ,MKT_MISSION                     MARKETING.MKT_MISSION%TYPE  
    ,MKT_MISSION_DESC                CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE  
    ,CATEGORY                        COST_CENTER.CATEGORY%TYPE  
    ,CATEGORY_DESC                   CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE  
    ,ACQUISITION_CODE                COST_CENTER.ACQUISITION_CODE%TYPE  
    ,ACQUISITION_CODE_DESC           CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE  
    ,STATEMENT_TYPE                  COST_CENTER.STATEMENT_TYPE%TYPE  
    ,STATEMENT_TYPE_DESC             CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE  
    ,STATE_CODE                      ADDRESS_VW.STATE_CODE%TYPE  
    ,STATE_DESCRIPTION               ADDRESS_VW.STATE_CODE_DESCRIPTION%TYPE  
    ,PROVINCE_CODE                   ADDRESS_VW.PROVINCE_CODE%TYPE    
    ,PROVINCE_DESCRIPTION            ADDRESS_VW.PROVINCE_CODE_DESCRIPTION%TYPE    
    ,DIVISION_NAME                   GLBL_FACTS_LEGACY_VIEW.GLOBAL_DIVISION_NAME%TYPE    
    ,AREA_NAME                       GLBL_FACTS_LEGACY_VIEW.GLOBAL_AREA_NAME%TYPE   
    ,DISTRICT_NAME                   GLBL_FACTS_LEGACY_VIEW.GLOBAL_DISTRICT_NAME%TYPE   
    ,CITY_SALES_MGR_NAME             GLBL_FACTS_LEGACY_VIEW.GLOBAL_CITY_SALES_MGR_NAME%TYPE  
    ,DIV_MGR_NAME                    GLOBAL_HIERARCHY_ATTRBT_VW.DIV_MGR_NAME%TYPE  
    ,AREA_MGR_NAME                   GLOBAL_HIERARCHY_ATTRBT_VW.AREA_MGR_NAME%TYPE  
    ,DISTRICT_MGR_NAME               GLOBAL_HIERARCHY_ATTRBT_VW.DISTRICT_MGR_NAME%TYPE   
    ,CITY_SALES_MANAGER_NAME         GLOBAL_HIERARCHY_ATTRBT_VW.CITY_MGR_NAME%TYPE  
    ,CC_MGR_NAME                     GLOBAL_HIERARCHY_ATTRBT_VW.CITY_MGR_NAME%TYPE    
    ,TERRITORY_REP                   GLOBAL_HIERARCHY_ATTRBT_VW.CITY_MGR_NAME%TYPE
    ,CURRENCY_CODE                   COST_CENTER.CURRENCY_CODE%TYPE
    ,CURRENCY_CODE_DESC              CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,COA_DIVISION                    GLBL_FACTS_LEGACY_VIEW.COA_DIVISION%TYPE
    ,COA_DIVISION_NAME               GLBL_FACTS_LEGACY_VIEW.COA_DIVISION_NAME%TYPE
 );

PROCEDURE GENERATE_STORE_TERR_FILE
/****************************************************************************** 
This PROCEDURE generates the EPM hierarchy file as an pipe delimited file

Created : 12/13/2017 sxg151 -- CCN Project Team...
Changed :
******************************************************************************/
;

PROCEDURE GENERATE_ADMIN_FILE
/****************************************************************************** 
This PROCEDURE generates the EPM Admin hierarchy file as an pipe delimited file

Created : 05/11/2018 sxg151 -- CCN Project Team...
Changed :
******************************************************************************/
;

PROCEDURE GENERATE_EPM_FILES
/******************************************************************************
This PROCEDURE generates the EPM GENERATE_STORE_TERR_FILE/GENERATE_ADMIN_FILE file's as an pipe delimited file

Created : 05/30/2018 sxg151 -- CCN Project Team...
Changed :
******************************************************************************/
;

END CCN_EPM_FEED_PKG;