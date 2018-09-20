/**********************************************************
Script Name- ALTER_CCN_ACCOUNTING_TBL_ASP_1130
Description- This SQL Script adds new columns ADDRESS_LINE_1,ADDRESS_LINE_2,
             ADDRESS_LINE_3,CITY abd ZIP_CODE in CCN_ACCOUNTING_TBL table
Created    - kxm302 09/20/2018
**********************************************************/

ALTER TABLE CCN_ACCOUNTING_TBL 
  ADD (ADDRESS_LINE_1  VARCHAR2(100),
       ADDRESS_LINE_2  VARCHAR2(100),
       ADDRESS_LINE_3  VARCHAR2(100),
       CITY            VARCHAR2(100),
       ZIP_CODE        VARCHAR2(100));