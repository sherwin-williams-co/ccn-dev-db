/*******************************************************************************
This external table is used to update the Cost Center Marketing Fields. 

Created  : 09/01/2016 axd783 CCN Project....
Modified : 
*******************************************************************************/
CREATE TABLE CCN_MARKETING_DETAILS
     (
       COST_CENTER_CODE      VARCHAR2(6),
       IWC_BOOK_PLN_PROF     VARCHAR2(2),
       IWC_BIN_COUNT         VARCHAR2(4),
       SHRINK_WRAP_MCHN      VARCHAR2(1),
       BORDER_TOWER          VARCHAR2(1),
       RSDNTL_RSRCE_CNT      VARCHAR2(1),
       COML_RSRCE_CNTR       VARCHAR2(1),
       CLSE_OUT_RACKS        VARCHAR2(1),
       FLOOR_PM_ROSTER       VARCHAR2(1),
       CLSE_OUT_STORE        VARCHAR2(1),
       ADD_DATE              VARCHAR2(8),
       LAST_UPDATE_DATE      VARCHAR2(8),
       LAST_MAINT_AUTH_ID    VARCHAR2(6),
       IWC_PHY_BIN_CNT       VARCHAR2(4),
       BINVOL_IND            VARCHAR2(1),
       STYLE_PERFECT_IND     VARCHAR2(1),
       FLOORCOVERING_CLS     VARCHAR2(1),
       ARMSTRNG_MOTR_RKS     VARCHAR2(1),
       ARMSTRNG_STAT_RKS     VARCHAR2(1),
       CNGOLEUM_MOTR_RKS     VARCHAR2(1),
       CNGOLEUM_STAT_RKS     VARCHAR2(1),
       CARPET_WRKRM_IND      VARCHAR2(1),
       CARPET_UNIV_RK_CNT    VARCHAR2(1),
       CARPET_BOOK_RK_CNT    VARCHAR2(2),
       CARPET_STK_LOC_IND    VARCHAR2(1),
       WINDOW_TRMT_HX_CNT    VARCHAR2(1),
       WINDOW_TRMT_WL_CNT    VARCHAR2(1),
       WINDOW_TRMT_WL_TYP    VARCHAR2(1),
       SPRAY_EQP_RPR_IND     VARCHAR2(1),
       SPRAY_EQP_STK_IND     VARCHAR2(1),
       LEM2_IM_FACLTY_IND    VARCHAR2(1),
       CC_FACLTY_IND         VARCHAR2(1),
       LEM2_POP_KIT_CNT      VARCHAR2(1)
      )
  ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        BADFILE CCN_LOAD_FILES:'CCN_MARKETING_DETAILS.bad'
        LOGFILE CCN_LOAD_FILES:'CCN_MARKETING_DETAILS.log'
        DISCARDFILE CCN_LOAD_FILES:'CCN_MARKETING_DETAILS.dsc'
        SKIP 0
        FIELDS
        (
          COST_CENTER_CODE      POSITION(1:6)     CHAR(6),
          IWC_BOOK_PLN_PROF     POSITION(7:2)     CHAR(2),
          IWC_BIN_COUNT         POSITION(9:4)     CHAR(4),
          SHRINK_WRAP_MCHN      POSITION(13:1)    CHAR(1),
          BORDER_TOWER          POSITION(14:1)    CHAR(1),
          RSDNTL_RSRCE_CNT      POSITION(15:1)    CHAR(1),
          COML_RSRCE_CNTR       POSITION(16:1)    CHAR(1),
          CLSE_OUT_RACKS        POSITION(17:1)    CHAR(1),
          FLOOR_PM_ROSTER       POSITION(18:1)    CHAR(1),
          CLSE_OUT_STORE        POSITION(19:1)    CHAR(1),
          ADD_DATE              POSITION(20:8)    CHAR(8),
          LAST_UPDATE_DATE      POSITION(28:8)    CHAR(8),
          LAST_MAINT_AUTH_ID    POSITION(36:6)    CHAR(6),
          IWC_PHY_BIN_CNT       POSITION(42:4)    CHAR(4),
          BINVOL_IND            POSITION(46:1)    CHAR(1),
          STYLE_PERFECT_IND     POSITION(47:1)    CHAR(1),
          FLOORCOVERING_CLS     POSITION(48:1)    CHAR(1),
          ARMSTRNG_MOTR_RKS     POSITION(49:1)    CHAR(1),
          ARMSTRNG_STAT_RKS     POSITION(50:1)    CHAR(1),
          CNGOLEUM_MOTR_RKS     POSITION(51:1)    CHAR(1),
          CNGOLEUM_STAT_RKS     POSITION(52:1)    CHAR(1),
          CARPET_WRKRM_IND      POSITION(53:1)    CHAR(1),
          CARPET_UNIV_RK_CNT    POSITION(54:1)    CHAR(1),
          CARPET_BOOK_RK_CNT    POSITION(55:2)    CHAR(2),
          CARPET_STK_LOC_IND    POSITION(57:1)    CHAR(1),
          WINDOW_TRMT_HX_CNT    POSITION(58:1)    CHAR(1),
          WINDOW_TRMT_WL_CNT    POSITION(59:1)    CHAR(1),
          WINDOW_TRMT_WL_TYP    POSITION(60:1)    CHAR(1),
          SPRAY_EQP_RPR_IND     POSITION(61:1)    CHAR(1),
          SPRAY_EQP_STK_IND     POSITION(62:1)    CHAR(1),
          LEM2_IM_FACLTY_IND    POSITION(63:1)    CHAR(1),
          CC_FACLTY_IND         POSITION(64:1)    CHAR(1),
          LEM2_POP_KIT_CNT      POSITION(65:1)    CHAR(1)
         )
        )
    LOCATION
       ( 'CCN99CTR_OLDMRKT.TXT'
       )
    );
