CREATE OR REPLACE VIEW MISCTRAN_PRIMESUB
AS
SELECT 
/*******************************************************************************
  This view gives details about the misc transaction file along with prime sub and JV/IDE details

Created : 10/10/2016 jxc517 CCN Project Team....
Changed : 01/20/2017 vxv336
                     Added BOOKING_COST_CENTER and modified PRIME_SUB field
*******************************************************************************/
        BANK_ACCOUNT_NBR
       ,COST_CENTER_CODE
       ,AMOUNT
       ,TRANSACTION_DATE
       ,TCODE
       ,TCODE_DESCRIPTION
       ,TRAN_SEQNUM
       ,DB_CR_CODE
       ,SNZ_SAM_CODE
       ,LOAD_DATE
       ,SUBSTR(PRIME_SUB,1,7) AS PRIME_SUB
       ,JV_BOOK_KEEPER_REF
       ,JV_BANK_SHORT_NAME
       ,IDI_BOOKKEEPER_REF
       ,IDI_BANK_SHORT_NAME
       ,(SELECT COST_CENTER_CODE FROM COSTCNTR.COST_CENTER WHERE SUBSTR(COST_CENTER_CODE,-4) = SUBSTR(PRIME_SUB,-4)) AS BOOKING_COST_CENTER
  FROM MISCTRAN_DETAILS
 ORDER BY COST_CENTER_CODE, LOAD_DATE, DB_CR_CODE;
