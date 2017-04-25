/*
Script Name: COST_CENTER_TERRITORY.sql
Purpose    : For dropping and creating the COST_CENTER_TERRITORY table.
             This is an external table which is used for storing data from COST_CENTER_TERRITORY.csv 
             loaded through batch process.

Created : 04/25/2017 gxg192 CCN Project....
Changed : 
*/

DROP TABLE COST_CENTER_TERRITORY;

CREATE TABLE "COSTCNTR"."COST_CENTER_TERRITORY"
   (
      "COST_CENTER_CODE"         VARCHAR2(6 BYTE),
      "COST_CENTER_NAME"         VARCHAR2(35 BYTE),
      "CATEGORY"                 VARCHAR2(1 BYTE),
      "ENTITY_TYPE"              VARCHAR2(2 BYTE),
      "STATEMENT_TYPE"           VARCHAR2(2 BYTE),
      "COUNTRY_CODE"             VARCHAR2(3 BYTE),
      "TRANSPORT_TYPE"           VARCHAR2(5 BYTE),
      "BEGIN_DATE"               VARCHAR2(8 BYTE),
      "OPEN_DATE"                VARCHAR2(8 BYTE),
      "MOVE_DATE"                VARCHAR2(8 BYTE),
      "CLOSE_DATE"               VARCHAR2(8 BYTE),
      "FINANCIAL_CLOSE_DATE"     VARCHAR2(8 BYTE),
      "POS_PROG_VER_EFF_DATE"    VARCHAR2(8 BYTE),
      "UPS_ZONE_CODE"            VARCHAR2(1 BYTE),
      "RPS_ZONE_CODE"            VARCHAR2(1 BYTE),
      "CURRENCY_CODE"            VARCHAR2(3 BYTE),
      "POS_PROG_VER_NBR"         VARCHAR2(5 BYTE),
      "LEASE_OWN_CODE"           VARCHAR2(1 BYTE),
      "MISSION_TYPE_CODE"        VARCHAR2(2 BYTE),
      "DUNS_NUMBER"              VARCHAR2(9 BYTE),
      "PRI_LOGO_GROUP_IND"       VARCHAR2(3 BYTE),
      "SCD_LOGO_GROUP_IND"       VARCHAR2(3 BYTE),
      "BANKING_TYPE"             VARCHAR2(1 BYTE),
      "DEPOSIT_BAG_REORDER"      VARCHAR2(1 BYTE),
      "DEPOSIT_TICKET_REORDER"   VARCHAR2(1 BYTE),
      "POP_KIT_CODE"             VARCHAR2(1 BYTE),
      "GLOBAL_HIERARCHY_IND"     VARCHAR2(1 BYTE),
      "STD_COST_IDENTIFIER"      VARCHAR2(2 BYTE),
      "PRIM_COST_IDENTIFIER"     VARCHAR2(2 BYTE),
      "STATUS_CODE"              VARCHAR2(1 BYTE),
      "STATUS_EFFECTIVE_DATE"    VARCHAR2(8 BYTE),
      "STATUS_EXPIRATION_DATE"   VARCHAR2(8 BYTE),
      "TYPE_CODE"                VARCHAR2(2 BYTE),
      "TYPE_EFFECTIVE_DATE"      VARCHAR2(8 BYTE),
      "TYPE_EXPIRATION_DATE"     VARCHAR2(8 BYTE),
      "TERRITORY_SLS_MGR_CODE"   VARCHAR2(6 BYTE),
      "TERRITORY_CATEGORY"       VARCHAR2(1 BYTE),
      "LEASE_CAR_INDICATOR"      VARCHAR2(1 BYTE),
      "TERRITORY_TYPE_BUSN_CODE" VARCHAR2(2 BYTE),
      "HOME_STORE"               VARCHAR2(6 BYTE),
      "PRI_PHONE_NUMBER_TYPE"    VARCHAR2(5 BYTE),
      "PRI_PHONE_AREA_CODE"      VARCHAR2(4 BYTE),
      "PRI_PHONE_NUMBER"         VARCHAR2(7 BYTE),
      "PRI_PHONE_EXTENSION"      VARCHAR2(6 BYTE),
      "SCD_PHONE_NUMBER_TYPE"    VARCHAR2(5 BYTE),
      "SCD_PHONE_AREA_CODE"      VARCHAR2(4 BYTE),
      "SCD_PHONE_NUMBER"         VARCHAR2(7 BYTE),
      "SCD_PHONE_EXTENSION"      VARCHAR2(6 BYTE),
      "FAX_PHONE_NUMBER_TYPE"    VARCHAR2(5 BYTE),
      "FAX_PHONE_AREA_CODE"      VARCHAR2(4 BYTE),
      "FAX_PHONE_NUMBER"         VARCHAR2(7 BYTE),
      "FAX_PHONE_EXTENSION"      VARCHAR2(6 BYTE),
      "ADMIN_TO_SALES_AREA"      VARCHAR2(100 BYTE),
      "ADMIN_TO_SALES_DISTRICT"  VARCHAR2(100 BYTE),
      "ADMIN_TO_SALES_DIVISION"  VARCHAR2(100 BYTE),
      "ALTERNATE_DAD"            VARCHAR2(100 BYTE),
      "FACTS_DIVISION"           VARCHAR2(100 BYTE),
      "LEGACY_GL_DIVISION"       VARCHAR2(100 BYTE),
      "GLOBAL_HIERARCHY"         VARCHAR2(100 BYTE),
      "MANAGER_ID"               VARCHAR2(100 BYTE)
   )
   ORGANIZATION EXTERNAL
   (
      TYPE ORACLE_LOADER DEFAULT DIRECTORY "CCN_LOAD_FILES" ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
      badfile "CCN_LOAD_FILES":'COST_CENTER_TERRITORY.bad'
      logfile "CCN_LOAD_FILES":'COST_CENTER_TERRITORY.log'
      FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LDRTRIM
      MISSING FIELD VALUES ARE NULL
      REJECT ROWS
WITH ALL NULL FIELDS (COST_CENTER_CODE, COST_CENTER_NAME, CATEGORY, ENTITY_TYPE
   , STATEMENT_TYPE, COUNTRY_CODE, TRANSPORT_TYPE, BEGIN_DATE, OPEN_DATE,
   MOVE_DATE, CLOSE_DATE, FINANCIAL_CLOSE_DATE, POS_PROG_VER_EFF_DATE,
   UPS_ZONE_CODE, RPS_ZONE_CODE, CURRENCY_CODE, POS_PROG_VER_NBR,
   LEASE_OWN_CODE, MISSION_TYPE_CODE, DUNS_NUMBER, PRI_LOGO_GROUP_IND,
   SCD_LOGO_GROUP_IND, BANKING_TYPE, DEPOSIT_BAG_REORDER,
   DEPOSIT_TICKET_REORDER, POP_KIT_CODE, GLOBAL_HIERARCHY_IND,
   STD_COST_IDENTIFIER, PRIM_COST_IDENTIFIER, STATUS_CODE,
   STATUS_EFFECTIVE_DATE, STATUS_EXPIRATION_DATE, TYPE_CODE,
   TYPE_EFFECTIVE_DATE, TYPE_EXPIRATION_DATE, TERRITORY_SLS_MGR_CODE,
   TERRITORY_CATEGORY, LEASE_CAR_INDICATOR, TERRITORY_TYPE_BUSN_CODE,
   HOME_STORE, PRI_PHONE_NUMBER_TYPE, PRI_PHONE_AREA_CODE, PRI_PHONE_NUMBER,
   PRI_PHONE_EXTENSION, SCD_PHONE_NUMBER_TYPE, SCD_PHONE_AREA_CODE,
   SCD_PHONE_NUMBER, SCD_PHONE_EXTENSION, FAX_PHONE_NUMBER_TYPE,
   FAX_PHONE_AREA_CODE, FAX_PHONE_NUMBER, FAX_PHONE_EXTENSION,
   ADMIN_TO_SALES_AREA, ADMIN_TO_SALES_DISTRICT, ADMIN_TO_SALES_DIVISION,
   ALTERNATE_DAD, FACTS_DIVISION, LEGACY_GL_DIVISION, GLOBAL_HIERARCHY,
   MANAGER_ID) ) LOCATION ( 'COST_CENTER_TERRITORY.csv' )
   )
   REJECT LIMIT UNLIMITED;