CREATE OR REPLACE VIEW CCN_COST_CENTER_INFO_VW AS 
SELECT 
/*******************************************************************************
This View contains all the records from CCN_COST_CENTER_INFO table 

Created  : 03/07/2018 bxa919 CCN Project....

*******************************************************************************/
          IGNORE
        , COST_CENTER
        , DIVISION
        , OLD_COST_CENTER
        , COST_CENTER_NAME
        , CREDIT_CENTER
        , BOOKKEEPER_UAR
        , AQUISITION_CODE
        , DAD
        , PHONE_NBR
        , RURAL_METRO_ZONE
        , COST_CENTER_CATEGORY
        , GNRC_GROUP_IND
        , ADDRESS_LINE1
        , ADDRESS_LINE2
        , CITY
        , STATE
        , ZIP_CODE4
        , COUNTY
        , COUNTRY_CODE
        , COST_CENTER_DIV5101
        , COST_CENTER_DIVISION
        , COST_CENTER_AREA
        , COST_CENTER_DISTICT
        , DIVISION_SGL
        , STATUS_CODE
        , TYPE_CODE
        , SALES_VOLUME_CLS_CD
        , IWC_BK_PLN_PROF_CD
        , IWC_BIN_COUNT
        , IWC_PHY_BIN_COUNT
        , IWC_BIN_CNT_5402
        , IWC_BIN_CNT_5403
        , BIN_VOL_IND
        , SPRY_EQUIP_RPR_IND
        , SPRY_EQUIP_STK_IND
        , IM_FACILITY_IND
        , CC_FACILITY_IND
        , POP_KIT_COUNT
        , DSC_CODE_PAINT
        , DSC_CODE_AP
        , DCS_CODE_WC
        , EMP_FIRST_NAME
        , EMP_MIDDL_NAME
        , EMP_LAST_NAME
        , ADI_CODE
        , SMSA_CODE
        , SALES_REP_TYPE_BUSN
        , MISSION_TYPE
        , FAX_NUMBER
        , SALES_REP_HOME_STORE
        , SHELF_LABEL_CODE
        , SHELF_LABEL_SET_CT
        , SHELF_LABEL_ACT_CD
        , POLLING_STATUS
        , COUNTY_CODE
        , ADDR_STATE_CD_NUM
        , CCNTR_DUNS_NBR
        , CCNTR_OPEN_DATE
        , CCNTR_MOVE_DATE
        , CCNTR_CLOSE_DATE
        , FILLER
        , FILE_NAME
        , FILLER_BYTE
FROM CCN_COST_CENTER_INFO ;
