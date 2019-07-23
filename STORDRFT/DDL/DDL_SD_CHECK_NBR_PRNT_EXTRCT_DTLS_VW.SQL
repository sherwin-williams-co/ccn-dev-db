CREATE OR REPLACE VIEW SD_CHECK_NBR_PRNT_EXTRCT_DTLS_VW AS
SELECT 
/*---------------------------------------------------------------------------
Below script will create or replace view SD_CHECK_NBR_PRNT_EXTRCT_DTLS_VW

Created : 07/23/2022 akj899 ASP-1193 CCNSD-8 CCN project Team....
Changed :
---------------------------------------------------------------------------*/
* FROM SD_CHECK_NBR_PRNT_EXTRCT_DTLS 
 WHERE USED_IN_POS_ON_DATE IS NULL;
