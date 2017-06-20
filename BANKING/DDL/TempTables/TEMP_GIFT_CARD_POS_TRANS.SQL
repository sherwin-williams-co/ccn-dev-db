/***************************************************************************************************
Description : This file has commands to create table UAR_GIFT_CARD_POS_TRANS
Created  : 05/10/2017 gxg192 CCN Project Team.....
Modified :
****************************************************************************************************/

CREATE TABLE TEMP_GIFT_CARD_POS_TRANS
   (
      TRANSACTION_TYPE   VARCHAR2(2),
      UAR_TRAN_CODE      VARCHAR2(6),
      GIFT_CARD_NBR      VARCHAR2(20),
      DIVISION_NBR       VARCHAR2(2),
      DISTRICT_NBR       VARCHAR2(2),
      AREA_NBR           VARCHAR2(2),
      STORE_NBR          VARCHAR2(6),
      STORE_STATE_CD     VARCHAR2(2),
      TRANS_AMOUNT       VARCHAR2(14),
      TRANS_DATE         VARCHAR2(8),
      TRANS_TIME         VARCHAR2(8),
      TERM_NBR           VARCHAR2(5),
      TRANS_NBR          VARCHAR2(5),
      EMPLOYEE_NBR       VARCHAR2(2)
   )
   ORGANIZATION EXTERNAL
   (
      TYPE ORACLE_LOADER DEFAULT DIRECTORY BANKING_LOAD_FILES ACCESS
      PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
      badfile BANKING_LOAD_FILES:'GIFT_CARD_POS_TRANS.bad'
      logfile BANKING_LOAD_FILES:'GIFT_CARD_POS_TRANS.log'
      discardfile BANKING_LOAD_FILES:'GIFT_CARD_POS_TRANS.dsc'
      LOAD WHEN
      (
         (
            2:3
         )
         = '10'
      OR
         (
            2:3
         )
         = '11'
      OR
         (
            2:3
         )
         = '12'
      OR
         (
            2:3
         )
         = '19'
      OR
         (
            2:3
         )
         = '22'
      OR
         (
            2:3
         )
         = '31'
      OR
         (
            2:3
         )
         = '41'
      OR
         (
            2:3
         )
         = '81'
      OR
         (
            2:3
         )
         = '82'
      OR
         (
            2:3
         )
         = '91'
      )
      FIELDS
      (
      TRANSACTION_TYPE POSITION(2:3) CHAR(2),
      UAR_TRAN_CODE POSITION(4:9)    CHAR(6),
      GIFT_CARD_NBR POSITION(10:29)  CHAR(20),
      DIVISION_NBR POSITION(30:31)   CHAR(2),
      DISTRICT_NBR POSITION(32:33)   CHAR(2),
      AREA_NBR POSITION(34:35)       CHAR(2),
      STORE_NBR POSITION(36:41)      CHAR(6),
      STORE_STATE_CD POSITION(42:43) CHAR(2),
      TRANS_AMOUNT POSITION(44:57)   CHAR(14),
      TRANS_DATE POSITION(58:65)     CHAR(8),
      TRANS_TIME POSITION(66:73)     CHAR(8),
      TERM_NBR POSITION(74:78)       CHAR(5),
      TRANS_NBR POSITION(79:83)      CHAR(5),
      EMPLOYEE_NBR POSITION(84:85)   CHAR(2)
      ) ) LOCATION ( 'GIFT_CARD_POS_TRANS_file.TXT' )
   );