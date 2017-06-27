/*
Script Name: COST_CENTER_DISPATCH_TERMINAL.sql
Purpose    : For dropping and creating the COST_CENTER_DISPATCH_TERMINAL table.
             This is an external table which is used for storing data from COST_CENTER_DISPATCH_TERMINAL.csv
             loaded through batch process.

Created    : 06/23/2017 rxa457 CCN Project....
*/

  DROP TABLE COST_CENTER_DISPATCH_TERMINAL;

  CREATE TABLE COST_CENTER_DISPATCH_TERMINAL
   (COST_CENTER_CODE VARCHAR2(6), 
    COST_CENTER_NAME VARCHAR2(35), 
    CATEGORY VARCHAR2(1), 
    ENTITY_TYPE VARCHAR2(2), 
    STATEMENT_TYPE VARCHAR2(2), 
    COUNTRY_CODE VARCHAR2(3), 
    TRANSPORT_TYPE VARCHAR2(5), 
    BEGIN_DATE VARCHAR2(8), 
    OPEN_DATE VARCHAR2(8), 
    MOVE_DATE VARCHAR2(8), 
    CLOSE_DATE VARCHAR2(8), 
    FINANCIAL_CLOSE_DATE VARCHAR2(8), 
    POS_PROG_VER_EFF_DATE VARCHAR2(8), 
    UPS_ZONE_CODE VARCHAR2(1), 
    RPS_ZONE_CODE VARCHAR2(1), 
    CURRENCY_CODE VARCHAR2(3), 
    POS_PROG_VER_NBR VARCHAR2(5), 
    LEASE_OWN_CODE VARCHAR2(1), 
    MISSION_TYPE_CODE VARCHAR2(2), 
    DUNS_NUMBER VARCHAR2(9), 
    PRI_LOGO_GROUP_IND VARCHAR2(3), 
    SCD_LOGO_GROUP_IND VARCHAR2(3), 
    BANKING_TYPE VARCHAR2(1), 
    DEPOSIT_BAG_REORDER VARCHAR2(1), 
    DEPOSIT_TICKET_REORDER VARCHAR2(1), 
    POP_KIT_CODE VARCHAR2(1), 
    GLOBAL_HIERARCHY_IND VARCHAR2(1), 
    STD_COST_IDENTIFIER VARCHAR2(2),
    PRIM_COST_IDENTIFIER VARCHAR2(2),
    STATUS_CODE VARCHAR2(1), 
    STATUS_EFFECTIVE_DATE VARCHAR2(8), 
    STATUS_EXPIRATION_DATE VARCHAR2(8), 
    TYPE_CODE VARCHAR2(2), 
    TYPE_EFFECTIVE_DATE VARCHAR2(8), 
    TYPE_EXPIRATION_DATE VARCHAR2(8), 
    DISPATCH_TERMINAL_CATEGORY VARCHAR2(1), 
    HOME_STORE VARCHAR2(6), 
    MARKETING_CATEGORY VARCHAR2(1), 
    MARKETING_TYPE VARCHAR2(2), 
    MKT_EFFECTIVE_DATE VARCHAR2(8), 
    MKT_EXPIRATION_DATE VARCHAR2(8), 
    MKT_BRAND VARCHAR2(1), 
    MKT_MISSION VARCHAR2(3), 
    MKT_SALES_FLOOR_SIZE VARCHAR2(1), 
    MKT_WAREHOUSE_SIZE VARCHAR2(1), 
    MKT_REAL_ESTATE_SETTING VARCHAR2(1), 
    TWJ_STATE VARCHAR2(2), 
    TWJ_ZIP VARCHAR2(10), 
    TWJ_GEO VARCHAR2(2), 
    TWJ_MAINTENANCE_DATE VARCHAR2(8), 
    TWJ_COUNTRY VARCHAR2(2), 
    TWJ_COMPANY VARCHAR2(2), 
    LAST_MAINT_DATE VARCHAR2(8), 
    LAST_MAINT_METHOD_ID VARCHAR2(8), 
    LAST_MAINT_USER_ID VARCHAR2(8), 
    PRI_PHONE_NUMBER_TYPE VARCHAR2(5), 
    PRI_PHONE_AREA_CODE VARCHAR2(4), 
    PRI_PHONE_NUMBER VARCHAR2(7), 
    PRI_PHONE_EXTENSION VARCHAR2(6), 
    SCD_PHONE_NUMBER_TYPE VARCHAR2(5), 
    SCD_PHONE_AREA_CODE VARCHAR2(4), 
    SCD_PHONE_NUMBER VARCHAR2(7), 
    SCD_PHONE_EXTENSION VARCHAR2(6), 
    FAX_PHONE_NUMBER_TYPE VARCHAR2(5), 
    FAX_PHONE_AREA_CODE VARCHAR2(4), 
    FAX_PHONE_NUMBER VARCHAR2(7), 
    FAX_PHONE_EXTENSION VARCHAR2(6), 
    ADMIN_TO_SALES_AREA VARCHAR2(100), 
    ADMIN_TO_SALES_DISTRICT VARCHAR2(100), 
    ADMIN_TO_SALES_DIVISION VARCHAR2(100), 
    ALTERNATE_DAD VARCHAR2(100), 
    FACTS_DIVISION VARCHAR2(100), 
    LEGACY_GL_DIVISION VARCHAR2(100), 
    GLOBAL_HIERARCHY VARCHAR2(100), 
    MANAGER_ID VARCHAR2(100 )
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "CCN_LOAD_FILES":'COST_CENTER_DISPATCH_TERMINAL.bad'
          logfile "CCN_LOAD_FILES":'COST_CENTER_DISPATCH_TERMINAL.log'
          FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LDRTRIM
          MISSING FIELD VALUES ARE NULL
          REJECT ROWS WITH ALL NULL FIELDS
                                       (COST_CENTER_CODE,
                                        COST_CENTER_NAME,
                                        CATEGORY,
                                        ENTITY_TYPE,
                                        STATEMENT_TYPE,
                                        COUNTRY_CODE,
                                        TRANSPORT_TYPE,
                                        BEGIN_DATE,
                                        OPEN_DATE,
                                        MOVE_DATE,
                                        CLOSE_DATE,
                                        FINANCIAL_CLOSE_DATE,
                                        POS_PROG_VER_EFF_DATE,
                                        UPS_ZONE_CODE,
                                        RPS_ZONE_CODE,
                                        CURRENCY_CODE,
                                        POS_PROG_VER_NBR,
                                        LEASE_OWN_CODE,
                                        MISSION_TYPE_CODE,
                                        DUNS_NUMBER,
                                        PRI_LOGO_GROUP_IND,
                                        SCD_LOGO_GROUP_IND,
                                        BANKING_TYPE,
                                        DEPOSIT_BAG_REORDER,
                                        DEPOSIT_TICKET_REORDER,
                                        POP_KIT_CODE,
                                        GLOBAL_HIERARCHY_IND,
                                        STD_COST_IDENTIFIER,
                                        PRIM_COST_IDENTIFIER,
                                        STATUS_CODE,
                                        STATUS_EFFECTIVE_DATE,
                                        STATUS_EXPIRATION_DATE,
                                        TYPE_CODE,
                                        TYPE_EFFECTIVE_DATE,
                                        TYPE_EXPIRATION_DATE,
                                        DISPATCH_TERMINAL_CATEGORY,
                                        HOME_STORE,
                                        MARKETING_CATEGORY,
                                        MARKETING_TYPE,
                                        MKT_EFFECTIVE_DATE,
                                        MKT_EXPIRATION_DATE,
                                        MKT_BRAND,
                                        MKT_MISSION,
                                        MKT_SALES_FLOOR_SIZE,
                                        MKT_WAREHOUSE_SIZE,
                                        MKT_REAL_ESTATE_SETTING,
                                        TWJ_STATE,
                                        TWJ_ZIP,
                                        TWJ_GEO,
                                        TWJ_MAINTENANCE_DATE,
                                        TWJ_COUNTRY,
                                        TWJ_COMPANY,
                                        LAST_MAINT_DATE,
                                        LAST_MAINT_METHOD_ID,
                                        LAST_MAINT_USER_ID,
                                        PRI_PHONE_NUMBER_TYPE,
                                        PRI_PHONE_AREA_CODE,
                                        PRI_PHONE_NUMBER,
                                        PRI_PHONE_EXTENSION,
                                        SCD_PHONE_NUMBER_TYPE,
                                        SCD_PHONE_AREA_CODE,
                                        SCD_PHONE_NUMBER,
                                        SCD_PHONE_EXTENSION,
                                        FAX_PHONE_NUMBER_TYPE,
                                        FAX_PHONE_AREA_CODE,
                                        FAX_PHONE_NUMBER,
                                        FAX_PHONE_EXTENSION,
                                        ADMIN_TO_SALES_AREA,
                                        ADMIN_TO_SALES_DISTRICT,
                                        ADMIN_TO_SALES_DIVISION,
                                        ALTERNATE_DAD,
                                        FACTS_DIVISION,
                                        LEGACY_GL_DIVISION,
                                        GLOBAL_HIERARCHY,
                                        MANAGER_ID)
                                        )
      LOCATION
       ( 'COST_CENTER_DISPATCH_TERMINAL.csv'
        )
    )
    REJECT LIMIT UNLIMITED ;