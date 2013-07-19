CREATE TABLE "COSTCNTR"."TEMP_REAL_ESTATE"
  (
    "COST_CENTER_CODE"      VARCHAR2(6 BYTE),
    "CATEGORY_CODE"         VARCHAR2(1 BYTE),
    "LAST_MAINT_DATE"       VARCHAR2(8 BYTE),
    "OPEN_TIME"             VARCHAR2(4 BYTE),
    "CLOSE_TIME"            VARCHAR2(4 BYTE),    
    "SUNDAY_OPEN_IND"       VARCHAR2(1 BYTE),
    "PERP_INV_START_DATE"   VARCHAR2(8 BYTE),
    "ACT_FT_EMP_CNT"        VARCHAR2(3 BYTE),
    "BGT_FT_EMP_CNT"        VARCHAR2(3 BYTE),
    "ACT_PT_EMP_CNT"        VARCHAR2(3 BYTE),
    "BGT_PT_EMP_CNT"        VARCHAR2(3 BYTE),
    "CLASS_CODE"            VARCHAR2(2 BYTE),
    "GNRC_GROUP_IND"        VARCHAR2(2 BYTE),
    "CONTROL_CLERK_CODE"    VARCHAR2(2 BYTE),
    "PERP_INV_IND"          VARCHAR2(1 BYTE),
    "SCHEDULE_CODE"         VARCHAR2(1 BYTE),
    "RURAL_METRO_ZONE_CODE" VARCHAR2(1 BYTE),
    "UPS_ZONE_CODE"         VARCHAR2(1 BYTE),
    "RPS_ZONE"              VARCHAR2(1 BYTE),
    "DEP_TKT_REORDER_SW"    VARCHAR2(1 BYTE),
    "BANK_TYPE"             VARCHAR2(1 BYTE),
    "INTERNAL_MAIL_NBR"     VARCHAR2(3 BYTE),
    "REMERCHANDISE_CODE"    VARCHAR2(1 BYTE),
    "PLANOGRAM_TYPE_CODE"   VARCHAR2(1 BYTE),
    "SHELF_LABEL_CODE"      VARCHAR2(1 BYTE),
    "SHELF_LABEL_COUNT"     VARCHAR2(3 BYTE),
    "DUNS_NBR"              VARCHAR2(9 BYTE),
    "DEP_BAG_REORDER_SW"    VARCHAR2(1 BYTE),
    "PRIMARY_LOGO_IND"      VARCHAR2(3 BYTE),
    "SECONDARY_LOGO_IND"    VARCHAR2(3 BYTE),
    "PART_TIME_SCHEDULE"    VARCHAR2(1 BYTE),
    "PROGRAM_TYPE_CODE"     VARCHAR2(2 BYTE),
    "PROGRAM_VERSION_NBR"   VARCHAR2(6 BYTE),
    "LEASE_OWN_CODE"        VARCHAR2(2 BYTE),
    "HOME_STORE"            VARCHAR2(6 BYTE),
    "MISSION_TYPE"          VARCHAR2(2 BYTE),
    "CARR_RETURN"           VARCHAR2(1 BYTE)
  )
  ORGANIZATION EXTERNAL
  (
    TYPE ORACLE_LOADER DEFAULT DIRECTORY "CCN_LOAD_FILES" ACCESS PARAMETERS ( RECORDS FIXED 103 FIELDS( COST_CENTER_CODE CHAR(6), CATEGORY_CODE CHAR(1), LAST_MAINT_DATE CHAR(8), OPEN_TIME CHAR(4), CLOSE_TIME CHAR(4), SUNDAY_OPEN_IND CHAR(1), PERP_INV_START_DATE CHAR(8), ACT_FT_EMP_CNT CHAR(3), BGT_FT_EMP_CNT CHAR(3), ACT_PT_EMP_CNT CHAR(3), BGT_PT_EMP_CNT CHAR(3), CLASS_CODE CHAR(2), GNRC_GROUP_IND CHAR(2), CONTROL_CLERK_CODE CHAR (2), PERP_INV_IND CHAR(1), SCHEDULE_CODE CHAR (1), RURAL_METRO_ZONE_CODE CHAR(1), UPS_ZONE_CODE CHAR(1), RPS_ZONE CHAR(1), DEP_TKT_REORDER_SW CHAR(1), BANK_TYPE CHAR(1), 
                                                                                                                            INTERNAL_MAIL_NBR CHAR(3), REMERCHANDISE_CODE CHAR(1), PLANOGRAM_TYPE_CODE CHAR(1), SHELF_LABEL_CODE CHAR(1), SHELF_LABEL_COUNT CHAR(3), DUNS_NBR CHAR(9), DEP_BAG_REORDER_SW CHAR(1), PRIMARY_LOGO_IND CHAR(3), SECONDARY_LOGO_IND CHAR(3), PART_TIME_SCHEDULE CHAR(1), PROGRAM_TYPE_CODE CHAR(2), PROGRAM_VERSION_NBR CHAR(6), LEASE_OWN_CODE CHAR(2), HOME_STORE CHAR(6), MISSION_TYPE CHAR(2), CARR_RETURN CHAR(1)) ) LOCATION ( 'CCN99CTR_REGON.TXT' )
  ) ;