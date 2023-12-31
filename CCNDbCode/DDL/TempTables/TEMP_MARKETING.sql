CREATE TABLE "COSTCNTR"."TEMP_MARKETING"
  (
    "COST_CENTER_CODE"      VARCHAR2(6 BYTE),
    "CATEGORY_CODE"         VARCHAR2(1 BYTE),
    "MARKETING_TYPE"        VARCHAR2(2 BYTE),
    "EFFECTIVE_DATE"        VARCHAR2(8 BYTE),
    "EXPIRATION_DATE"       VARCHAR2(8 BYTE),
    "MARKET_BRAND"          VARCHAR2(1 BYTE),
    "MARKET_MISSION"        VARCHAR2(3 BYTE),
    "SALES_FLOOR_SIZE"      VARCHAR2(1 BYTE),
    "STOCK_ROOM_SIZE"       VARCHAR2(1 BYTE),
    "REAL_ESTATE_SETTING"   VARCHAR2(1 BYTE),
    "CARR_RETURN"           VARCHAR2(1 BYTE)
  )
  ORGANIZATION EXTERNAL
  (
    TYPE ORACLE_LOADER DEFAULT DIRECTORY "CCN_LOAD_FILES" ACCESS PARAMETERS ( RECORDS FIXED 34 FIELDS( COST_CENTER_CODE CHAR(6), CATEGORY_CODE CHAR(1), MARKETING_TYPE CHAR(2), EFFECTIVE_DATE CHAR(8), EXPIRATION_DATE CHAR(8), 
                                                                                                       MARKET_BRAND CHAR(1), MARKET_MISSION CHAR(3), SALES_FLOOR_SIZE CHAR(1), STOCK_ROOM_SIZE CHAR(1), REAL_ESTATE_SETTING CHAR(1),
                                                                                                       CARR_RETURN CHAR(1)) ) LOCATION ( 'CCN99CTR_MARKT.TXT')
   ) ;