/***************************************************************************************************
Description : This file has commands to create table as FF_GIFT_CARD_POS_TRANS for 
              storing gift card related POS transaction records on Banking schema
Created  : 05/10/2017 gxg192 CCN Project Team.....
Modified : 06/23/2017 gxg192 Added index on load_date field.
****************************************************************************************************/

CREATE TABLE FF_GIFT_CARD_POS_TRANS
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
      LOAD_DATE        DATE,
      COMMENTS         VARCHAR2(4000),
      CONSTRAINT FF_GIFT_CARD_POS_TRANS_PK PRIMARY KEY (GIFT_CARD_NBR,
      STORE_NBR, TRANS_NBR, LOAD_DATE) 
   );

CREATE INDEX FF_GIFT_CARD_POS_TRANS_INDX_LD ON FF_GIFT_CARD_POS_TRANS (LOAD_DATE);