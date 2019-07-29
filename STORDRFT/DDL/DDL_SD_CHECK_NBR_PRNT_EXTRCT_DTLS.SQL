/*---------------------------------------------------------------------------
Below script will create drop and create tabel SD_CHECK_NBR_PRNT_EXTRCT_DTLS for 
Store drafts tracking/printing services tables


Created  : 01/18/2019 akj899 ASP-1193 CCNSD-8 CCN project Team....
Modified : 07/25/2019 Added CCN_CHECK_SERIAL_NUMBER column
---------------------------------------------------------------------------*/
  DROP TABLE SD_CHECK_NBR_PRNT_EXTRCT_DTLS

  CREATE TABLE SD_CHECK_NBR_PRNT_EXTRCT_DTLS 
   (CHKS_ORDERED_DATE     DATE, 
    SRT_CHKDLY_SEQ_NBR    NUMBER, 
    COST_CENTER_CODE      VARCHAR2(6), 
    TERMINAL_NUMBER       VARCHAR2(5), 
    ORDERED_DRFT_NUMBER   NUMBER, 
    CHECK_DIGIT           NUMBER, 
    ROUTING_NBR           VARCHAR2(100), 
    ACCOUNT_NUMBER        VARCHAR2(100), 
    LETTER                VARCHAR2(1), 
    RUN_TYPE              VARCHAR2(1 ), 
    RUNTYPE_DESCRIPTION   VARCHAR2(1000), 
    USED_IN_POS_ON_DATE   DATE, 
    CCN_CHECK_SERIAL_NUMBER VARCHAR2(10),
     CONSTRAINT SD_CHECK_NBR_PRNT_EXTRCT_DTLS PRIMARY KEY (CHKS_ORDERED_DATE, COST_CENTER_CODE, ORDERED_DRFT_NUMBER));
