create or replace TYPE SD_FILTER_OBJECT_TYPE AS OBJECT(
/*******************************************************************************
	This object is used to load recursive data from ref cursor and
	finally pass it back to UI as ref cursor

Created : 03/03/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
COST_CENTER_CODE        VARCHAR2(6),
CHECK_SERIAL_NUMBER     VARCHAR2(10),
TRANSACTION_DATE        DATE,
TERMINAL_NUMBER         VARCHAR2(5),
TRANSACTION_NUMBER      VARCHAR2(5),
CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9),
CUSTOMER_JOB_NUMBER     VARCHAR2(2),
POS_TRANSACTION_CODE    VARCHAR2(2),
POS_TRANSACTION_TIME    VARCHAR2(4),
BANK_NUMBER             VARCHAR2(3),
BANK_ACCOUNT_NUMBER     VARCHAR2(16),
BANK_REFERENCE          VARCHAR2(6),
PAYEE_NAME              VARCHAR2(30),
ADDRESS_LINE_1          VARCHAR2(30),
ADDRESS_LINE_2          VARCHAR2(30),
CITY                    VARCHAR2(15),
STATE_CODE              VARCHAR2(2),
ZIP_CODE_PREFIX         VARCHAR2(6),
ZIP_CODE_SUFFIX         VARCHAR2(4),
PHONE_AREA_CODE         VARCHAR2(3), 
PHONE_NUMBER            VARCHAR2(7),
EMPLOYEE_NUMBER         VARCHAR2(2),
ISSUE_DATE              DATE,
PAID_DATE               DATE,
STOP_PAY_DATE           DATE,
STOP_PAY_REMOVE_DATE    DATE,
VOID_DATE               DATE,
AMOUNT_CHANGE_DATE      DATE,
GROSS_AMOUNT            NUMBER(9,2),
RETAIN_AMOUNT           NUMBER(9,2),
NET_AMOUNT              NUMBER(9,2),
ORIGINAL_NET_AMOUNT     NUMBER(9,2),
BANK_PAID_AMOUNT        NUMBER(9,2),
TRANSACTION_SOURCE      VARCHAR2(1),
CHANGE_DATE             DATE, 
CHANGE_SOURCE           VARCHAR2(8),
SLS_BOOK_DATE           VARCHAR2(4),
CYCLE_RUN_NUMBER        VARCHAR2(2),
BOOK_DATE_SEQUENCE      VARCHAR2(5),
REASON_CODE             VARCHAR2(2),
DRAFT_NUMBER            VARCHAR2(4),
VOID_INDICATOR          VARCHAR2(1),
PAY_INDICATOR           VARCHAR2(1),
STOP_INDICATOR          VARCHAR2(1),
OPEN_INDICATOR          VARCHAR2(1),
LOAD_DATE               DATE,
GL_ACCOUNT_NUMBER       VARCHAR2(100)
)
/

create or replace TYPE SD_FILTER_TABLE_TYPE IS
/*******************************************************************************
	This object is used to load recursive data from ref cursor and
	finally pass it back to UI as ref cursor

Created : 03/03/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
TABLE OF SD_FILTER_OBJECT_TYPE
/

/*******************************************************************************
	We no longer need dual filters at the enquiry window level, so dropping the types

Created : 04/16/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
DROP TYPE SD_FILTER_TABLE_TYPE;
DROP TYPE SD_FILTER_OBJECT_TYPE;
