/*
Script Name: ADD_BANK_MICR_UNIQUE_CONSTRAINTS.sql
Purpose    : To avoid duplicate format_names being saved into bank Micr when user hits multiple saves without 
              refreshing the UI screen, especially for virtual Futures when business rules donot execute

Created    : 08/15/2017 rxa457 CCN Project....
*/

ALTER TABLE BANK_MICR_FORMAT ADD CONSTRAINT BANK_MICR_FORMAT_UK UNIQUE(BANK_ACCOUNT_NBR, FORMAT_NAME);

ALTER TABLE BANK_MICR_FORMAT_FUTURE ADD CONSTRAINT BANK_MICR_FORMAT_FUTURE_UK UNIQUE(BANK_ACCOUNT_NBR, FORMAT_NAME, FUTURE_ID);
