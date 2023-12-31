create or replace PACKAGE CCN_MAPS_FEED_PKG AS 
/****************************************************************************** 
This package is used generate csv file for geographic information and research team 

created : 11/30/2017 mxv711 -- CCN Project Team...
******************************************************************************/
TYPE CC_MAP_FEED_REC IS RECORD(
     COST_CENTER_CODE                COST_CENTER.COST_CENTER_CODE%TYPE
    ,COST_CENTER_NAME                COST_CENTER.COST_CENTER_NAME%TYPE
    ,STATEMENT_TYPE                  COST_CENTER.STATEMENT_TYPE%TYPE
    ,STATEMENT_TYPE_DESC             CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,MISSION_TYPE_CODE               COST_CENTER.MISSION_TYPE_CODE%TYPE
    ,MISSION_TYPE_CODE_DESC          CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,OPEN_DATE                       varchar2(100)
    ,MOVE_DATE                       varchar2(100)
    ,CC_TEMP_CLOSED_CD               COST_CENTER.CC_TEMP_CLOSED_CD%TYPE
    ,CC_TEMP_CLOSED_CD_DESC          CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,LEASE_OWN_CODE                  COST_CENTER.LEASE_OWN_CODE%TYPE
    ,LEASE_OWN_CODE_DESC             CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,CIW_COLOR_CONSULTANT_TYPE_DESC  CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,HCR_COLOR_CONSULTANT_TYPE_DESC  CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,HOA_COLOR_CONSULTANT_TYPE_DESC  CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,ISR_COLOR_CONSULTANT_TYPE_DESC  CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,PCC_COLOR_CONSULTANT_TYPE_DESC  CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,PCL_COLOR_CONSULTANT_TYPE_DESC  CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,SWD_COLOR_CONSULTANT_TYPE_DESC  CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,COUNTRY_CODE                    COST_CENTER.COUNTRY_CODE%TYPE
    ,MKT_MISSION                     MARKETING.MKT_MISSION%TYPE
    ,MKT_SALES_FLOOR_SIZE            MARKETING.MKT_SALES_FLOOR_SIZE%TYPE
    ,MKT_WAREHOUSE_SIZE              MARKETING.MKT_WAREHOUSE_SIZE%TYPE
    ,MKT_REAL_ESTATE_SETTING         MARKETING.MKT_REAL_ESTATE_SETTING%TYPE
    ,MKT_MISSION_DESC                CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,MKT_SALES_FLOOR_SIZE_DESC       CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,MKT_WAREHOUSE_SIZE_DESC         CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE
    ,MKT_REAL_ESTATE_SETTING_DESC    CODE_DETAIL.CODE_DETAIL_DESCRIPTION%TYPE    
    ,MKT_CATEGORY                    MARKETING."CATEGORY"%TYPE
    ,DOMAIN                          HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE
    ,"GROUP"                         HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE
    ,DIVISION                        HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE
    ,LEGACY_DIVISION                 HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE
    ,AREA                            HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE
    ,HIR_DISTRICT                    HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE
    ,CITY_SALES_MANAGER              HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE
    ,DOMAIN_NAME                     HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE
    ,GROUP_NAME                      HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE
    ,DIVISION_NAME                   HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE
    ,AREA_NAME                       HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE
    ,HIR_DISTRICT_NAME               HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE
    ,CITY_SALES_MANAGER_NAME         HIERARCHY_DETAIL.HRCHY_DTL_DESC%TYPE
    ,PHONE_AREA_CODE                 PHONE.PHONE_AREA_CODE%TYPE
    ,PHONE_NUMBER                    PHONE.PHONE_NUMBER %TYPE
    ,PHONE_EXTENSION                 PHONE.PHONE_EXTENSION%TYPE
    ,PHONE_NUMBER_TYPE               PHONE.PHONE_NUMBER_TYPE%TYPE
  );
  


PROCEDURE GENERATE_MAPS_FEED_FILE
/****************************************************************************** 
This PROCEDURE generates the xml file for store cost centers

created : 11/30/2017 mxv711 -- CCN Project Team...

******************************************************************************/
;

                
END CCN_MAPS_FEED_PKG;