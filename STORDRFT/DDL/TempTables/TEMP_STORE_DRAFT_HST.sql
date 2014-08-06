BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE TEMP_STORE_DRAFT_HST';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

  CREATE TABLE TEMP_STORE_DRAFT_HST 
   (	COST_CENTER_CODE VARCHAR2(6 BYTE), 
	CHECK_SERIAL_NUMBER VARCHAR2(10 BYTE), 
	DRAFT_NUMBER VARCHAR2(4 BYTE), 
	TRANSACTION_DATE VARCHAR2(8 BYTE), 
	TERM_NUMBER VARCHAR2(5 BYTE), 
	TRANSACTION_NUMBER VARCHAR2(5 BYTE), 
	CUSTOMER_ACCOUNT_NUMBER VARCHAR2(9 BYTE), 
	CUSTOMER_JOB_NUMBER VARCHAR2(2 BYTE), 
	POS_TRANSACTION_CODE VARCHAR2(2 BYTE), 
	POS_TRANSACTION_TIME VARCHAR2(4 BYTE), 
	BANK_NUMBER VARCHAR2(3 BYTE), 
	BANK_ACCOUNT_NUMBER VARCHAR2(16 BYTE), 
	BANK_REFERENCE VARCHAR2(6 BYTE), 
	PAYEE_NAME VARCHAR2(30 BYTE), 
	ADDRESS_LINE_1 VARCHAR2(30 BYTE), 
	ADDRESS_LINE_2 VARCHAR2(30 BYTE), 
	CITY VARCHAR2(15 BYTE), 
	STATE_CODE VARCHAR2(2 BYTE), 
	ZIP_CODE_PREFIX VARCHAR2(6 BYTE), 
	ZIP_CODE_SUFFIX VARCHAR2(4 BYTE), 
	PHONE_AREA_CODE VARCHAR2(3 BYTE), 
	PHONE_NUMBER VARCHAR2(7 BYTE), 
	EMPLOYEE_NUMBER VARCHAR2(2 BYTE), 
	ISSUE_DATE VARCHAR2(8 BYTE), 
	PAID_DATE VARCHAR2(8 BYTE), 
	STOP_PAY_DATE VARCHAR2(8 BYTE), 
	STOP_PAY_REMOVE_DATE VARCHAR2(8 BYTE), 
	VOID_DATE VARCHAR2(8 BYTE), 
	AMOUNT_CHANGE_DATE VARCHAR2(8 BYTE), 
	GROSS_AMOUNT VARCHAR2(9 BYTE), 
	RETAIN_AMOUNT VARCHAR2(9 BYTE), 
	NET_AMOUNT VARCHAR2(9 BYTE), 
	ORIGINAL_NET_AMOUNT VARCHAR2(9 BYTE), 
	BANK_PAID_AMOUNT VARCHAR2(9 BYTE), 
	TRANSACTION_SOURCE VARCHAR2(1 BYTE), 
	CHANGE_DATE VARCHAR2(8 BYTE), 
	CHANGE_SOURCE VARCHAR2(8 BYTE), 
	SLS_BOOK_DATE VARCHAR2(4 BYTE), 
	CYCLE_RUN_NUMBER VARCHAR2(2 BYTE), 
	BOOK_DATE_SEQUENCE VARCHAR2(5 BYTE), 
	REASON_CODE VARCHAR2(2 BYTE)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY STORDRFT_LOAD_FILES
      ACCESS PARAMETERS
      ( RECORDS FIXED 334
        badfile STORDRFT_LOAD_FILES:'TEMP_STORE_DRAFT_HST.bad'
        logfile STORDRFT_LOAD_FILES:'TEMP_STORE_DRAFT_HST.log'
        discardfile STORDRFT_LOAD_FILES:'TEMP_STORE_DRAFT_HST.dsc'
        FIELDS missing field values are null
           ( COST_CENTER_CODE POSITION(1:6)             CHAR(6),
             CHECK_SERIAL_NUMBER POSITION(7:16)         CHAR(10),
             DRAFT_NUMBER  POSITION(12:15)              CHAR(4),
             TRANSACTION_DATE POSITION(17:24)           CHAR(8),
             TERM_NUMBER POSITION(25:29)                CHAR(5),
             TRANSACTION_NUMBER POSITION(30:34)         CHAR(5),
             CUSTOMER_ACCOUNT_NUMBER POSITION(35:43)    CHAR(9),
             CUSTOMER_JOB_NUMBER POSITION(44:45)        CHAR(2),
             POS_TRANSACTION_CODE POSITION(46:47)       CHAR(2),
             POS_TRANSACTION_TIME POSITION(48:51)       CHAR(4),
             BANK_NUMBER POSITION(52:54)                CHAR(3),
             BANK_ACCOUNT_NUMBER POSITION(55:70)        CHAR(16),
             BANK_REFERENCE POSITION(71:76)             CHAR(6),
             PAYEE_NAME POSITION(77:106)                CHAR(30),
             ADDRESS_LINE_1 POSITION(107:136)           CHAR(30),
             ADDRESS_LINE_2 POSITION(137:166)           CHAR(30),
             CITY POSITION(167:181)                     CHAR(15),
             STATE_CODE POSITION(182:183)               CHAR(2),
             ZIP_CODE_PREFIX POSITION(184:189)          CHAR(6),
             ZIP_CODE_SUFFIX POSITION(190:193)          CHAR(4),
             PHONE_AREA_CODE POSITION(194:196)          CHAR(3),
             PHONE_NUMBER POSITION(197:203)             CHAR(7),
             EMPLOYEE_NUMBER POSITION(204:205)          CHAR(2),
             ISSUE_DATE POSITION(206:213)               CHAR(8),
             PAID_DATE POSITION (214:221)               CHAR(8),
             STOP_PAY_DATE POSITION(222:229)            CHAR(8),
             STOP_PAY_REMOVE_DATE POSITION(230:237)     CHAR(8),
             VOID_DATE POSITION(238:245)                CHAR(8),
             AMOUNT_CHANGE_DATE POSITION(246:253)       CHAR(8), 
             GROSS_AMOUNT POSITION(254:262)             CHAR(9),
             RETAIN_AMOUNT POSITION(264:273)            CHAR(9),
             NET_AMOUNT POSITION(274: 282)              CHAR(9),
             ORIGINAL_NET_AMOUNT POSITION(284:292)      CHAR(9),
             BANK_PAID_AMOUNT POSITION(294:302)         CHAR(9),
             TRANSACTION_SOURCE POSITION(304:304)       CHAR(1),
             CHANGE_DATE POSITION(305:312)              CHAR(8),
             CHANGE_SOURCE POSITION(313:320)            CHAR(8),
             SLS_BOOK_DATE POSITION(321:324)            CHAR(4),
             CYCLE_RUN_NUMBER POSITION(325:326)         CHAR(2),
             BOOK_DATE_SEQUENCE POSITION(327:331)       CHAR(5),
             REASON_CODE POSITION(332:333)              CHAR(2)
   ) 
            )
      LOCATION
       ( 'STBD9000_DRAFT_1999.TXT', 
         'STBD9000_DRAFT_2000.TXT', 
         'STBD9000_DRAFT_2001.TXT', 
         'STBD9000_DRAFT_2002.TXT', 
         'STBD9000_DRAFT_2003.TXT', 
         'STBD9000_DRAFT_2004.TXT', 
         'STBD9000_DRAFT_2005.TXT', 
         'STBD9000_DRAFT_2006.TXT', 
         'STBD9000_DRAFT_2007.TXT', 
         'STBD9000_DRAFT_2008.TXT', 
         'STBD9000_DRAFT_2009.TXT', 
         'STBD9000_DRAFT_2010.TXT', 
         'STBD9000_DRAFT_2011.TXT', 
         'STBD9000_DRAFT_2012.TXT', 
         'STBD9000_DRAFT_2013.TXT'
       )
    );
