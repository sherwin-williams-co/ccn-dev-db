/*---------------------------------------------------------------------------
Below script will create drop and create tabel SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS for 
Store drafts tracking/printing services tables


Created: 01/18/2019 akj899 ASP-1193 CCNSD-8 CCN project Team....
---------------------------------------------------------------------------*/

  DROP TABLE SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS;
  
  CREATE TABLE SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS 
   (STORE_DRAFT_CHECK_RUN_TYPE   VARCHAR2(1), 
    NO_OF_BOOKS                  NUMBER, 
    CHECKS_PER_BOOK              NUMBER, 
    STORE_DRFT_THRESHOLD         NUMBER, 
    BANK_ACCOUNT_NBR             VARCHAR2(100), 
    BANK_ROUTING_NBR             VARCHAR2(100), 
    EFFECTIVE_DATE               DATE, 
    EXPIRATION_DATE              DATE, 
    CREATED_BY_USER_ID           VARCHAR2(100), 
    CREATED_ON_DATE              DATE, 
     CONSTRAINT SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS_PK PRIMARY KEY (STORE_DRAFT_CHECK_RUN_TYPE, EFFECTIVE_DATE));

