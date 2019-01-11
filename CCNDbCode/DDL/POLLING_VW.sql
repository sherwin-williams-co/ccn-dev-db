CREATE OR REPLACE VIEW POLLING_VW
AS
  SELECT
/*******************************************************************************
This View contains all the records from POLLING table

Created  : 10/17/2018 sxg151 CCN Project....
         : 01/11/2019 pxa852 CCN Project Team...
           Changed the EFFECTIVE_DATE to POLLING_EFFECTIVE_DATE
           EXPIRATION_DATE to POLLING_EXPIRATION_DATE
*******************************************************************************/
       COST_CENTER_CODE,
       POLLING_STATUS_CODE,
       MULTICAST_IND,
       TIME_ZONE,
       POLLING_IND,
       NEXT_DOWNLOAD_BLOCK_COUNT,
       CURRENT_FLAG,
       POLLING_EFFECTIVE_DATE,
       POLLING_EXPIRATION_DATE,
       POLLING_START_DATE,
       POLLING_STOP_DATE
  FROM POLLING;