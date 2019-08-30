/*---------------------------------------------------------------------------------------
Below script will drop MICR column in SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS and 
SD_CHECK_NBR_PRNT_EXTRCT_DTLS  tables and rename PART_NUMBER to JOB_TICKET_TEMPLATE for 
Store drafts tracking/printing services tables

Created  : 08/21/2019 akj899 ASP-1193 CCNSD-8 CCN project Team....
-------------------------------------------------------------------------------------------*/
   ALTER TABLE SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS
        DROP COLUMN MICR;

   ALTER TABLE SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS
        RENAME COLUMN PART_NUMBER TO JOB_TICKET_TEMPLATE;

   ALTER TABLE SD_CHECK_NBR_PRNT_EXTRCT_DTLS
        DROP COLUMN MICR;

   ALTER TABLE SD_CHECK_NBR_PRNT_EXTRCT_DTLS
        RENAME COLUMN PART_NUMBER TO JOB_TICKET_TEMPLATE;


