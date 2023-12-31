/*
Script Name: EXPIRE_ADDRESS_OOCL01.sql
Purpose    : This script expires current billing address for OOCL01
             

Created : 02/20/2018 axt754 CCN Project....
Changed :
*/
SELECT * 
  FROM ADDRESS_USA
 WHERE UPPER(COST_CENTER_CODE) = 'OOCL01'
   AND ADDRESS_TYPE = 'B'
   AND EXPIRATION_DATE IS NULL;
--1 Row(s) Selected

UPDATE ADDRESS_USA
   SET EXPIRATION_DATE = TRUNC(SYSDATE)
 WHERE UPPER(COST_CENTER_CODE) = 'OOCL01'
   AND ADDRESS_TYPE = 'B'
   AND EXPIRATION_DATE IS NULL;
--1 row updated.

SELECT * 
  FROM ADDRESS_USA
 WHERE UPPER(COST_CENTER_CODE) = 'OOCL01'
   AND ADDRESS_TYPE = 'B'
   AND EXPIRATION_DATE IS NULL;
--no rows selected

--Check address_vw
SELECT * 
  FROM ADDRESS_VW
 WHERE UPPER(COST_CENTER_CODE) = 'OOCL01'
   AND ADDRESS_TYPE = 'B';
--1 Row(s) Selected


-- COMMIT the trsnasction
COMMIT;