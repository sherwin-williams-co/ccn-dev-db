/*
**************************************************************************** 
This script is created to Add new column on STOREDRFT_PARAM table
created : 12/01/2016 gxg192 CCN Project.... 
changed : 
****************************************************************************
*/

/*STOREDRFT_PARAM*/
ALTER TABLE STOREDRFT_PARAM
ADD ROYAL_BANK_RPT_RUNDATE DATE;

/*COMMENT ON ROYAL_BANK_RPT_RUNDATE*/
COMMENT ON COLUMN STOREDRFT_PARAM.ROYAL_BANK_RPT_RUNDATE
IS
   'it holds date for Royal Bank report run';