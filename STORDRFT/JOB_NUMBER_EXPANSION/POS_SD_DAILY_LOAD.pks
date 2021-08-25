--------------------------------------------------------
--  File created - Tuesday-August-24-2021   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package Body POS_SD_DAILY_LOAD
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE PACKAGE BODY "STORDRFT"."POS_SD_DAILY_LOAD" 
/****************************************************************
This package will load the New POSXML TEMP Store Drafts tables
created : 06/02/2016 nxk927 CCN Project....
changed :
*****************************************************************/
AS

PROCEDURE LOAD_POS_ISSUE_CHG_DATA(
/*******************************************************************************
This procedure is used to load the POS store drafts table
"DLY_POS_ISSUE_CHANGE_DATA" with data extracted from new interface tables
created : 06/02/2017 nxk927 CCN Project....
changed : 09/27/2017 nxk927 CCN Project....
          Load date field will be stored with the time stamp and
          using the last batch run date to get the desired data
Changed : 07/02/2019 sxs484 CCN project
          CCNCC-18 Updated reference of 4 chars PNP_CCN_HEADERS.STORE_NO           
          to 6 chars PNP_CCN_HEADERS.STORECCN.      
         : 07/25/2019 jxc517 ASP-1193 CCNSD-8 CCN Project Team....
          Added logic to get draft number from check serial number and handle unused drafts
         : 01/16/2020 jxc517 ASP-1193 CCNSD-8 CCN Project Team....
          Added logic to catch and send email of missing drafts (outside the range provided by Jason's team/printed) coming from POS
        : 10/22/2020 akj899 CCNA2-330 CCN Project..
        Added logic to move data to history and empty the DLY_POS_ISSUE_CHANGE_DATA table.
*******************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)
AS

CURSOR POS_SD_CUR IS
     SELECT CDL.TRAN_GUID,
            'O' TRANSACTION_SOURCE,
            'O' TRANSACTION_TYPE,
            CH.STORECCN COST_CENTER_CODE,
            LPAD(CDL.DRAFT_NBR,10,'0') AS  CHECK_SERIAL_NUMBER,
            SD_CHECK_NBR_PRINT_SRVCS.GET_UNUSED_DRAFT_NUMBER(LPAD(CDL.DRAFT_NBR,10,'0')) DRAFT_NUMBER,
            '1'||TO_CHAR(TO_DATE(TRUNC(SYSDATE)), 'yymmdd') AS PROCESS_DATE,
            NULL FILLER,
            'O' TRANSACTION_SEGMENT_TYPE,
            (CASE WHEN CDL.DRAFT_AMT < 0 THEN '-' ELSE NULL END) NET_AMOUNT_SIGN,
            CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(CDL.DRAFT_AMT, '-', ''), '0', '9', '2')NET_AMOUNT,
            (CASE WHEN CH.INST_RETAINAGE < 0 THEN '-' ELSE NULL END) RETAINAGE_AMOUNT_SIGN,
            CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(CH.INST_RETAINAGE, '-', ''), '0', '9', '2')RETAINAGE_AMOUNT,
            (CASE WHEN (CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE((NVL(CDL.DRAFT_AMT,0) +NVL(CH.INST_RETAINAGE,0)), '-', ''), '0', '9', '2')) < 0 THEN '-' ELSE NULL END) GROSS_AMOUNT_SIGN,
            (CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE((NVL(CDL.DRAFT_AMT,0)), '-', ''), '0', '9', '2')) GROSS_AMOUNT,
            '1'||TO_CHAR(TO_DATE(CH.CTL_DT), 'yymmdd')ISSUE_DATE,
            '1'||TO_CHAR(TO_DATE(CH.TRAN_DATE), 'yymmdd')TRANSACTION_DATE,
            TO_CHAR(CH.TERMNBR) TERMINAL_NUMBER,
            LPAD(CH.TRANNBR,5,'0') TRANSACTION_NUMBER,
            (CASE WHEN CH.TRANID = '82' 
                  THEN '000000000' ELSE DECODE (CDL.DRAFT_ACCT_NBR , '0', CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CDL.DRAFT_ACCT_NBR, '0', '9')
                                                                   , '1', '000000000', CDL.DRAFT_ACCT_NBR) END) CUSTOMER_ACCOUNT_NUMBER,
            (CASE WHEN CH.TRANID = '82' THEN '00001' WHEN CH.TRANID = '19' THEN '00001' ELSE CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CH.JOBNBR, '0', '5') END) CUSTOMER_JOB_NUMBER,
            TO_CHAR(CH.TRANID) POS_TRANSACTION_CODE,
            CH.BILLNM PAYEE_NAME,
            CH.BILLADDR1 ADDRESS_LINE_1,
            CH.BILLADDR2 ADDRESS_LINE_2,
            CH.BILLCITY CITY,
            CH.BILLST STATE_CODE,
            CH.BILLZIP ZIP_CODE,
            CH.BILLPHONE PHONE_NUMBER,
            TO_CHAR(CH.TRAN_TIMESTAMP, 'HH24MI') AS TRANSACTION_TIME,
            LPAD(TRIM(CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CH.EMP_NO, '0', '2')),'2',0) EMPLOYEE_NUMBER,
            TO_CHAR(TO_DATE(TRUNC(SYSDATE)), 'mmdd') AS BOOK_DATE,
            SUBSTR(CH.RLS_RUN_CYCLE, 1, 2) CYCLE_RUN_NUMBER,
            CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CH.REASON_CODE, '0', '2') REASON_CODE,
            CDL.RLS_RUN_CYCLE
      FROM  PNP_CCN_DRAFT_LOGS CDL,
            PNP_CCN_HEADERS CH
      WHERE CDL.TRAN_GUID      = CH.TRAN_GUID
        AND CDL.RLS_RUN_CYCLE  = CH.RLS_RUN_CYCLE
        AND CH.RLS_RUN_CYCLE   = IN_RUN_CYCLE;

   V_COUNT      NUMBER := 0;
   V_TCOUNT     NUMBER := 0;
   V_TEMP_ROW   DLY_POS_ISSUE_CHANGE_DATA%ROWTYPE;

    V_CLOB_FOR_EMAIL CLOB;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE DLY_POS_ISSUE_CHANGE_DATA';
     FOR REC IN POS_SD_CUR
     LOOP
        BEGIN
           V_TEMP_ROW.TRANGUID                     := rec.TRAN_GUID;
           V_TEMP_ROW.TRANSACTION_SOURCE           := rec.TRANSACTION_SOURCE;
           V_TEMP_ROW.TRANSACTION_TYPE             := rec.TRANSACTION_TYPE;
           V_TEMP_ROW.COST_CENTER_CODE             := rec.COST_CENTER_CODE;
           V_TEMP_ROW.CHECK_SERIAL_NUMBER          := rec.CHECK_SERIAL_NUMBER;
           IF rec.DRAFT_NUMBER IS NULL THEN --due to initial load mismatch durint 4 digit store# to 5 digit terminal#
               V_TEMP_ROW.DRAFT_NUMBER             := SUBSTR(rec.CHECK_SERIAL_NUMBER, 6, 4);
               V_CLOB_FOR_EMAIL := rec.COST_CENTER_CODE || ',' || NVL(rec.CHECK_SERIAL_NUMBER,'') || CHR(10);
               --Insert and start tracking the draft in our print extract table
               SD_CHECK_NBR_PRINT_SRVCS.INSRT_OLD_DRFT_OUTSIDE_INITLD_RANGE(V_TEMP_ROW.COST_CENTER_CODE,
                                                                            V_TEMP_ROW.CHECK_SERIAL_NUMBER,
                                                                            CCN_COMMON_TOOLS.GET_DATE_VALUE(rec.TRANSACTION_DATE,'YYMMDD'),
                                                                        --    TO_DATE(rec.TRANSACTION_DATE,'yymmdd'),
                                                                            V_TEMP_ROW.DRAFT_NUMBER);
               ERRPKG.INSERT_ERROR_LOG_SP(errnums.en_inv_check_num_err,
                                          'LOAD_POS_ISSUE_CHG_DATA_TMP', 
                                          'Please validate the unknown draft number received from POS',
                                          rec.COST_CENTER_CODE,
                                          NVL(rec.CHECK_SERIAL_NUMBER,''));
           ELSE
               V_TEMP_ROW.DRAFT_NUMBER             := rec.DRAFT_NUMBER;
           END IF;
           V_TEMP_ROW.PROCESS_DATE                 := rec.PROCESS_DATE;
           V_TEMP_ROW.FILLER                       := rec.FILLER;
           V_TEMP_ROW.TRANSACTION_SEGMENT_TYPE     := rec.TRANSACTION_SEGMENT_TYPE;
           V_TEMP_ROW.NET_AMOUNT_SIGN              := rec.NET_AMOUNT_SIGN;
           V_TEMP_ROW.NET_AMOUNT                   := rec.NET_AMOUNT;
           V_TEMP_ROW.RETAINAGE_AMOUNT_SIGN        := rec.RETAINAGE_AMOUNT_SIGN;
           V_TEMP_ROW.RETAINAGE_AMOUNT             := rec.RETAINAGE_AMOUNT;
           V_TEMP_ROW.GROSS_AMOUNT_SIGN            := rec.GROSS_AMOUNT_SIGN;
           V_TEMP_ROW.GROSS_AMOUNT                 := rec.GROSS_AMOUNT;
           V_TEMP_ROW.GROSS_AMOUNT                 := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.GROSS_AMOUNT+V_TEMP_ROW.RETAINAGE_AMOUNT, '0', '9');
           V_TEMP_ROW.ISSUE_DATE                   := rec.ISSUE_DATE;
           V_TEMP_ROW.TRANSACTION_DATE             := rec.TRANSACTION_DATE;
           V_TEMP_ROW.TERMINAL_NUMBER              := rec.TERMINAL_NUMBER;
           V_TEMP_ROW.TRANSACTION_NUMBER           := rec.TRANSACTION_NUMBER;
           V_TEMP_ROW.TRANSACTION_NUMBER           := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.TRANSACTION_NUMBER, '0', '5');
           V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER      := rec.CUSTOMER_ACCOUNT_NUMBER;
           V_TEMP_ROW.CUSTOMER_JOB_NUMBER          := rec.CUSTOMER_JOB_NUMBER;
           V_TEMP_ROW.POS_TRANSACTION_CODE         := rec.POS_TRANSACTION_CODE;           
           V_TEMP_ROW.CUSTOMER_JOB_NUMBER          := CASE V_TEMP_ROW.POS_TRANSACTION_CODE WHEN '82' THEN '00001' ELSE V_TEMP_ROW.CUSTOMER_JOB_NUMBER END;
           V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER      := CASE V_TEMP_ROW.POS_TRANSACTION_CODE WHEN '82' THEN '000000000' ELSE V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER END;
           V_TEMP_ROW.PAYEE_NAME                   := rec.PAYEE_NAME;
           V_TEMP_ROW.ADDRESS_LINE_1               := rec.ADDRESS_LINE_1;
           V_TEMP_ROW.ADDRESS_LINE_2               := rec.ADDRESS_LINE_2;
           V_TEMP_ROW.CITY                         := rec.CITY;
           V_TEMP_ROW.STATE_CODE                   := rec.STATE_CODE;
           V_TEMP_ROW.ZIP_CODE                     := rec.ZIP_CODE;
           V_TEMP_ROW.PHONE_NUMBER                 := rec.PHONE_NUMBER;
           V_TEMP_ROW.TRANSACTION_TIME             := rec.TRANSACTION_TIME;
           V_TEMP_ROW.EMPLOYEE_NUMBER              := rec.EMPLOYEE_NUMBER;
           V_TEMP_ROW.BOOK_DATE                    := rec.BOOK_DATE;
           V_TEMP_ROW.CYCLE_RUN_NUMBER             := rec.CYCLE_RUN_NUMBER;
           V_TEMP_ROW.REASON_CODE                  := rec.REASON_CODE;
           V_TEMP_ROW.RUNCYCLE                     := rec.RLS_RUN_CYCLE;
           V_TEMP_ROW.LOAD_DATE                    := SYSDATE;

           INSERT INTO DLY_POS_ISSUE_CHANGE_DATA VALUES V_TEMP_ROW;

           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POS_ISSUE_CHG_DATA_TMP',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           NVL(rec.CHECK_SERIAL_NUMBER,''));
        END;
     END LOOP;
    --Inserting records into history table 
    INSERT INTO DLY_POS_ISSUE_CHANGE_DATA_HST 
    SELECT TRANGUID, TRANSACTION_SOURCE, TRANSACTION_TYPE, COST_CENTER_CODE, CHECK_SERIAL_NUMBER, DRAFT_NUMBER, PROCESS_DATE, FILLER, TRANSACTION_SEGMENT_TYPE, NET_AMOUNT_SIGN, NET_AMOUNT,
          GROSS_AMOUNT_SIGN, GROSS_AMOUNT, RETAINAGE_AMOUNT_SIGN, RETAINAGE_AMOUNT, ISSUE_DATE, TRANSACTION_DATE, TERMINAL_NUMBER, TRANSACTION_NUMBER, CUSTOMER_ACCOUNT_NUMBER, 
          CUSTOMER_JOB_NUMBER, POS_TRANSACTION_CODE, PAYEE_NAME, ADDRESS_LINE_1, ADDRESS_LINE_2, CITY, STATE_CODE, ZIP_CODE, PHONE_NUMBER, TRANSACTION_TIME, EMPLOYEE_NUMBER, BOOK_DATE, 
          CYCLE_RUN_NUMBER, REASON_CODE, RUNCYCLE, LOAD_DATE, SYSDATE
     FROM DLY_POS_ISSUE_CHANGE_DATA;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

    IF V_CLOB_FOR_EMAIL <> EMPTY_CLOB() THEN
        V_CLOB_FOR_EMAIL := 'COST_CENTER_CODE, CHECK_SERIAL_NUMBER' || CHR(10) || V_CLOB_FOR_EMAIL;
        MAIL_PKG.SEND_MAIL('DRAFT_CHECK_MISSING_MAIL', NULL, NULL,V_CLOB_FOR_EMAIL);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
          ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POS_ISSUE_CHG_DATA_TMP',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
END LOAD_POS_ISSUE_CHG_DATA;

PROCEDURE LOAD_POS_INSTLR_LN_ID_DTL(
/*******************************************************************************
This procedure is used to load the POS store drafts table
"DLY_POS_INSTLLR_LN_ITM_DATA" with data extracted from new interface tables
created : 06/02/2017 nxk927 CCN Project....
changed : 09/27/2017 nxk927 CCN Project....
          Load date field will be stored with the time stamp and
          using the last batch run date to get the desired data
Changed : 07/02/2019 sxs484 CCN project
          CCNCC-18 Updated reference of 4 chars PNP_CCN_HEADERS.STORE_NO           
          to 6 chars PNP_CCN_HEADERS.STORECCN.          
*******************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)

AS
-- Cursor for loading the table POS_INSTLR_LN_ITEM_DATA_TMP
   CURSOR POS_INSTLR_LID IS
       SELECT CH.TRAN_GUID,
              'O' TRANSACTION_SOURCE,              -- Unused column and obsolete
              'O' TRANSACTION_TYPE,                -- Unused column and obsolete
              CH.STORECCN COST_CENTER_CODE,
              LPAD(CDL.DRAFT_NBR,10,0) CHECK_SERIAL_NUMBER,
              '1'||TO_CHAR(TO_DATE(TRUNC(SYSDATE)), 'yymmdd') PROCESS_DATE,
              NULL FILLER,
              'O' TRANSACTION_SEGMENT_TYPE,        -- Unused column and obsolete
              NULL ITEM_EXT_AMOUNT_SIGN,
              LPAD(CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(CIL.IL_EXTENDED_PRICE, '-', ''), '0', '9', '2'),9,'0')ITEM_EXT_AMOUNT,
              CIL.IL_P_TERM_NBR ORGNL_TERMINAL_NUMBER,
              CIL.IL_P_TRAN_NBR ORGNL_TRANSACTION_NUMBER,
              NULL ITEM_QTY_SIGN,
              CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CIL.IL_QTY, '0', '7', '2')ITEM_QTY,
              NULL ITEM_PRICE_SIGN,
              LPAD(CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(CIL.IL_PRICE, '-', ''), '0', '7', '2'),7,'0') ITEM_PRICE,
              CIL.IL_PRIME GL_PRIME_ACCOUNT_NUMBER,      -- Hard coded as 7504, 1693 for now
              CIL.IL_SUB GL_SUB_ACCOUNT_NUMBER,         -- Hard coded for 101, 120 now
              CH.RLS_RUN_CYCLE
           FROM PNP_CCN_HEADERS CH,
              PNP_CCN_DRAFT_LOGS CDL,
              PNP_CCN_INSTALLER_LINES CIL
        WHERE CH.TRAN_GUID = CDL.TRAN_GUID
          AND CH.TRAN_GUID = CIL.TRAN_GUID
          AND CH.RLS_RUN_CYCLE = CDL.RLS_RUN_CYCLE
          AND CH.RLS_RUN_CYCLE = CIL.RLS_RUN_CYCLE
          AND CH.TRANID = '13'
          AND CH.RLS_RUN_CYCLE =IN_RUN_CYCLE;

    V_COUNT     NUMBER := 0;
    V_TCOUNT    NUMBER := 0;
    V_TEMP_ROW  DLY_POS_INSTLLR_LN_ITM_DATA%ROWTYPE;
BEGIN

-- Cursor for loading POS_INSTLR_LN_ITEM_DATA_TMP
   FOR REC IN POS_INSTLR_LID
     LOOP
        BEGIN
           V_TEMP_ROW.TRANGUID                                := rec.TRAN_GUID;
           V_TEMP_ROW.TRANSACTION_SOURCE                      := rec.TRANSACTION_SOURCE;
           V_TEMP_ROW.TRANSACTION_TYPE                        := rec.TRANSACTION_TYPE;
           V_TEMP_ROW.COST_CENTER_CODE                        := rec.COST_CENTER_CODE;
           V_TEMP_ROW.CHECK_SERIAL_NUMBER                     := rec.CHECK_SERIAL_NUMBER;
           V_TEMP_ROW.PROCESS_DATE                            := rec.PROCESS_DATE;
           V_TEMP_ROW.FILLER                                  := rec.FILLER;
           V_TEMP_ROW.TRANSACTION_SEGMENT_TYPE                := rec.TRANSACTION_SEGMENT_TYPE;
           V_TEMP_ROW.ITEM_EXT_AMOUNT_SIGN                    := rec.ITEM_EXT_AMOUNT_SIGN;
           V_TEMP_ROW.ITEM_EXT_AMOUNT                         := rec.ITEM_EXT_AMOUNT;
           V_TEMP_ROW.ORGNL_TERMINAL_NUMBER                   := rec.ORGNL_TERMINAL_NUMBER;
           V_TEMP_ROW.ORGNL_TRANSACTION_NUMBER                := rec.ORGNL_TRANSACTION_NUMBER;
           V_TEMP_ROW.ORGNL_TRANSACTION_NUMBER                := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.ORGNL_TRANSACTION_NUMBER, '0', '5');
           V_TEMP_ROW.ITEM_QUANTITY_SIGN                      := rec.ITEM_QTY_SIGN;
           V_TEMP_ROW.ITEM_QUANTITY                           := rec.ITEM_QTY;
           V_TEMP_ROW.ITEM_PRICE_SIGN                         := rec.ITEM_PRICE_SIGN;
           V_TEMP_ROW.ITEM_PRICE                              := rec.ITEM_PRICE;
           V_TEMP_ROW.GL_PRIME_ACCOUNT_NUMBER                 := rec.GL_PRIME_ACCOUNT_NUMBER;
           V_TEMP_ROW.GL_SUB_ACCOUNT_NUMBER                   := rec.GL_SUB_ACCOUNT_NUMBER;
           V_TEMP_ROW.RUNCYCLE                                := rec.RLS_RUN_CYCLE;
           V_TEMP_ROW.LOAD_DATE                               := SYSDATE;

           INSERT INTO DLY_POS_INSTLLR_LN_ITM_DATA VALUES V_TEMP_ROW;

           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POS_INSTLR_LN_ID_DTL',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           rec.CHECK_SERIAL_NUMBER);
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POS_INSTLR_LN_ID_DTL',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_POS_INSTLR_LN_ID_DTL;

PROCEDURE LOAD_POS_CSTMR_LINE_ITEM(
/*******************************************************************************
This procedure is used to load the POS store drafts table
"DLY_POS_CSTMR_LINE_ITEM_DATA" with data extracted from new interface tables
created : 06/02/2016 nxk927 CCN Project....
changed : 09/27/2017 nxk927 CCN Project....
          Load date field will be stored with the time stamp and
          using the last batch run date to get the desired data
Changed : 07/02/2019 sxs484 CCN project
          CCNCC-18 Updated reference of 4 chars PNP_CCN_HEADERS.STORE_NO           
          to 6 chars PNP_CCN_HEADERS.STORECCN.          
*******************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)
AS
-- Cursor for loading the table POS_CUST_LINE_ITEM_DATA_TMP
 CURSOR POS_CUST_LID IS
     SELECT CH.TRAN_GUID,
            'O' TRANSACTION_SOURCE,
            'O' TRANSACTION_TYPE,
            CH.STORECCN COST_CENTER_CODE,
            LPAD(CDL.DRAFT_NBR,10,'0') AS CHECK_SERIAL_NUMBER,
            '1'||TO_CHAR(TO_DATE(TRUNC(SYSDATE)), 'yymmdd') AS PROCESS_DATE,
            NULL FILLER,
            'O' TRANSACTION_SEGMENT_TYPE,
            (CASE WHEN CDL.DRAFT_AMT < 0 THEN '-' ELSE NULL END) ITEM_EXT_AMOUNT_SIGN,
            CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(CDL.DRAFT_AMT, '-', ''), '0', '9', '2')ITEM_EXT_AMOUNT,
            (CASE WHEN TRIM(CDL.DRAFT_ACCT_NBR) = '1' THEN '000000000' ELSE TRIM(CDL.DRAFT_ACCT_NBR) END) ORGNL_CUSTOMER_ACCOUNT_NUMBER,
            CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CH.JOBNBR, '0', '5')ORGNL_JOB_NUMBER,
            CH.RLS_RUN_CYCLE
       FROM PNP_CCN_HEADERS CH,
            PNP_CCN_DRAFT_LOGS CDL
      WHERE CH.TRAN_GUID = CDL.TRAN_GUID
        AND CH.TRANID IN ('19', '91')
        AND CH.RLS_RUN_CYCLE = IN_RUN_CYCLE;
    V_COUNT     NUMBER := 0;
    V_TCOUNT    NUMBER := 0;
    V_TEMP_ROW  DLY_POS_CSTMR_LINE_ITEM_DATA%ROWTYPE;
BEGIN

FOR REC IN POS_CUST_LID
     LOOP
        BEGIN
           V_TEMP_ROW.TRANGUID                                := rec.TRAN_GUID;
           V_TEMP_ROW.TRANSACTION_SOURCE                      := rec.TRANSACTION_SOURCE;
           V_TEMP_ROW.TRANSACTION_TYPE                        := rec.TRANSACTION_TYPE;
           V_TEMP_ROW.COST_CENTER_CODE                        := rec.COST_CENTER_CODE;
           V_TEMP_ROW.CHECK_SERIAL_NUMBER                     := rec.CHECK_SERIAL_NUMBER;
           V_TEMP_ROW.PROCESS_DATE                            := rec.PROCESS_DATE;
           V_TEMP_ROW.FILLER                                  := rec.FILLER;
           V_TEMP_ROW.TRANSACTION_SEGMENT_TYPE                := rec.TRANSACTION_SEGMENT_TYPE;
           V_TEMP_ROW.ITEM_EXT_AMOUNT_SIGN                    := rec.ITEM_EXT_AMOUNT_SIGN;
           V_TEMP_ROW.ITEM_EXT_AMOUNT                         := rec.ITEM_EXT_AMOUNT;
           V_TEMP_ROW.ORGNL_CUSTOMER_ACCOUNT_NUMBER           := rec.ORGNL_CUSTOMER_ACCOUNT_NUMBER;
           V_TEMP_ROW.ORGNL_JOB_NUMBER                        := rec.ORGNL_JOB_NUMBER;
           V_TEMP_ROW.RUNCYCLE                                := rec.RLS_RUN_CYCLE;
           V_TEMP_ROW.LOAD_DATE                               := SYSDATE;

           INSERT INTO DLY_POS_CSTMR_LINE_ITEM_DATA VALUES V_TEMP_ROW;

           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POS_CSTMR_LINE_IT',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           rec.CHECK_SERIAL_NUMBER);
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POS_CSTMR_LINE_ITEM',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_POS_CSTMR_LINE_ITEM;

PROCEDURE LOAD_POS_DSBRSMT_LID(
/*******************************************************************************
This procedure is used to load the POS store drafts table
"DLY_POS_DSBRSMNT_LN_ITM_DATA" with data extracted from new interface tables
created : 06/02/2016 nxk927 CCN Project....
changed : 09/27/2017 nxk927 CCN Project....
          Load date field will be stored with the time stamp and
          using the last batch run date to get the desired data
Changed : 07/02/2019 sxs484 CCN project
          CCNCC-18 Updated reference of 4 chars PNP_CCN_HEADERS.STORE_NO           
          to 6 chars PNP_CCN_HEADERS.STORECCN.          
*******************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)
AS

-- POS_DISBRSMT_LINE_ITEM_TMP
 CURSOR POS_DISBRSMT_LID IS
      SELECT CH.TRAN_GUID,
             'O' TRANSACTION_SOURCE,
             'O' TRANSACTION_TYPE,
             CH.STORECCN COST_CENTER_CODE,
             LPAD(CDL.DRAFT_NBR,10,'0') AS CHECK_SERIAL_NUMBER,
             '1'||TO_CHAR(TO_DATE(TRUNC(SYSDATE)), 'yymmdd') AS PROCESS_DATE,
             CAST(NULL AS VARCHAR2(100))FILLER,
             'O' TRANSACTION_SEGMENT_TYPE,
             NULL ITEM_EXT_AMOUNT_SIGN,  -- Not considering the sign instead of negating
             CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(CML.AMT, '-', ''), '0', '9', '2')ITEM_EXT_AMOUNT,
             SUBSTR(CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CML.PRIMESUB, '0', 7), 1, 4) GL_PRIME_ACCOUNT_NUMBER,
             SUBSTR(CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CML.PRIMESUB, '0', 7), 5, 3)GL_SUB_ACCOUNT_NUMBER,
             CH.RLS_RUN_CYCLE
         FROM PNP_CCN_HEADERS CH,
              PNP_CCN_DRAFT_LOGS CDL,
              PNP_CCN_MISC_LINES CML
        WHERE CH.TRAN_GUID       = CDL.TRAN_GUID
          AND CH.TRAN_GUID       = CML.TRAN_GUID
          AND TO_CHAR(CH.TRANID) = '82'
          AND CH.RLS_RUN_CYCLE   = IN_RUN_CYCLE;

    V_COUNT     NUMBER := 0;
    V_TCOUNT    NUMBER := 0;
    V_TEMP_ROW  DLY_POS_DSBRSMNT_LN_ITM_DATA%ROWTYPE;
BEGIN

FOR REC IN POS_DISBRSMT_LID
     LOOP
        BEGIN
           V_TEMP_ROW.TRANGUID                                := rec.TRAN_GUID;
           V_TEMP_ROW.TRANSACTION_SOURCE                      := rec.TRANSACTION_SOURCE;
           V_TEMP_ROW.TRANSACTION_TYPE                        := rec.TRANSACTION_TYPE;
           V_TEMP_ROW.COST_CENTER_CODE                        := rec.COST_CENTER_CODE;
           V_TEMP_ROW.CHECK_SERIAL_NUMBER                     := rec.CHECK_SERIAL_NUMBER;
           V_TEMP_ROW.PROCESS_DATE                            := rec.PROCESS_DATE;
           V_TEMP_ROW.FILLER                                  := rec.FILLER;
           V_TEMP_ROW.TRANSACTION_SEGMENT_TYPE                := rec.TRANSACTION_SEGMENT_TYPE;
           V_TEMP_ROW.ITEM_EXT_AMOUNT_SIGN                    := rec.ITEM_EXT_AMOUNT_SIGN;
           V_TEMP_ROW.ITEM_EXT_AMOUNT                         := rec.ITEM_EXT_AMOUNT;
           V_TEMP_ROW.GL_PRIME_ACCOUNT_NUMBER                 := rec.GL_PRIME_ACCOUNT_NUMBER;
           V_TEMP_ROW.GL_SUB_ACCOUNT_NUMBER                   := rec.GL_SUB_ACCOUNT_NUMBER;
           V_TEMP_ROW.RUNCYCLE                                := rec.RLS_RUN_CYCLE;
           V_TEMP_ROW.LOAD_DATE                               := SYSDATE;

           INSERT INTO DLY_POS_DSBRSMNT_LN_ITM_DATA VALUES V_TEMP_ROW;

           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
               ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POS_DSBRSMT_LID',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           rec.CHECK_SERIAL_NUMBER);
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POS_DSBRSMT_LID',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_POS_DSBRSMT_LID;

PROCEDURE LOAD_DLY_POS_CSTMR(
/****************************************************************************
This procedure is used to load the POSXML store drafts table
"DLY_POS_CUSTOMER" with data extracted from new interface tables
created : 06/02/2016 nxk927 CCN Project....
changed : 09/27/2017 nxk927 CCN Project....
          Load date field will be stored with the time stamp and
          using the last batch run date to get the desired data
Changed : 07/02/2019 sxs484 CCN project
          CCNCC-18 Updated reference of 4 chars PNP_CCN_HEADERS.STORE_NO           
          to 6 chars PNP_CCN_HEADERS.STORECCN.
Changed : 07/21/2021 akj899 CCNA2-516 CCN project...
          Rep Loass Gain Phase 2 project changes to populate customer account number 
          and job number as well when account number is 1, 2, 3 or 9
*****************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)

AS
CURSOR POS_SD_CUR IS
    SELECT CH.TRAN_GUID,
           CH.STORECCN COST_CENTER_CODE,
           TRIM(TO_CHAR(CH.TERMNBR)) TERMINAL_NUMBER,
           LPAD(TRIM(CH.TRANNBR),5,'0') TRANSACTION_NUMBER,
           'O' SORT_FORCE,
           'O' SEGMENT_CODE,
           'O' SUB_SEGMENT_CODE,
           NULL FILLER,
           '1'||TO_CHAR(TO_DATE(CH.TRAN_DATE), 'yymmdd')TRANSACTION_DATE,
          -- DECODE(TRIM(CH.ACCTNBR), '1', NULL, '9', NULL, '3', NULL,TRIM(CH.ACCTNBR)) CUSTOMER_ACCOUNT_NUMBER,
		   CASE WHEN TRIM(CH.ACCTNBR) IN (1, 2, 3, 9) THEN LPAD(TRIM(CH.ACCTNBR), 9, 0) ELSE TRIM(CH.ACCTNBR) END CUSTOMER_ACCOUNT_NUMBER,
         --  DECODE(TRIM(CH.ACCTNBR), '1', NULL, '9', NULL, '3',NULL,CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CH.JOBNBR, '0', '5'))CUSTOMER_JOB_NUMBER,
           CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CH.JOBNBR, '0', '5') CUSTOMER_JOB_NUMBER,
           'O' POS_TRANSACTION_NUMBER_BATCH, 
            CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(TO_CHAR(CH.TRAN_TIMESTAMP, 'HH24MI'), '0', '4') AS POS_TRANSACTION_TIME,
           SUBSTR(CH.RLS_RUN_CYCLE, 1, 2) CYCLE_RUN_NUMBER,
           LPAD(TRIM(CH.EMP_NO),'2',0) EMPLOYEE_NUMBER,
           'O' POS_MODE_INDICATOR,          
           CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CH.CUSTTYPNBR, '0', '2') BUSINESS_TYPE_CODE,
           CH.TERRNBR SLS_TERRITORY_NUMBER,
           'O' SLS_TERRITORY_NUMBER_NO_CORR,
           'O' TERRITORY_SPLIT_INDICATOR,
           TRIM(TO_CHAR(CH.TRANID)) POS_TRANSACTION_CODE,
           'O' POS_TRANSACTION_DATE,
           'O' POS_TERMINAL_NUMBER,
           'O' POS_TRANSACTION_NUMBER,
           'O' DATA_INDICATOR,
           (CASE WHEN SHIPNM like '%PO %' or SHIPNM like '%P.O.%' or SHIPNM like '%PO#%'
               THEN SHIPNM
               ELSE NULL
               END) PURCHASE_ORDER_NUMBER,
           CH.RLS_RUN_CYCLE
       FROM PNP_CCN_HEADERS CH
      WHERE TRIM(TO_CHAR(CH.TRANID)) in ('10','11','31','22','19','41')
        AND CH.RLS_RUN_CYCLE = IN_RUN_CYCLE
        AND EXISTS (SELECT 1
                      FROM PNP_CCN_SALES_LINES
                     WHERE SALESNBR = '000009126'
                       AND RLS_RUN_CYCLE = CH.RLS_RUN_CYCLE
                       AND TRAN_GUID = CH.TRAN_GUID);


      V_COUNT     NUMBER := 0;
      V_TCOUNT    NUMBER := 0;
      V_TEMP_ROW  DLY_POS_CUSTOMER%ROWTYPE;

BEGIN
  FOR REC IN POS_SD_CUR
     LOOP
        BEGIN
           V_TEMP_ROW.TRANGUID                                := rec.TRAN_GUID;
           V_TEMP_ROW.COST_CENTER_CODE                        := rec.COST_CENTER_CODE;
           V_TEMP_ROW.TERMINAL_NUMBER                         := rec.TERMINAL_NUMBER;
           V_TEMP_ROW.TRANSACTION_NUMBER                      := rec.TRANSACTION_NUMBER;
           V_TEMP_ROW.TRANSACTION_NUMBER                      := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.TRANSACTION_NUMBER, '0', '5');
           V_TEMP_ROW.SORT_FORCE                              := rec.SORT_FORCE;
           V_TEMP_ROW.SEGMENT_CODE                            := rec.SEGMENT_CODE;
           V_TEMP_ROW.SUB_SEGMENT_CODE                        := rec.SUB_SEGMENT_CODE;
           V_TEMP_ROW.FILLER                                  := rec.FILLER;
           V_TEMP_ROW.TRANSACTION_DATE                        := rec.TRANSACTION_DATE;
           V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER                 := rec.CUSTOMER_ACCOUNT_NUMBER;
           V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER                 := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER, '0', '9');
           V_TEMP_ROW.CUSTOMER_JOB_NUMBER                     := rec.CUSTOMER_JOB_NUMBER;
           V_TEMP_ROW.POS_TRANSACTION_NUMBER_BATCH            := rec.POS_TRANSACTION_NUMBER_BATCH;
           V_TEMP_ROW.POS_TRANSACTION_TIME                    := rec.POS_TRANSACTION_TIME;
           V_TEMP_ROW.CYCLE_RUN_NUMBER                        := rec.CYCLE_RUN_NUMBER;
           V_TEMP_ROW.EMPLOYEE_NUMBER                         := rec.EMPLOYEE_NUMBER;
           V_TEMP_ROW.EMPLOYEE_NUMBER                         := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.EMPLOYEE_NUMBER, '0', '2');
           V_TEMP_ROW.POS_MODE_INDICATOR                      := rec.POS_MODE_INDICATOR;
           V_TEMP_ROW.BUSINESS_TYPE_CODE                      := rec.BUSINESS_TYPE_CODE;
           V_TEMP_ROW.BUSINESS_TYPE_CODE                      := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.BUSINESS_TYPE_CODE, '0', '2');
           V_TEMP_ROW.SLS_TERRITORY_NUMBER                    := rec.SLS_TERRITORY_NUMBER;
           V_TEMP_ROW.SLS_TERRITORY_NUMBER_NO_CORR            := rec.SLS_TERRITORY_NUMBER_NO_CORR;
           V_TEMP_ROW.TERRITORY_SPLIT_INDICATOR               := rec.TERRITORY_SPLIT_INDICATOR;
           V_TEMP_ROW.POS_TRANSACTION_CODE                    := rec.POS_TRANSACTION_CODE;
           V_TEMP_ROW.POS_TRANSACTION_DATE                    := rec.POS_TRANSACTION_DATE;
           V_TEMP_ROW.POS_TERMINAL_NUMBER                     := rec.POS_TERMINAL_NUMBER;
           V_TEMP_ROW.POS_TRANSACTION_NUMBER                  := rec.POS_TRANSACTION_NUMBER;
           V_TEMP_ROW.DATA_INDICATOR                          := rec.DATA_INDICATOR;
           V_TEMP_ROW.PURCHASE_ORDER_NUMBER                   := SUBSTR(rec.PURCHASE_ORDER_NUMBER, 1, 20);--rec.PURCHASE_ORDER_NUMBER;
           V_TEMP_ROW.RUNCYCLE                                := rec.RLS_RUN_CYCLE;
           V_TEMP_ROW.LOAD_DATE                               := SYSDATE;

           INSERT INTO DLY_POS_CUSTOMER VALUES V_TEMP_ROW;

           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 50 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_DLY_POS_CSTMR',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           'TermNbr: '||NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           'TranNbr: '||NVL(rec.TRANSACTION_NUMBER,''));
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_DLY_POS_CSTMR',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_DLY_POS_CSTMR;

PROCEDURE LOAD_DLY_POS_CSTMR_DTLS(
/****************************************************************************
This procedure is used to load the POS store drafts table
"DLY_POS_CUSTOMER_DETAILS" with data extracted from new interface tables
created : 06/02/2017 nxk927 CCN Project....
changed : 09/27/2017 nxk927 CCN Project....
          Load date field will be stored with the time stamp and
          using the last batch run date to get the desired data
*****************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)
AS

CURSOR POS_SD_CUR IS
    SELECT CH.TRANGUID,
         csl.SEQNBR SEQNBR,
         CH.COST_CENTER_CODE,
         CH.TERMINAL_NUMBER,
         CH.TRANSACTION_NUMBER,
         'O' SORT_FORCE,
         'O' SEGMENT_CODE,
         'O' SUB_SEGMENT_CODE,
         NULL FILLER,
         (CASE CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CSL.SALESNBR, '0', '9') 
          WHEN '000009126' THEN '000912600' 
          WHEN '000009159' THEN '000915900' 
          WHEN '000009217' THEN '000921700'
          WHEN '000009118' THEN '000911800'
          WHEN '000009134' THEN '000913400'
          WHEN '000009142' THEN '000914200'
          ELSE CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CSL.SALESNBR, '0', '9') END) SALES_NUMBER,
         (CASE WHEN CSL.QTY < 0 THEN '-' ELSE NULL END) ITEM_QUANTITY_SIGN,
         CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CSL.QTY, '0', '7', '2')ITEM_QUANTITY,
         (CASE WHEN CSL.PR < 0 THEN '-' ELSE NULL END) ITEM_PRICE_SIGN,
         CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(CSL.PR, '-', ''), '0', '7', '2'), '0', '7')ITEM_PRICE,
         (CASE WHEN CSL.EXTENDED_PRICE < 0 THEN '-' ELSE NULL END) ITEM_EXTERNAL_AMOUNT_SIGN,
         CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(CSL.EXTENDED_PRICE, '-', ''), '0', '7', '2'), '0', '7')ITEM_EXTERNAL_AMOUNT,
         NULL ITEM_DISC_AMOUNT_SIGN,
         '0000000' ITEM_DISC_AMOUNT,
         '0' ITEM_SALES_TAX_INDICATOR,     
         '0' ITEM_DISC_CODE,
         '0' ITEM_DISC_TYPE,
         '0' SALES_PROMO_CODE,
         CSL.PRIME GL_PRIME_ACCOUNT,
         CSL.SUB GL_SUB_ACCOUNT,
         NULL SCHEDULE_TYPE,
         NULL SCHEDULE_VERSION,
         NULL PRICE_LVL_CODE,
         '000' PERCENT_OFF_LVL,
         NULL PROD_DESC_SOURCE,
         '00000' ORGNL_POS_TERMINAL_NUMBER,
         '00000' ORGNL_POS_TRANSACTION_NUMBER,
         CH.RUNCYCLE
    FROM DLY_POS_CUSTOMER CH,
         PNP_CCN_SALES_LINES CSL
     WHERE CH.TRANGUID = CSL.TRAN_GUID
       AND TRIM(TO_CHAR(CH.POS_TRANSACTION_CODE)) in ('10','11','31','22','19','41')
       AND CH.RUNCYCLE  = IN_RUN_CYCLE
       AND CH.RUNCYCLE  = CSL.RLS_RUN_CYCLE;


      V_COUNT     NUMBER := 0;
      V_TCOUNT    NUMBER := 0;
      V_TEMP_ROW  DLY_POS_CUSTOMER_DETAILS%ROWTYPE;

BEGIN
  FOR REC IN POS_SD_CUR
     LOOP
        BEGIN
           V_TEMP_ROW.TRANGUID                                := rec.TRANGUID;
           V_TEMP_ROW.COST_CENTER_CODE                        := rec.COST_CENTER_CODE;
           V_TEMP_ROW.TERMINAL_NUMBER                         := rec.TERMINAL_NUMBER;
           V_TEMP_ROW.TRANSACTION_NUMBER                      := rec.TRANSACTION_NUMBER;
           V_TEMP_ROW.TRANSACTION_NUMBER                      := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.TRANSACTION_NUMBER, '0', '5');
           V_TEMP_ROW.SORT_FORCE                              := rec.SORT_FORCE;
           V_TEMP_ROW.SEGMENT_CODE                            := rec.SEGMENT_CODE;
           V_TEMP_ROW.SUB_SEGMENT_CODE                        := rec.SUB_SEGMENT_CODE;
           V_TEMP_ROW.FILLER                                  := rec.FILLER;
           V_TEMP_ROW.SALES_NUMBER                            := rec.SALES_NUMBER;
           V_TEMP_ROW.SALES_NUMBER                            := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.SALES_NUMBER, '0', '9');
           V_TEMP_ROW.SALES_NUMBER                            := CASE V_TEMP_ROW.SALES_NUMBER WHEN '000009126' THEN '000912600' WHEN '000009159' THEN '000915900' ELSE V_TEMP_ROW.SALES_NUMBER END;
           V_TEMP_ROW.ITEM_QUANTITY_SIGN                      := rec.ITEM_QUANTITY_SIGN;
           V_TEMP_ROW.ITEM_QUANTITY                           := rec.ITEM_QUANTITY;
           V_TEMP_ROW.ITEM_QUANTITY                           := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.ITEM_QUANTITY, '0', '7');
           V_TEMP_ROW.ITEM_PRICE_SIGN                         := rec.ITEM_PRICE_SIGN;
           V_TEMP_ROW.ITEM_PRICE                              := rec.ITEM_PRICE;
           V_TEMP_ROW.ITEM_PRICE                              := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.ITEM_PRICE, '0', '7');
           V_TEMP_ROW.ITEM_EXTERNAL_AMOUNT_SIGN               := rec.ITEM_EXTERNAL_AMOUNT_SIGN;
           V_TEMP_ROW.ITEM_EXTERNAL_AMOUNT                    := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(rec.ITEM_EXTERNAL_AMOUNT, '0', '7');
           V_TEMP_ROW.ITEM_DISC_AMOUNT_SIGN                   := rec.ITEM_DISC_AMOUNT_SIGN;
           V_TEMP_ROW.ITEM_DISC_AMOUNT                        := rec.ITEM_DISC_AMOUNT;
           V_TEMP_ROW.ITEM_SALES_TAX_INDICATOR                := rec.ITEM_SALES_TAX_INDICATOR;
           V_TEMP_ROW.ITEM_DISC_CODE                          := rec.ITEM_DISC_CODE;
           V_TEMP_ROW.ITEM_DISC_TYPE                          := rec.ITEM_DISC_TYPE;
           V_TEMP_ROW.SALES_PROMO_CODE                        := rec.SALES_PROMO_CODE;
           V_TEMP_ROW.GL_PRIME_ACCOUNT                        := rec.GL_PRIME_ACCOUNT;
           V_TEMP_ROW.GL_SUB_ACCOUNT                          := rec.GL_SUB_ACCOUNT;
           V_TEMP_ROW.SCHEDULE_TYPE                           := rec.SCHEDULE_TYPE;
           V_TEMP_ROW.SCHEDULE_VERSION                        := rec.SCHEDULE_VERSION;
           V_TEMP_ROW.PRICE_LVL_CODE                          := rec.PRICE_LVL_CODE;
           V_TEMP_ROW.PERCENT_OFF_LVL                         := rec.PERCENT_OFF_LVL;
           V_TEMP_ROW.PROD_DESC_SOURCE                        := rec.PROD_DESC_SOURCE;
           V_TEMP_ROW.ORGNL_POS_TERMINAL_NUMBER               := rec.ORGNL_POS_TERMINAL_NUMBER;
           V_TEMP_ROW.ORGNL_POS_TRANSACTION_NUMBER            := rec.ORGNL_POS_TRANSACTION_NUMBER;
           V_TEMP_ROW.RUNCYCLE                                := rec.RUNCYCLE;
           V_TEMP_ROW.LOAD_DATE                               := SYSDATE;
           V_TEMP_ROW.SEQNBR                                  := rec.SEQNBR;


           INSERT INTO DLY_POS_CUSTOMER_DETAILS VALUES V_TEMP_ROW;

           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_DLY_POS_CSTMR_DTLS',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           'TermNbr: '||NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           'TranNbr: '||NVL(rec.TRANSACTION_NUMBER,''));
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_DLY_POS_CSTMR_DTLS',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
END LOAD_DLY_POS_CSTMR_DTLS;

PROCEDURE LOAD_POS_CSTMR_SLS_TAX(
/****************************************************************************
This procedure is used to load the POS store drafts table 
"DLY_POS_CSTMR_SALES_TAX" with data extracted from new interface tables
created : 06/02/2017 nxk927 CCN Project....
changed : 09/27/2017 nxk927 CCN Project....
          Load date field will be stored with the time stamp and
          using the last batch run date to get the desired data
*****************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)
AS

CURSOR POS_SD_CUR IS
   SELECT CH.TRANGUID,
          CH.COST_CENTER_CODE,
          CH.TERMINAL_NUMBER,
          CH.TRANSACTION_NUMBER,
          'O' SORT_FORCE,
          'O' SEGMENT_CODE,
          'O' SUB_SEGMENT_CODE,
          NULL FILLER,
          'O' SALES_TAX_CORR_INDICATOR,
          (CASE WHEN CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE((NVL(CTW.AMT, 0)+NVL(CTW.GSTAMT, 0))*100, '-', ''), '0', '7') < 0 THEN '-' ELSE NULL END) SALES_TAX_COLL_AMOUNT_SIGN,
          CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE((NVL(CTW.AMT, 0)+NVL(CTW.GSTAMT, 0))*100, '-', ''), '0', '7') SALES_TAX_COLL_AMOUNT,
          '1' SALES_TAX_INDICATOR,
          (CASE WHEN CTW.PCT < 0 THEN '-' ELSE NULL END) SALES_TAX_RATE_SIGN,
          CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(CTW.PCT*1000, '-', ''), '0', '5') SALES_TAX_RATE,
          CTW.ID SALES_TAX_CODE,
          CH.RUNCYCLE
     FROM DLY_POS_CUSTOMER CH,
          PNP_CCN_TW_TAX_TTL CTW
    WHERE CH.TRANGUID = CTW.TRAN_GUID
      AND CH.RUNCYCLE = IN_RUN_CYCLE
      AND CH.RUNCYCLE = CTW.RLS_RUN_CYCLE;

      V_COUNT     NUMBER := 0;
      V_TCOUNT    NUMBER := 0;
      V_TEMP_ROW  DLY_POS_CSTMR_SALES_TAX%ROWTYPE;

BEGIN

FOR REC IN POS_SD_CUR
     LOOP
        BEGIN
           V_TEMP_ROW.TRANGUID                                := rec.TRANGUID;
           V_TEMP_ROW.COST_CENTER_CODE                        := rec.COST_CENTER_CODE;
           V_TEMP_ROW.TERMINAL_NUMBER                         := rec.TERMINAL_NUMBER;
           V_TEMP_ROW.TRANSACTION_NUMBER                      := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(rec.TRANSACTION_NUMBER, '0', '5');
           V_TEMP_ROW.SORT_FORCE                              := rec.SORT_FORCE;
           V_TEMP_ROW.SEGMENT_CODE                            := rec.SEGMENT_CODE;
           V_TEMP_ROW.SUB_SEGMENT_CODE                        := rec.SUB_SEGMENT_CODE;
           V_TEMP_ROW.FILLER                                  := rec.FILLER;
           V_TEMP_ROW.SALES_TAX_COLL_AMOUNT_SIGN              := rec.SALES_TAX_COLL_AMOUNT_SIGN;
           V_TEMP_ROW.SALES_TAX_COLL_AMOUNT                   := rec.SALES_TAX_COLL_AMOUNT;
           V_TEMP_ROW.SALES_TAX_INDICATOR                     := rec.SALES_TAX_INDICATOR;
           V_TEMP_ROW.SALES_TAX_RATE_SIGN                     := rec.SALES_TAX_RATE_SIGN;
           V_TEMP_ROW.SALES_TAX_RATE                          := rec.SALES_TAX_RATE;
           V_TEMP_ROW.SALES_TAX_RATE                          := CASE V_TEMP_ROW.SALES_TAX_RATE WHEN NULL THEN '00000' ELSE V_TEMP_ROW.SALES_TAX_RATE END;
           V_TEMP_ROW.SALES_TAX_CODE                          := rec.SALES_TAX_CODE;
           V_TEMP_ROW.RUNCYCLE                                := rec.RUNCYCLE;
           V_TEMP_ROW.LOAD_DATE                               := SYSDATE;

           INSERT INTO DLY_POS_CSTMR_SALES_TAX VALUES V_TEMP_ROW;

           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POS_CSTMR_SLS_TAX',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           'TermNbr: '||NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           'TranNbr: '||NVL(rec.TRANSACTION_NUMBER,''));
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POS_CSTMR_SLS_TAX',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_POS_CSTMR_SLS_TAX;

PROCEDURE LOAD_POS_CSTMR_BNK_CRD(
/****************************************************************************
This procedure is used to load the POS store drafts  table
"DLY_POS_CSTMR_BANK_CARD" with data extracted from new interface tables
created : 06/02/2017 nxk927 CCN Project....
changed : 09/27/2017 nxk927 CCN Project....
          Load date field will be stored with the time stamp and
          using the last batch run date to get the desired data
*****************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)
AS

CURSOR POS_SD_CUR IS
    SELECT CH.TRANGUID,
           CH.COST_CENTER_CODE,
           CH.TERMINAL_NUMBER,
           CH.TRANSACTION_NUMBER,
           'O' SORT_FORCE,
           'O' SEGMENT_CODE,
           'O' SUB_SEGMENT_CODE,
           NULL as FILLER,
           CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(TRIM(REPLACE(CBC.BC_BIN, '-', '')), '0', '16') BANK_CARD_ACCOUNT_NUMBER,
           SUBSTR(CBC.BC_AUTH_NO,1,9) BANK_AUTH,
           (CASE WHEN CBC.BC_AMT < 0 THEN '-' ELSE NULL END) BANK_AMOUNT_SIGN,
           CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(CBC.BC_AMT, '-', ''), '0', '9', '2')BANK_AMOUNT,
           'O' BANK_TYPE,
           CH.RUNCYCLE
      FROM DLY_POS_CUSTOMER CH,
           PNP_CCN_BANK_CARDS CBC
    WHERE CH.TRANGUID = CBC.TRAN_GUID
      AND CH.RUNCYCLE = IN_RUN_CYCLE
      AND CH.RUNCYCLE = CBC.RLS_RUN_CYCLE;

      V_COUNT     NUMBER := 0;
      V_TCOUNT    NUMBER := 0;
      V_TEMP_ROW  DLY_POS_CSTMR_BANK_CARD%ROWTYPE;

BEGIN
  FOR REC IN POS_SD_CUR
     LOOP
        BEGIN
           V_TEMP_ROW.TRANGUID                                := rec.TRANGUID;
           V_TEMP_ROW.COST_CENTER_CODE                        := rec.COST_CENTER_CODE;
           V_TEMP_ROW.TERMINAL_NUMBER                         := rec.TERMINAL_NUMBER;
           V_TEMP_ROW.TRANSACTION_NUMBER                      := rec.TRANSACTION_NUMBER;
           V_TEMP_ROW.SORT_FORCE                              := rec.SORT_FORCE;
           V_TEMP_ROW.SEGMENT_CODE                            := rec.SEGMENT_CODE;
           V_TEMP_ROW.SUB_SEGMENT_CODE                        := rec.SUB_SEGMENT_CODE;
           V_TEMP_ROW.FILLER                                  := rec.FILLER;
           V_TEMP_ROW.BANK_CARD_ACCOUNT_NUMBER                := rec.BANK_CARD_ACCOUNT_NUMBER;
           V_TEMP_ROW.BANK_CARD_ACCOUNT_NUMBER                := CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(V_TEMP_ROW.BANK_CARD_ACCOUNT_NUMBER, '0', '16');
           V_TEMP_ROW.BANK_AUTH                               := rec.BANK_AUTH;
           V_TEMP_ROW.BANK_AMOUNT_SIGN                        := rec.BANK_AMOUNT_SIGN;
           V_TEMP_ROW.BANK_AMOUNT                             := rec.BANK_AMOUNT;
           V_TEMP_ROW.BANK_TYPE                               := rec.BANK_TYPE;
           V_TEMP_ROW.RUNCYCLE                                := rec.RUNCYCLE;
           V_TEMP_ROW.LOAD_DATE                               := SYSDATE;

           INSERT INTO DLY_POS_CSTMR_BANK_CARD VALUES V_TEMP_ROW;

           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POS_CSTMR_BNK_CRD',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           'TermNbr: '||NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           'TranNbr: '||NVL(rec.TRANSACTION_NUMBER,''));
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POS_CSTMR_BNK_CRD',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_POS_CSTMR_BNK_CRD;

PROCEDURE LOAD_POS_CSTMR_FORM_OF_PAY(
/****************************************************************************
This procedure is used to load the POS store drafts table
"DLY_POS_CCN_ACCUMS" with data extracted from new interface tables
created : 06/02/2017 nxk927 CCN Project....
changed : 09/27/2017 nxk927 CCN Project....
          Load date field will be stored with the time stamp and
          using the last batch run date to get the desired data
*****************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)
AS

CURSOR POS_SD_CUR IS
    SELECT *
      FROM DLY_POS_CCN_ACCUMS
     WHERE ((TRANID IN ('11', '13','22','41', '82', '91') and SUBSTR(ACCUM_ID,1,1) <> '7')
           OR 
           TRANID IN ('10', '19','31'))
       AND ACCUM_ID <> '92'
     ORDER BY TRAN_GUID,DECODE(ACCUM_ID,'95', '70', ACCUM_ID);

      V_COUNT     NUMBER := 0;
      V_TCOUNT    NUMBER := 0;
      V_TEMP_ROW  DLY_POS_CSTMR_FORM_OF_PAY%ROWTYPE;
      V_PREV_REC  VARCHAR2(35):= 'XXXXXXXXXXX'; 
      V_FLAG      VARCHAR2(35):= 'N'; 


BEGIN
    V_FLAG := 'N';
FOR REC IN POS_SD_CUR
     LOOP
        BEGIN
           V_TEMP_ROW.TRANGUID                                := rec.TRAN_GUID;
           V_TEMP_ROW.COST_CENTER_CODE                        := rec. COST_CENTER_CODE;
           V_TEMP_ROW.TERMINAL_NUMBER                         := rec.TERMINAL_NUMBER;
           V_TEMP_ROW.TRANSACTION_NUMBER                      := rec.TRANSACTION_NUMBER;
           V_TEMP_ROW.SORT_FORCE                              := rec.SORT_FORCE;
           V_TEMP_ROW.SEGMENT_CODE                            := rec.SEGMENT_CODE;
           V_TEMP_ROW.SUB_SEGMENT_CODE                        := rec.SUB_SEGMENT_CODE;
           V_TEMP_ROW.FILLER                                  := rec.FILLER;
           V_TEMP_ROW.PAY_DISC_CODE                           := rec.PAY_DISC_CODE;
           V_TEMP_ROW.TRANSACTION_TOTAL_AMOUNT_SIGN           := rec.TRANSACTION_TOTAL_AMOUNT_SIGN;
           V_TEMP_ROW.TRANSACTION_TOTAL_AMOUNT                := rec.TRANSACTION_TOTAL_AMOUNT;
           V_TEMP_ROW.POS_LINE_CNT                            := rec.POS_LINE_CNT;
           V_TEMP_ROW.PAY_AMOUNT_SIGN                         := rec.PAY_AMOUNT_SIGN;
           V_TEMP_ROW.PAY_AMOUNT                              := rec.PAY_AMOUNT;
           V_TEMP_ROW.POS_DISC_SIGN                           := rec.POS_DISC_SIGN;
           V_TEMP_ROW.POS_DISC                                := rec.POS_DISC;
           V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN                  := rec.SALES_DISC_AMOUNT_SIGN;
           V_TEMP_ROW.SALES_DISC_AMOUNT                       := rec.SALES_DISC_AMOUNT;
           BEGIN
               SELECT PAY_AMOUNT_SIGN,
                      PAY_AMOUNT
                 INTO V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN,
                      V_TEMP_ROW.SALES_DISC_AMOUNT
                 FROM DLY_POS_CCN_ACCUMS
                WHERE TRAN_GUID = rec.TRAN_GUID
                  AND ACCUM_ID  = '92';

          EXCEPTION
              WHEN OTHERS THEN
                  V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN :=NULL;
                  V_TEMP_ROW.SALES_DISC_AMOUNT  :=  '0000000';
           END; 

           IF REC.TRANID in ('10','19', '31') THEN
              IF REC.ACCUM_ID = '95' THEN
                 V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN := V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN;
                 V_TEMP_ROW.SALES_DISC_AMOUNT      := V_TEMP_ROW.SALES_DISC_AMOUNT;
                 V_PREV_REC := REC.TRAN_GUID;
              ELSIF V_PREV_REC <> REC.TRAN_GUID AND REC.ACCUM_ID = '93' THEN
                 V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN := V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN;
                 V_TEMP_ROW.SALES_DISC_AMOUNT      := V_TEMP_ROW.SALES_DISC_AMOUNT;
              ELSE
                 V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN := NULL;
                 V_TEMP_ROW.SALES_DISC_AMOUNT      := '0000000';
              END IF;
           ELSIF REC.TRANID in ('41') THEN
              IF REC.ACCUM_ID = '94' THEN
                 V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN := V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN;
                 V_TEMP_ROW.SALES_DISC_AMOUNT      := V_TEMP_ROW.SALES_DISC_AMOUNT;
              ELSE
                V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN := NULL;
                V_TEMP_ROW.SALES_DISC_AMOUNT      := '0000000';   
              END IF;
           ELSE
             IF SUBSTR(REC.ACCUM_ID,1,1) = '8' THEN
                 V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN := V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN;
                 V_TEMP_ROW.SALES_DISC_AMOUNT      := V_TEMP_ROW.SALES_DISC_AMOUNT;
             ELSE
                V_TEMP_ROW.SALES_DISC_AMOUNT_SIGN := NULL;
                V_TEMP_ROW.SALES_DISC_AMOUNT      := '0000000';
             END IF;
           END IF;
           IF REC.ACCUM_ID IN ('71','72','73','74','75','76') THEN
              IF NVL(V_TEMP_ROW.PAY_AMOUNT_SIGN,'+') = '+' THEN
                 V_TEMP_ROW.PAY_AMOUNT_SIGN := '-';
              ELSE V_TEMP_ROW.PAY_AMOUNT_SIGN := '+';
              V_FLAG := 'Y';
              END IF;
           END IF;
           V_TEMP_ROW.RUNCYCLE                                := rec.RLS_RUN_CYCLE;
           V_TEMP_ROW.LOAD_DATE                               := SYSDATE;

           IF REC.ACCUM_ID IN ('81','82','83','84','85','86')  THEN
              IF V_FLAG <> 'Y' THEN 
                 INSERT INTO DLY_POS_CSTMR_FORM_OF_PAY VALUES V_TEMP_ROW;
              END IF;
           ELSE
              INSERT INTO DLY_POS_CSTMR_FORM_OF_PAY VALUES V_TEMP_ROW;
           END IF;

           V_COUNT   := V_COUNT + 1;
           IF V_COUNT > 100 THEN
               COMMIT;
               V_COUNT := 0;
           END IF;
           V_TCOUNT := V_TCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
               ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_POS_CSTMR_FORM_OF_PAY',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           'TermNbr: '||NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           'TranNbr: '||NVL(rec.TRANSACTION_NUMBER,''));
        END;
     END LOOP;
COMMIT;
DBMS_OUTPUT.PUT_LINE('Total rows inserted ' || V_TCOUNT);

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POS_CSTMR_FORM_OF_PAY',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_POS_CSTMR_FORM_OF_PAY;

PROCEDURE LOAD_POS_CCN_ACCUMS(
/****************************************************************************
This procedure is used to load the POS store drafts table
"DLY_POS_CCN_ACCUMS" with data extracted from new interface tables
created : 03/02/2017 nxk927 CCN Project....
changed : 09/27/2017 nxk927 CCN Project....
          Load date field will be stored with the time stamp and
          using the last batch run date to get the desired data
Changed : 07/02/2019 sxs484 CCN project
          CCNCC-18 Updated reference of 4 chars PNP_CCN_HEADERS.STORE_NO           
          to 6 chars PNP_CCN_HEADERS.STORECCN.          
*****************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)
AS

CURSOR POS_SD_CUR IS
    SELECT ACC.TRAN_GUID,
           CH.STORECCN COST_CENTER_CODE,
           CH.TERMNBR TERMINAL_NUMBER,
           LPAD(CH.TRANNBR,5,'0') TRANSACTION_NUMBER,  --CHANGED BY MXK766
           'O' SORT_FORCE,
           'O' SEGMENT_CODE,
           'O' SUB_SEGMENT_CODE,
           NULL AS FILLER,
           '0' PAY_DISC_CODE,
           NULL TRANSACTION_TOTAL_AMOUNT_SIGN,
           CH.TRAN_TOTAL TRANSACTION_TOTAL_AMOUNT,
           '0' POS_LINE_CNT,
           (CASE WHEN ACC.AMT < 0 THEN '-' ELSE NULL END) PAY_AMOUNT_SIGN,
           LPAD(REPLACE(ACC.AMT*100,'-',''),'7',0) PAY_AMOUNT,
           NULL POS_DISC_SIGN,
           '0000000' POS_DISC,
           NULL SALES_DISC_AMOUNT_SIGN,
           '0000000' SALES_DISC_AMOUNT,
           ACC.RLS_RUN_CYCLE,
           ACC.ACCUM_ID,
           CH.TRANID,
           ACC.SEQNBR
      FROM PNP_CCN_ACCUMS ACC, 
           PNP_CCN_HEADERS CH
     WHERE CH.TRANID IN ('10', '11', '13', '19', '22', '31', '41', '82', '91') 
       AND ACC.TRAN_GUID      = CH.TRAN_GUID
       AND ACC.RLS_RUN_CYCLE  = CH.RLS_RUN_CYCLE
       AND CH.RLS_RUN_CYCLE   = IN_RUN_CYCLE
       AND EXISTS (SELECT 1
                      FROM PNP_CCN_SALES_LINES
                     WHERE SALESNBR = '000009126'
                       AND RLS_RUN_CYCLE = CH.RLS_RUN_CYCLE
                       AND TRAN_GUID =     CH.TRAN_GUID)
      ORDER BY CH.TRAN_GUID, ACC.ACCUM_ID desc;

V_PREV_REC VARCHAR2(35):= 'XXXXXXXXXXX'; 

BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DLY_POS_CCN_ACCUMS';

   FOR REC IN POS_SD_CUR LOOP
   IF REC.TRANID in ('10','19', '31') THEN
      IF REC.ACCUM_ID = '95' THEN
         REC.TRANSACTION_TOTAL_AMOUNT_SIGN := (CASE WHEN REC.TRANSACTION_TOTAL_AMOUNT < 0 THEN '-' ELSE NULL END);
         REC.TRANSACTION_TOTAL_AMOUNT      := LPAD(CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(REC.TRANSACTION_TOTAL_AMOUNT, '-', ''), '0', '7', '2'),7,'0');
         V_PREV_REC := REC.TRAN_GUID;
       ELSIF V_PREV_REC <> REC.TRAN_GUID AND REC.ACCUM_ID = '93' THEN
          REC.TRANSACTION_TOTAL_AMOUNT_SIGN := (CASE WHEN REC.TRANSACTION_TOTAL_AMOUNT < 0 THEN '-' ELSE NULL END);
          REC.TRANSACTION_TOTAL_AMOUNT      := LPAD(CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(REC.TRANSACTION_TOTAL_AMOUNT, '-', ''), '0', '7', '2'),7,'0');
       ELSE
          REC.TRANSACTION_TOTAL_AMOUNT_SIGN := NULL;
          REC.TRANSACTION_TOTAL_AMOUNT      :=  '0000000';
       END IF;
    ELSE
         IF SUBSTR(REC.ACCUM_ID,1,1) = '8' THEN
             REC.TRANSACTION_TOTAL_AMOUNT_SIGN := (CASE WHEN REC.TRANSACTION_TOTAL_AMOUNT < 0 THEN '-' ELSE NULL END);
             REC.TRANSACTION_TOTAL_AMOUNT      := LPAD(CCN_COMMON_TOOLS.FORMAT_INPUT_FOR_FILE(REPLACE(REC.TRANSACTION_TOTAL_AMOUNT, '-', ''), '0', '7', '2'),7,'0');
          ELSE
             REC.TRANSACTION_TOTAL_AMOUNT_SIGN := NULL;
             REC.TRANSACTION_TOTAL_AMOUNT      := '0000000';
          END IF;
    END IF;

    INSERT INTO DLY_POS_CCN_ACCUMS VALUES REC;


   END LOOP;
COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POS_CCN_ACCUMS',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_POS_CCN_ACCUMS;

FUNCTION GET_LOAD_RUNCYCLE
/******************************************************************************
  This function will get the runcycle for the days load

Created : 09/28/2017 nxk927 CCN Project....
Changed :
*******************************************************************************/
RETURN VARCHAR2
IS
    V_RETURN_VALUE      VARCHAR2(10);
BEGIN
    SELECT RLS_RUN_CYCLE
      INTO V_RETURN_VALUE
      FROM (SELECT CH.*
              FROM PNP_CCN_LOAD_STATUS CH
              WHERE CH.START_TS  > (SELECT MAX(START_TS)
                                      FROM POS_CCN_LOAD_STATUS)
                AND STATUS_CODE = 'C'
              ORDER BY CH.START_TS)
     WHERE ROWNUM < 2;

    RETURN V_RETURN_VALUE;
EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;
END GET_LOAD_RUNCYCLE;

PROCEDURE LOAD_POS_CCN_LOAD_STATUS(
/****************************************************************************
This procedure is used to load the POS store drafts table
"POS_CCN_LOAD_STATUS" with data extracted from new interface tables
created : 03/02/2017 nxk927 CCN Project....
changed : 09/26/2017 nxk927 CCN Project....
          changed the condition to consider date while loading the runcyle information
          only considering 1 runcycle per run
*****************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)
AS

CURSOR POS_SD_CUR IS
    SELECT CH.*,
           SYSDATE AS LOAD_DATE
      FROM PNP_CCN_LOAD_STATUS CH
     WHERE RLS_RUN_CYCLE = IN_RUN_CYCLE;

BEGIN

FOR REC IN POS_SD_CUR LOOP
        INSERT INTO POS_CCN_LOAD_STATUS VALUES REC;
END LOOP;
COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_POS_CCN_LOAD_STATUS',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_POS_CCN_LOAD_STATUS;


PROCEDURE LOAD_PNP_CCN_DISC(
/****************************************************************************
This procedure is used to load the POS store drafts table
"DLY_POS_CCN_DISC" with data extracted from new interface tables
created : 03/02/2017 nxk927 CCN Project....
changed : 09/27/2017 nxk927 CCN Project....
          Load date field will be stored with the time stamp and
          using the last batch run date to get the desired data
*****************************************************************************/
IN_RUN_CYCLE     IN VARCHAR2)
AS

CURSOR POS_SD_CUR IS
    SELECT CD.*,
           SYSDATE LOAD_DATE
      FROM PNP_CCN_DISC CD
     WHERE RLS_RUN_CYCLE = IN_RUN_CYCLE;

BEGIN

FOR REC IN POS_SD_CUR LOOP
        INSERT INTO DLY_POS_CCN_DISC VALUES REC;
END LOOP;
COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_PNP_CCN_DISC',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');

END LOAD_PNP_CCN_DISC;

PROCEDURE POS_DAILY_LOAD_SP
/************************************************************************
POS_DAILY_LOAD_SP

This Procedure is a wrapper for the daily Load of the store drafts tables
* Loads all the POS store drafts tables

created : 06/00/2017 nxk927 CCN Project....
changed : 09/28/2017 nxk927 CCN Project....
          Removed the in_date parameter
************************************************************************/
AS
    V_CONTEXT    VARCHAR2(200);
    V_START_TIME NUMBER;
    V_RUNCYCLE   VARCHAR2(10);
BEGIN
      V_RUNCYCLE := GET_LOAD_RUNCYCLE();

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POS_CCN_LOAD_STATUS Table ';
      LOAD_POS_CCN_LOAD_STATUS(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('POS_CCN_LOAD_STATUS loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POS_CCN_ACCUMS Table ';
      LOAD_POS_CCN_ACCUMS(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('POS_CCN_ACCUMS loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load LOAD_PNP_CCN_DISC Table ';
      LOAD_PNP_CCN_DISC(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('PNP_CCN_DISC loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POS_ISSUE_CHG_DATA Table ';
      LOAD_POS_ISSUE_CHG_DATA(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('POS_ISSUE_CHG_DATA loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POS_INSTLR_LN_ID_DTL Tables ';
      LOAD_POS_INSTLR_LN_ID_DTL(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('POS_INSTLR_LN_ITEM_DATA_TMP loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POS_DISBRSMT_LINE_ITEM Tables ';
      LOAD_POS_DSBRSMT_LID(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('POS_DISBRSMT_LINE_ITEM loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load LOAD_POS_CSTMR_LINE_ITEM Tables ';
      LOAD_POS_CSTMR_LINE_ITEM(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('POS_CUST_LINE_ITEM_DATA loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load DLY_POS_CSTMR Table ';
      LOAD_DLY_POS_CSTMR(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('POS_CSTMR loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load DLY_POS_CSTMR_DTLS Table ';
      LOAD_DLY_POS_CSTMR_DTLS(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('POS_CSTMR_DTLS loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POS_CSTMR_SLS_TAX Table ';
      LOAD_POS_CSTMR_SLS_TAX(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('POS_CSTMR_SLS_TAX loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POS_CSTMR_BNK_CRD Table ';
      LOAD_POS_CSTMR_BNK_CRD(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('POS_CSTMR_BNK_CRD loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

      V_START_TIME := DBMS_UTILITY.GET_TIME;
      V_CONTEXT := 'Load POS_CSTMR_FORM_OF_PAY Table ';
      LOAD_POS_CSTMR_FORM_OF_PAY(V_RUNCYCLE);
      DBMS_OUTPUT.PUT_LINE('POS_CSTMR_FOP loaded in : '|| (DBMS_UTILITY.GET_TIME - V_START_TIME)/100 || ' Seconds');

EXCEPTION
    WHEN OTHERS THEN
         ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'POS_DAILY_LOAD_SP',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
END POS_DAILY_LOAD_SP;

PROCEDURE POS_SD_DAILY_LOAD_SP
/*******************************************************************************
POS_SD_DAILY_LOAD_SP

This Procedure is a wrapper for the Daily Load of the POSXML store drafts TEMP
tables

created : 06/10/2017 nxk927 CCN Project....
changed : 09/28/2017 nxk927 CCN Project....
          Removed the in_date parameter
        : 03/27/2019 ASP-1207 mxs216 CCN Project....
          Updated varibale declaration with referencing CCN_BATCH_PKG.BATCH_JOB_TYPE
*******************************************************************************/
AS
    V_CONTEXT        VARCHAR2(200);
    V_START_TIME     NUMBER;
    V_START_TIME_SD  DATE := SYSDATE;
    V_CLOB           CLOB;
--    V_BATCH_NUMBER      BATCH_JOB.BATCH_JOB_NUMBER%TYPE;
--    V_TRANS_STATUS      BATCH_JOB.TRANS_STATUS%TYPE := 'SUCCESSFUL';
    V_BATCH_NUMBER   CCN_BATCH_PKG.BATCH_JOB_TYPE.BATCH_JOB_NUMBER%TYPE;
    V_TRANS_STATUS   CCN_BATCH_PKG.BATCH_JOB_TYPE.TRANS_STATUS%TYPE := 'SUCCESSFUL';
BEGIN
    CCN_BATCH_PKG.INSERT_BATCH_JOB('POS_SD_DLY_LOAD', V_BATCH_NUMBER);
    CCN_BATCH_PKG.LOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      POS_DAILY_LOAD_SP();
    END;
    CCN_BATCH_PKG.UPDATE_BATCH_JOB('POS_SD_DLY_LOAD', V_BATCH_NUMBER, V_TRANS_STATUS);
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP(); -- PRAGMA AUTONOMOUS_TRANSACTION;
EXCEPTION
    WHEN OTHERS THEN
         ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'POS_SD_DAILY_LOAD_SP',
                                     SQLERRM,
                                    '000000',
                                    '0000000000');
END POS_SD_DAILY_LOAD_SP;

END POS_SD_DAILY_LOAD;

/
