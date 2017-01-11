create or replace PACKAGE SD_AUDITFILES_PKG
/*******************************************************************************************
THIS PACKAGE BODY WILL HOLD ALL PL/SQL OBJECTS THAT ARE NEEDED TO
CREATE AND BUILD THE DAILY STORE DRAFT AUDITS, ISSUES, VOIDS, STOP PAYS,
AND REMOVE STOP PAYS FOR U.S.,CAN, AUTOMOTIVE CAN AND AUTOMOTIVE U.S. STORES.

CREATED : 08/12/2014 AXK326

REVISIONS: 11/13/2014 AXK326
           Made changes to cursor and also procedures name for automotive and non automotive
REVISIONS: 05/20/2015 NXK927
           added condition to take the records for transaction type 15 if only there is change in the amount for that date.
         : 01/11/2017 AXK326
           Removed PROCEDURE that builds US AUDIT RECORDS DAILY STORE DRAFT ISSUES, VOIDS, STOP PAYS AND REMOVE STOP PAYS
           for SUNTRUST as it will be maintained online.
********************************************************************************************/
AS

TYPE SD_CURSOR_AU_NAU_REC_TYPE IS RECORD(
    COST_CENTER_CODE     STORE_DRAFTS.COST_CENTER_CODE%TYPE,
    BANK_ACCOUNT_NUMBER  STORE_DRAFTS.BANK_ACCOUNT_NUMBER%TYPE,
    CHECK_SERIAL_NUMBER  STORE_DRAFTS.CHECK_SERIAL_NUMBER%TYPE,
    BANK_NUMBER          STORE_DRAFTS.BANK_NUMBER%TYPE,
    ISSUE_DATE           STORE_DRAFTS.ISSUE_DATE%TYPE,
    check_date           varchar2(6),
    amount_change_date STORE_DRAFTS.amount_change_date%TYPE,
    BANK_PAID_AMOUNT     NUMBER,
    NET_AMOUNT           NUMBER,
    ITEM_EXT_AMOUNT      NUMBER,
    ITEM_QUANTITY        NUMBER,
    TRANSACTION_SOURCE   STORE_DRAFTS.TRANSACTION_SOURCE%TYPE,
    TRANSACTION_DATE     VARCHAR2(8),
    PAYEE_NAME           STORE_DRAFTS.PAYEE_NAME%TYPE,
    PAID_DATE            VARCHAR2(8),
    CHANGE_SOURCE        STORE_DRAFTS.CHANGE_SOURCE%TYPE,
    VOID_INDICATOR       STORE_DRAFTS.VOID_INDICATOR%TYPE,
    PAY_INDICATOR        STORE_DRAFTS.PAY_INDICATOR%TYPE,
    STOP_INDICATOR       STORE_DRAFTS.STOP_INDICATOR%TYPE,
    STATEMENT_TYPE       CCN_HIERARCHY_INFO.STATEMENT_TYPE%TYPE);

PROCEDURE CREATE_US_AUDITRECORDS_FILE
/*****************************************************************************
    CREATE AUDITRECORDS_FILE  FILE

THIS PROCEDURE WILL BUILD THE US  AUTOMOTIVE DAILY STORE DRAFT AUDITS, ISSUES,
VOIDS, STOP PAYS AND REMOVE STOP PAYS

CREATED : 08/12/2014 AXK326
REVISION:

*****************************************************************************/
(IN_DATE IN DATE)
;

PROCEDURE CREATE_US_AUTO_BANK_FILE
/*****************************************************************************
    CREATE_US_AUTO_BANK_FILE  FILE

THIS PROCEDURE WILL BUILD THE US AUDIT DAILY STORE DRAFT AUDITS, ISSUES,
VOIDS, STOP PAYS AND REMOVE STOP PAYS

CREATED  : 08/12/2014 AXK326
REVISIONS: 11/13/2014 AXK326
           Made changes to cursor and also procedures name for automotive and non automotive
REVISIONS: 05/20/2015 NXK927
           added condition to take the records for transaction type 15 if only there is change in the amount for that date.

*****************************************************************************/
(IN_DATE IN DATE)
;

PROCEDURE CREATE_US_NONAUTO_BANK_FILE
/*****************************************************************************
    CREATE_US_NONAUTO_BANK_FILE  FILE

THIS PROCEDURE WILL BUILD THE NAS AUDIT DAILY STORE DRAFT AUDITS, ISSUES,
VOIDS, STOP PAYS AND REMOVE STOP PAYS

CREATED  : 08/12/2014 AXK326
REVISIONS: 11/13/2014 AXK326
           Made changes to cursor and also procedures name for automotive and non automotive
REVISIONS: 05/20/2015 NXK927
           added condition to take the records for transaction type 15 if only there is change in the amount for that date.

*****************************************************************************/
(IN_DATE IN DATE)
;

END SD_AUDITFILES_PKG;