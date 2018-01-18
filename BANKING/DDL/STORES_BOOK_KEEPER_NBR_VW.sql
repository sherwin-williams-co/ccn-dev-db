CREATE OR REPLACE VIEW STORES_BOOK_KEEPER_NBR_VW AS
   SELECT
/*******************************************************************************
This view will provide the COST CENTER and BANK KEEPER NUMBER information.

Created  : 01/16/2018 sxg151 CCN Project
Modified :
*******************************************************************************/
    LEAD_STORE_NBR,
        (SELECT BOOK_KEEPER_NBR
           FROM BANK_ACCOUNT
          WHERE BANK_ACCOUNT_NBR = LEAD_BANK_ACCOUNT_NBR) as BOOK_KEEPER_NBR
    FROM LEAD_BANK_CC
UNION ALL
   SELECT MEMBER_STORE_NBR,
      (SELECT BOOK_KEEPER_NBR
         FROM BANK_ACCOUNT
       WHERE BANK_ACCOUNT_NBR = LEAD_BANK_ACCOUNT_NBR) as BOOK_KEEPER_NBR
    FROM MEMBER_BANK_CC;