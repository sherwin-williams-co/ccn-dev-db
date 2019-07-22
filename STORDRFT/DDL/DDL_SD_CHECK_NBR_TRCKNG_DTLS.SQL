/*---------------------------------------------------------------------------
Below script will create drop and create tabel SD_CHECK_NBR_TRCKNG_DTLS for 
Store drafts tracking/printing services tables


Created: 01/18/2019 akj899 ASP-1193 CCNSD-8 CCN project Team....
---------------------------------------------------------------------------*/
  DROP TABLE SD_CHECK_NBR_TRCKNG_DTLS;

  CREATE TABLE SD_CHECK_NBR_TRCKNG_DTLS 
   (COST_CENTER_CODE           VARCHAR2(6), 
    CHKS_ORDERED_DATE          DATE, 
    ORDERED_STRTNG_DRFT        NUMBER, 
    ORDERED_ENDNG_DRFT         NUMBER, 
     CONSTRAINT SD_CHECK_NBR_TRCKNG_DTLS_PK PRIMARY KEY (COST_CENTER_CODE, CHKS_ORDERED_DATE));

