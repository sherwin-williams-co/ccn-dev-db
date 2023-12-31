--POLLING_VIEW
---------------------------
CREATE MATERIALIZED VIEW "COSTCNTR"."POLLING_VIEW" ("COST_CENTER_CODE","POLLING_STATUS_CODE","MERCHANT_ID","EFFECTIVE_DATE","EXPIRATION_DATE","LAST_MAINT_DATE","LAST_MAINT_METHOD_ID","LAST_MAINT_USER_ID","QUALITY_CODE","AMEX_SE_ID","DISCOVER_ID","MULTICAST_IND","POLLING_IND","NEXT_DOWNLOAD_BLOCK_COUNT","TIME_ZONE","CURRENT_FLAG","TERMINAL_NUMBER","TER_EFF_DATE","TER_EXP_DATE","POS_LAST_TRAN_DATE","POS_LAST_TRAN_NUMBER") 
  BUILD IMMEDIATE
  USING INDEX REFRESH COMPLETE ON DEMAND
  USING DEFAULT LOCAL ROLLBACK SEGMENT  USING ENFORCED CONSTRAINTS
  ENABLE QUERY REWRITE AS 
  SELECT DISTINCT B.COST_CENTER_CODE, B.POLLING_STATUS_CODE, B.MERCHANT_ID, B.EFFECTIVE_DATE, B.EXPIRATION_DATE, B.LAST_MAINT_DATE, B.LAST_MAINT_METHOD_ID, 
    B.LAST_MAINT_USER_ID, B.QUALITY_CODE, B.AMEX_SE_ID, B.DISCOVER_ID, P.MULTICAST_IND,P.POLLING_IND, P.NEXT_DOWNLOAD_BLOCK_COUNT, P.TIME_ZONE, P.CURRENT_FLAG, 
     T.TERMINAL_NUMBER,T.EFFECTIVE_DATE as ter_eff_date, T.EXPIRATION_DATE as ter_exp_date, T.POS_LAST_TRAN_DATE,T.POS_LAST_TRAN_NUMBER
    FROM BANK_CARD B, POLLING P, TERMINAL T
    WHERE B.COST_CENTER_CODE = P.COST_CENTER_CODE
    AND B.COST_CENTER_CODE = T.COST_CENTER_CODE
    AND B.POLLING_STATUS_CODE = P.POLLING_STATUS_CODE;

--COST_CENTER_VIEW
---------------------------
CREATE MATERIALIZED VIEW "COSTCNTR"."COST_CENTER_VIEW" ("COST_CENTER_CODE","COST_CENTER_NAME","CC_CATEGTORY","ENTITY_TYPE","STATEMENT_TYPE","COUNTRY_CODE","BEGIN_DATE","OPEN_DATE","CLOSE_DATE","CURRENCY_CODE","TRANSPORT_TYPE","MOVE_DATE","FINANCIAL_CLOSE_DATE","POS_PROG_VER_EFF_DATE","UPS_ZONE_CODE","RPS_ZONE_CODE","POS_PROG_VER_NBR","LEASE_OWN_CODE","MISSION_TYPE_CODE","DUNS_NUMBER","PRI_LOGO_GROUP_IND","SCD_LOGO_GROUP_IND","BANKING_TYPE","DEPOSIT_BAG_REORDER","DEPOSIT_TICKET_REORDER","POP_KIT_CODE","GLOBAL_HIERARCHY_IND","STATUS_CODE","EFFECTIVE_DATE","EXPIRATION_DATE","PHONE_NUMBER_TYPE","PHONE_AREA_CODE","PHONE_NUMBER","PHONE_EXTENSION","CATEGORY","MARKETING_TYPE","MAR_EFF_DATE","MAR_EXP_DATE","MKT_BRAND","MKT_MISSION","MKT_SALES_FLOOR_SIZE","MKT_WAREHOUSE_SIZE","MKT_REAL_ESTATE_SETTING","ST_CATEGORY","PERP_INV_START_DATE","CLASSIFICATION_CODE","INVENTORY_INDICATOR","RURAL_METRO_ZONE_CODE","SELLING_STORE_FLAG","TWJ_STATE","TWJ_ZIP","TWJ_GEO","TWJ_MAINTENANCE_DATE","TWJ_COUNTRY","TWJ_COMPANY","LAST_MAINT_DATE","LAST_MAINT_METHOD_ID","LAST_MAINT_USER_ID","TYPE_CODE","TY_EFF_DATE","TY_EXP_DATE") 
  BUILD IMMEDIATE
  USING INDEX REFRESH COMPLETE ON DEMAND
  USING DEFAULT LOCAL ROLLBACK SEGMENT  USING ENFORCED CONSTRAINTS
  ENABLE QUERY REWRITE AS 
  SELECT  distinct C.COST_CENTER_CODE, C.COST_CENTER_NAME, C.CATEGORY AS CC_CATEGTORY, C.ENTITY_TYPE, 
									  C.STATEMENT_TYPE,C.COUNTRY_CODE, C.BEGIN_DATE, C.OPEN_DATE, C.CLOSE_DATE, C.CURRENCY_CODE,
									  C.TRANSPORT_TYPE, C.MOVE_DATE, C.FINANCIAL_CLOSE_DATE, C.POS_PROG_VER_EFF_DATE,
									  C.UPS_ZONE_CODE, C.RPS_ZONE_CODE, C.POS_PROG_VER_NBR, C.lEASE_OWN_CODE, 
									  C.MISSION_TYPE_CODE, C.DUNS_NUMBER, C.PRI_LOGO_GROUP_IND, C.SCD_LOGO_GROUP_IND, C.BANKING_TYPE,
									  C.DEPOSIT_BAG_REORDER, C.DEPOSIT_TICKET_REORDER, C.POP_KIT_CODE, C.GLOBAL_HIERARCHY_IND, S.STATUS_CODE, 
									  S.EFFECTIVE_DATE, S.EXPIRATION_DATE, P.PHONE_NUMBER_TYPE, P.PHONE_AREA_CODE, P.PHONE_NUMBER, P.PHONE_EXTENSION,
									  M.CATEGORY, M.MARKETING_TYPE, M.EFFECTIVE_DATE AS MAR_EFF_DATE, M.EXPIRATION_DATE AS MAR_EXP_DATE,
									  M.MKT_BRAND, M.MKT_MISSION, M.MKT_SALES_FLOOR_SIZE, M.MKT_WAREHOUSE_SIZE, M.MKT_REAL_ESTATE_SETTING,
									  ST.CATEGORY ST_CATEGORY, ST.PERP_INV_START_DATE, ST.CLASSIFICATION_CODE, ST.INVENTORY_INDICATOR, ST.RURAL_METRO_ZONE_CODE,
									  ST.SELLING_STORE_FLAG, TX.TWJ_STATE, TX. TWJ_ZIP, TX. TWJ_GEO, TX.TWJ_MAINTENANCE_DATE, TX.TWJ_COUNTRY, TX.TWJ_COMPANY,
									  TX.LAST_MAINT_DATE, TX.LAST_MAINT_METHOD_ID, TX.LAST_MAINT_USER_ID, T.TYPE_CODE, T.EFFECTIVE_DATE AS TY_EFF_DATE, T.EXPIRATION_DATE AS TY_EXP_DATE
									  FROM COST_CENTER C, STORE ST, MARKETING M, STATUS S, TAXWARE TX, TYPE T, PHONE P
								 WHERE C.COST_CENTER_CODE = S.COST_CENTER_CODE
								    AND C.COST_CENTER_CODE = T.COST_CENTER_CODE
									AND C.COST_CENTER_CODE = ST.COST_CENTER_CODE
									AND C.COST_CENTER_CODE = TX.COST_CENTER_CODE
									AND C.COST_CENTER_CODE = M.COST_CENTER_CODE
                                    AND C.COST_CENTER_CODE = P.COST_CENTER_CODE
									AND P.PHONE_NUMBER_TYPE = 'PRI'
									AND S.EXPIRATION_DATE is null
									AND T.EXPIRATION_DATE is null
									AND M.EXPIRATION_DATE is null;

--ADDRESS_ALL
---------------------------
CREATE MATERIALIZED VIEW "COSTCNTR"."ADDRESS_ALL" ("COST_CENTER_CODE","ADDRESS_TYPE","EFFECTIVE_DATE","EXPIRATION_DATE","ADDRESS_LINE_1","ADDRESS_LINE_2","ADDRESS_LINE_3","CITY","PROVINCE_CODE","STATE_CODE","POSTAL_CODE","ZIP_CODE","ZIP_CODE_4","COUNTY","FIPS_CODE","DESTINATION_POINT","CHECK_DIGIT","VALID_ADDRESS","COUNTRY_CODE") 
  BUILD IMMEDIATE
  USING INDEX REFRESH COMPLETE ON DEMAND
  USING DEFAULT LOCAL ROLLBACK SEGMENT  USING ENFORCED CONSTRAINTS
  ENABLE QUERY REWRITE AS 
  SELECT COST_CENTER_CODE
,ADDRESS_TYPE
,EFFECTIVE_DATE
,EXPIRATION_DATE
,ADDRESS_LINE_1
,ADDRESS_LINE_2
,ADDRESS_LINE_3
,CITY
,PROVINCE_CODE
,STATE_CODE
,POSTAL_CODE
,NULL AS ZIP_CODE
,NULL AS ZIP_CODE_4
,NULL AS COUNTY
,NULL AS FIPS_CODE
,NULL AS DESTINATION_POINT
,NULL AS CHECK_DIGIT
,VALID_ADDRESS
,COUNTRY_CODE
 FROM ADDRESS_OTHER

UNION

SELECT
COST_CENTER_CODE
,ADDRESS_TYPE
,EFFECTIVE_DATE
,EXPIRATION_DATE
,ADDRESS_LINE_1
,ADDRESS_LINE_2
,ADDRESS_LINE_3
,CITY
,NULL AS PROVINCE_CODE
,STATE_CODE
,NULL AS POSTAL_CODE
,ZIP_CODE
,ZIP_CODE_4
,COUNTY
,FIPS_CODE
,DESTINATION_POINT
,CHECK_DIGIT
,VALID_ADDRESS
,COUNTRY_CODE
FROM ADDRESS_USA

UNION

SELECT 
COST_CENTER_CODE
,ADDRESS_TYPE
,EFFECTIVE_DATE
,EXPIRATION_DATE
,ADDRESS_LINE_1
,ADDRESS_LINE_2
,ADDRESS_LINE_3
,CITY
,PROVINCE_CODE
,NULL AS STATE_CODE
,POSTAL_CODE
,NULL AS ZIP_CODE
,NULL AS ZIP_CODE_4
,NULL AS COUNTY
,NULL AS FIPS_CODE
,NULL AS DESTINATION_POINT
,NULL AS CHECK_DIGIT
,VALID_ADDRESS
,COUNTRY_CODE
FROM ADDRESS_CAN

UNION 
SELECT 
COST_CENTER_CODE
,ADDRESS_TYPE
,EFFECTIVE_DATE
,EXPIRATION_DATE
,ADDRESS_LINE_1
,ADDRESS_LINE_2
,ADDRESS_LINE_3
,CITY
,PROVINCE_CODE
,NULL AS STATE_CODE
,POSTAL_CODE
,NULL AS ZIP_CODE
,NULL AS ZIP_CODE_4
,NULL AS COUNTY
,NULL AS FIPS_CODE
,NULL AS DESTINATION_POINT
,NULL AS CHECK_DIGIT
,VALID_ADDRESS
,COUNTRY_CODE
FROM ADDRESS_MEX;
