/*
Script Name: DELETE_DUPLICATE_BANK_MICRS.sql
Purpose    : To delete duplicate Bank Micrs in TEST env before 
             executing "ADD_BANK_MICR_UNIQUE_CONSTRAINTS.sql" which would add the unique constraint 
              on Bankl MICR table to avoid duplicates
              This script will not progress beyond TEST because duplicate Data is not available in QA or PROD

Created    : 08/18/2017 rxa457 CCN Project....
*/
DELETE FROM BANK_MICR_FORMAT WHERE  BANK_ACCOUNT_NBR = '3751905817' AND MICR_FORMAT_ID IN (7,8);

DELETE FROM BANK_MICR_FORMAT WHERE  BANK_ACCOUNT_NBR = '12111180' AND MICR_FORMAT_ID IN (2,3);

DELETE FROM BANK_MICR_FORMAT WHERE  BANK_ACCOUNT_NBR = '3750003778' AND MICR_FORMAT_ID IN (3);

COMMIT;
