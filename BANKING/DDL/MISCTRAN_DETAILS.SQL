  CREATE TABLE MISCTRAN_DETAILS
/*******************************************************************************   
This table holds the details about the misc transaction file along with prime sub and JV/IDE details 
Created : 01/23/2017 vxv336 CCN Project Team.... 
Changed : 
*******************************************************************************/

   (BANK_ACCOUNT_NBR VARCHAR2(20), 
    COST_CENTER_CODE VARCHAR2(6), 
    AMOUNT VARCHAR2(12), 
    TRANSACTION_DATE DATE, 
    TCODE VARCHAR2(4), 
    TCODE_DESCRIPTION VARCHAR2(100), 
    TRAN_SEQNUM VARCHAR2(9), 
    DB_CR_CODE VARCHAR2(2), 
    SNZ_SAM_CODE VARCHAR2(6), 
    LOAD_DATE DATE, 
    PRIME_SUB VARCHAR2(15), 
    JV_BOOK_KEEPER_REF VARCHAR2(6), 
    JV_BANK_SHORT_NAME VARCHAR2(6), 
    IDI_BOOKKEEPER_REF VARCHAR2(6), 
    IDI_BANK_SHORT_NAME VARCHAR2(6),
    BOOKING_COST_CENTER VARCHAR2(6)
   );

ALTER TABLE MISCTRAN_DETAILS
ADD BOOKING_COST_CENTER VARCHAR2(6);

ALTER TABLE MISCTRAN_DETAILS
MODIFY PRIME_SUB VARCHAR2(7);
