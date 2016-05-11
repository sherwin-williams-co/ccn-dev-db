CREATE OR REPLACE VIEW STORE_DRAFTS_VW
AS
SELECT
/*******************************************************************************
This view is used to get all the draft details for a store draft

Created  : 04/26/2016 jxc517 CCN Project Team....
Modified : 
*******************************************************************************/
       COST_CENTER_CODE,
       CHECK_SERIAL_NUMBER,
       TRANSACTION_DATE,
       TERMINAL_NUMBER,
       TRANSACTION_NUMBER,
       CUSTOMER_ACCOUNT_NUMBER,
       CUSTOMER_JOB_NUMBER,
       POS_TRANSACTION_CODE,
       POS_TRANSACTION_TIME,
       BANK_NUMBER,
       BANK_ACCOUNT_NUMBER,
       BANK_REFERENCE,
       PAYEE_NAME,
       ADDRESS_LINE_1,
       ADDRESS_LINE_2,
       CITY,
       STATE_CODE,
       ZIP_CODE_PREFIX,
       ZIP_CODE_SUFFIX,
       PHONE_AREA_CODE,
       PHONE_NUMBER,
       EMPLOYEE_NUMBER,
       ISSUE_DATE,
       PAID_DATE,
       STOP_PAY_DATE,
       STOP_PAY_REMOVE_DATE,
       VOID_DATE,
       AMOUNT_CHANGE_DATE,
       GROSS_AMOUNT,
       RETAIN_AMOUNT,
       NET_AMOUNT,
       ORIGINAL_NET_AMOUNT,
       BANK_PAID_AMOUNT,
       TRANSACTION_SOURCE,
       CHANGE_DATE,
       CHANGE_SOURCE,
       SLS_BOOK_DATE,
       CYCLE_RUN_NUMBER,
       BOOK_DATE_SEQUENCE,
       REASON_CODE,
       DRAFT_NUMBER
  FROM STORE_DRAFTS;