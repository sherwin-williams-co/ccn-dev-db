CREATE OR REPLACE VIEW POLLING_VW AS
SELECT 
/*******************************************************************************
This View contains all the records from POLLING table

Created  : 10/17/2018 sxg151 CCN Project....
Modified : 01/11/2019 pxa852 CCN Project Team...CCNCC-37
           Changed the EFFECTIVE_DATE to POLL_STATUS_EFF_DT
           EXPIRATION_DATE to POLL_STATUS_EXP_DT
*******************************************************************************/
       *
  FROM POLLING;