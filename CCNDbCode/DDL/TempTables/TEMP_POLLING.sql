
-- Define TEMP_POLLING
-- Updated: tal 08/29/2012

DROP   TABLE "COSTCNTR"."TEMP_POLLING" ;

CREATE TABLE "COSTCNTR"."TEMP_POLLING"
  (
    COST_CENTER_CODE           VARCHAR2(06 BYTE) ,
    POLLING_STATUS_CODE        VARCHAR2(01 BYTE) ,
    POLLING_PHONE_PFX          VARCHAR2(18 BYTE) ,
    POLLING_PHONE_NUMBER       VARCHAR2(15 BYTE) ,
    MULTICAST_IND              VARCHAR2(01 BYTE) ,
    TIME_ZONES                 VARCHAR2(02 BYTE) ,
    POLLING_WATS_BAND          VARCHAR2(02 BYTE) ,
    LAST_UPLOAD_STATUS         VARCHAR2(02 BYTE) ,
    LAST_UPLOAD_DATE           VARCHAR2(08 BYTE) ,
    LAST_DOWNLOAD_STATUS       VARCHAR2(02 BYTE) ,
    LAST_DOWNLOAD_DATE         VARCHAR2(08 BYTE) ,
    SPECIAL_RUN_INDICATOR      VARCHAR2(01 BYTE) ,
    OVER_VOLUME_INDICATOR      VARCHAR2(01 BYTE) ,
    POLLING_INDICATOR          VARCHAR2(01 BYTE) ,
    POLLING_PRIORITY           VARCHAR2(03 BYTE) ,
    POLLING_SCHEDULE           VARCHAR2(01 BYTE) ,
    POLLING_STATUS_MAINT_DATE  VARCHAR2(08 BYTE) ,
    NEXT_DOWNLOAD_BLOCK_COUNT  VARCHAR2(09 BYTE)  
  )
  
ORGANIZATION EXTERNAL

  ( TYPE ORACLE_LOADER DEFAULT DIRECTORY CCN_LOAD_FILES ACCESS PARAMETERS 
  ( RECORDS FIXED 097

FIELDS ( 
    COST_CENTER_CODE           CHAR(06) ,
    SPACES_01                  CHAR(01) ,
    COST_CENTER_CODE_OLD       CHAR(04) ,
    SPACES_02                  CHAR(01) ,
    POLLING_STATUS_CODE        CHAR(01) ,
    POLLING_PHONE_PFX          CHAR(18) ,
    POLLING_PHONE_NUMBER       CHAR(15) ,
    MULTICAST_IND              CHAR(01) ,
    TIME_ZONES                 CHAR(02) ,
    POLLING_WATS_BAND          CHAR(02) ,
    LAST_UPLOAD_STATUS         CHAR(02) ,
    LAST_UPLOAD_DATE           CHAR(08) ,
    LAST_DOWNLOAD_STATUS       CHAR(02) ,
    LAST_DOWNLOAD_DATE         CHAR(08) ,
    SPECIAL_RUN_INDICATOR      CHAR(01) ,
    OVER_VOLUME_INDICATOR      CHAR(01) ,
    POLLING_INDICATOR          CHAR(01) ,
    POLLING_PRIORITY           CHAR(03) ,
    POLLING_SCHEDULE           CHAR(01) ,
    POLLING_STATUS_MAINT_DATE  CHAR(08) ,
    NEXT_DOWNLOAD_BLOCK_COUNT  CHAR(09) ,
    END_MARKER_X               CHAR(01) ,
    CARR_RETURN                CHAR(01)
) 
) 

LOCATION ( CCN_LOAD_FILES: 'COSTCTR_DATA5070.TXT' )
  )
  REJECT LIMIT 0