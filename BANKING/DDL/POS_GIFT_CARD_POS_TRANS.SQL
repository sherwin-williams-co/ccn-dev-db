/***************************************************************************************************
Description : This file has commands to create table POS_GIFT_CARD_POS_TRANS
Created  : 06/23/2017 gxg192 CCN Project Team.....
Modified :
****************************************************************************************************/

CREATE TABLE POS_GIFT_CARD_POS_TRANS
   (
      TRANSACTION_TYPE VARCHAR2(2),
      UAR_TRAN_CODE    VARCHAR2(6),
      GIFT_CARD_NBR    VARCHAR2(20),
      DIVISION_NBR     VARCHAR2(2),
      DISTRICT_NBR     VARCHAR2(2),
      AREA_NBR         VARCHAR2(2),
      STORE_NBR        VARCHAR2(6),
      STORE_STATE_CD   VARCHAR2(2),
      TRANS_AMOUNT     VARCHAR2(14),
      TRANS_DATE       VARCHAR2(8),
      TRANS_TIME       VARCHAR2(8),
      TERM_NBR         VARCHAR2(5),
      TRANS_NBR        VARCHAR2(5),
      EMPLOYEE_NBR     VARCHAR2(2),
      TRAN_GUID        RAW(16),
      LOAD_DATE        DATE,
      CONSTRAINT POS_GIFT_CARD_POS_TRANS_PK_ID PRIMARY KEY (STORE_NBR, GIFT_CARD_NBR,
      TERM_NBR, TRANS_NBR)
   );

CREATE INDEX POS_GC_POS_TRANS_INDX_LD ON POS_GIFT_CARD_POS_TRANS (LOAD_DATE);