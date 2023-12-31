/*******************************************************************************
Create Table GLOBAL_HIERARCHY_ATTRBT_MNTH_SNAP Same as GLOBAL_HIERARCHY_ATTRBT_VW Along With LOAD_DATE
Created  : 01/23/2019 SXG151 CCN
*******************************************************************************/
CREATE TABLE GLOBAL_HIERARCHY_ATTRBT_MNTH_SNAP
  (
    STATEMENT_TYPE           VARCHAR2(2),
    HRCHY_HDR_NAME           VARCHAR2(100) NOT NULL,
    COST_CENTER_CODE         VARCHAR2(6) NOT NULL,
    HRCHY_DTL_EFF_DATE       DATE NOT NULL,
    HRCHY_DTL_EXP_DATE       DATE,
    DOMAIN                   VARCHAR2(4000),
    "GROUP"                  VARCHAR2(4000),
    DIVISION                 VARCHAR2(4000),
    AREA                     VARCHAR2(4000),
    DISTRICT                 VARCHAR2(4000),
    CITY_SALES_MANAGER       VARCHAR2(4000),
    ZONE                     VARCHAR2(4000),
    SPECIAL_ROLES            VARCHAR2(4000),
    DOMAIN_NAME              VARCHAR2(100),
    GROUP_NAME               VARCHAR2(100),
    DIVISION_NAME            VARCHAR2(100),
    AREA_NAME                VARCHAR2(100),
    DISTRICT_NAME            VARCHAR2(100),
    CITY_SALES_MANAGER_NAME  VARCHAR2(100),
    ZONE_NAME                VARCHAR2(100),
    SPECIAL_ROLES_NAME       VARCHAR2(100),
    COST_CENTER_NAME         VARCHAR2(35) NOT NULL,
    DOMAIN_MGR_NAME          VARCHAR2(4000),
    GROUP_MGR_NAME           VARCHAR2(4000),
    DIV_MGR_NAME             VARCHAR2(4000),
    DIV_MGR_GEMS_ID          VARCHAR2(4000),
    AREA_MGR_NAME            VARCHAR2(4000),
    AREA_MGR_GEMS_ID         VARCHAR2(4000),
    DISTRICT_MGR_NAME        VARCHAR2(4000),
    DISTRICT_MGR_GEMS_ID     VARCHAR2(4000),
    CITY_MGR_NAME            VARCHAR2(4000),
    CITY_MGR_GEMS_ID         VARCHAR2(4000),
    CITY_SALES_MGR_FLAG      VARCHAR2(4000),
    CITY_SALES_MGR_FLAG_DESC VARCHAR2(4000),
    ZONE_MGR_NAME            VARCHAR2(4000),
    SPECIAL_ROLES_MGR_NAME   VARCHAR2(4000),
    CC_MGR_NAME              VARCHAR2(4000),
    DOMAIN_UPPER_VALUE        XMLTYPE ,
    GROUP_UPPER_VALUE         XMLTYPE ,
    DIV_UPPER_VALUE           XMLTYPE ,
    AREA_UPPER_VALUE          XMLTYPE ,
    DISTRICT_UPPER_VALUE      XMLTYPE ,
    CITY_UPPER_VALUE          XMLTYPE ,
    ZONE_UPPER_VALUE          XMLTYPE ,
    SPECIAL_ROLES_UPPER_VALUE XMLTYPE ,
    CC_UPPER_LVL_VALUE        XMLTYPE ,
    LOAD_DATE                 DATE
  );

CREATE INDEX GLOBAL_HIERARCHY_ATTRBT_MNTH_SNAP_IDX ON GLOBAL_HIERARCHY_ATTRBT_MNTH_SNAP (LOAD_DATE);