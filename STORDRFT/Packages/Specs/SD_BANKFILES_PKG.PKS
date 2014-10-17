create or replace 
PACKAGE SD_BANKFILES_PKG
/****************************************************************************** 
THIS PACKAGE WILL HOLD ALL PL/SQL OBJECTS THAT ARE NEEDED TO 
CREATE AND BUILD THE DAILY STORE DRAFT ISSUES, VOIDS, STOP PAYS, 
AND REMOVE STOP PAYS FOR U.S.,CAN, AUTOMOTIVE CAN AND AUTOMOTIVE U.S. STORES.

CREATED : 07/23/2014 NXK 

REVISIONS: 
******************************************************************************/
AS
TYPE SD_CUR_REC_TYPE IS RECORD(
    COST_CENTER_CODE     STORE_DRAFTS.COST_CENTER_CODE%TYPE,
    BANK_ACCOUNT_NUMBER  STORE_DRAFTS.BANK_ACCOUNT_NUMBER%TYPE,
    CHECK_SERIAL_NUMBER  STORE_DRAFTS.CHECK_SERIAL_NUMBER%TYPE,
    BANK_NUMBER          STORE_DRAFTS.BANK_NUMBER%TYPE,
    ISSUE_DATE           VARCHAR2(8),
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

PROCEDURE CREATE_US_AUTO_BANK_FILE
/*****************************************************************************
	CREATE US_AUTO FILE  FILE

THIS PROCEDURE WILL BUILD THE US  AUTOMOTIVE DAILY STORE DRAFT ISSUES, VOIDS, STOP PAYS, 
AND REMOVE STOP PAYS 

CREATED : 07/23/2014 NXK 
REVISION: 

*****************************************************************************/
(IN_DATE IN DATE)
;

PROCEDURE CREATE_US_NONAUTO_FILE
/*****************************************************************************
	CREATE US_STORE FILE  

THIS PROCEDURE WILL BUILD THE US  STORE  DAILY STORE DRAFT ISSUES, VOIDS, STOP PAYS, 
AND REMOVE STOP PAYS 

CREATED : 07/23/2014 NXK 
REVISION: 

*****************************************************************************/
(IN_DATE IN DATE)
;

PROCEDURE CREATE_US_AUTO_PAID_FILE
/*****************************************************************************
	CREATE US_AUTO_PAID FILE  FILE

THIS PROCEDURE WILL BUILD THE US  AUTOMOTIVE DAILY STORE DRAFT ISSUES, VOIDS, STOP PAYS, 
AND REMOVE STOP PAYS 

CREATED : 07/23/2014 NXK 
REVISION: 

*****************************************************************************/
(IN_DATE IN DATE)
;

PROCEDURE CREATE_US_NONAUTO_PAID_FILE
/*****************************************************************************
	CREATE US_AUTO FILE 

THIS PROCEDURE WILL BUILD THE US  STORE DAILY STORE DRAFT ISSUES, VOIDS, STOP PAYS, 
AND REMOVE STOP PAYS 

CREATED : 07/23/2014 NXK 
REVISION: 

*****************************************************************************/
(IN_DATE IN DATE)
;

PROCEDURE CREATE_CAN_NONAUTO_FILE
/*****************************************************************************
	CREATE_CAN_NONAUTO_FILE

THIS PROCEDURE WILL BUILD THE CAN STORE NON AUTO FILE

CREATED : 08/07/2014 NXK 
REVISION: 

*****************************************************************************/
(IN_DATE IN DATE)
;

PROCEDURE CREATE_CAN_AUTO_FILE
/*****************************************************************************
	CREATE_CAN_NONAUTO_FILE

THIS PROCEDURE WILL BUILD THE CAN STORE NON AUTO FILE

CREATED : 08/07/2014 NXK 
REVISION: 

*****************************************************************************/
(IN_DATE IN DATE)
;



END SD_BANKFILES_PKG;