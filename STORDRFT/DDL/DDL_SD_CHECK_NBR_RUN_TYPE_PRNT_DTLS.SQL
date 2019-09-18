/*---------------------------------------------------------------------------
Below script will create drop and create tabel SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS for 
Store drafts tracking/printing services tables


Created  : 01/18/2019 akj899 ASP-1193 CCNSD-8 CCN project Team....
Modified : 08/14/2019 akj899 ASP-1193 CCNSD-8 CCN project Team....
           Added two new columns MICR and PART_NUMBER
           08/21/2019 Dropped MICR and renamed PART_NUMBER to
                      JOB_TICKET_TEMPLATE
           09/18/2019 Dropped JOB_TICKET_TEMPLATE
---------------------------------------------------------------------------*/

  DROP TABLE SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS;
  
  CREATE TABLE SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS 
   (STORE_DRAFT_CHECK_RUN_TYPE   VARCHAR2(1), 
    NO_OF_BOOKS                  NUMBER, 
    CHECKS_PER_BOOK              NUMBER, 
    STORE_DRFT_THRESHOLD         NUMBER, 
    BANK_ACCOUNT_NBR             VARCHAR2(100), 
    BANK_ROUTING_NBR             VARCHAR2(100),
    JOB_TICKET_TEMPLATE          VARCHAR2(100),
    EFFECTIVE_DATE               DATE, 
    EXPIRATION_DATE              DATE, 
    CREATED_BY_USER_ID           VARCHAR2(100), 
    CREATED_ON_DATE              DATE, 
     CONSTRAINT SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS_PK PRIMARY KEY (STORE_DRAFT_CHECK_RUN_TYPE, EFFECTIVE_DATE));

