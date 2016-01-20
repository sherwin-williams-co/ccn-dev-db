/*
Below script is to rerun the 1099 account payable reports on demand (one time)

Created  : jxc517 CCN Project Team....
*/

/*
SELECT COUNT(*) FROM STORE_DRAFTS WHERE PICKED_BY_1099_ON_DATE = '01-DEC-2015';
SELECT COUNT(*) FROM STORE_DRAFTS WHERE FNCL_SRVCS_SENT_DATE = '01-JAN-2016';
EXEC SD_FILE_BUILD_ODR_PKG.PROCESS('01-DEC-2015');
SELECT COUNT(*) FROM STORE_DRAFTS_ODR WHERE PICKED_BY_1099_ON_DATE = '01-DEC-2015';
SELECT COUNT(*) FROM STORE_DRAFTS_ODR WHERE FNCL_SRVCS_SENT_DATE = '01-JAN-2016';
*/
CREATE TABLE STORE_DRAFTS_ODR AS SELECT * FROM STORE_DRAFTS WHERE 1 = 2;

DECLARE

IN_DATE DATE := '01-DEC-2015';

PROCEDURE LOAD_VENDOR_INFORMATION
IS
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE VENDOR_INFO';
    INSERT INTO VENDOR_INFO
        SELECT REPLACE(SUPPLIER_NUM_1099,'-') TAX_ID,
               SITE_ATTRIBUTE3 VENDOR_NO,
               SUPPLIER_NAME VENDOR_NAME,
               SITE_LAST_UPDATE_DATE
          FROM SWC_AP_SUPPLIER_INFO_V
         WHERE SUPPLIER_VENDOR_TYPE_LOOKUP IN ('INSTALLER','SUBCONTRACTOR')
           AND SITE_INACTIVE_DATE IS NULL
           AND SUPPLIER_END_DATE_ACTIVE IS NULL
           AND SITE_ATTRIBUTE3 IS NOT NULL
           AND SUPPLIER_NUM_1099 IS NOT NULL;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END LOAD_VENDOR_INFORMATION;

PROCEDURE UPDATE_PICKED_BY_1099_ON_DATE(
IN_CHECK_SERIAL_NUMBER  IN     VARCHAR2,
IN_DATE                 IN     DATE)
IS
BEGIN
    UPDATE STORE_DRAFTS_ODR
       SET PICKED_BY_1099_ON_DATE = IN_DATE
     WHERE CHECK_SERIAL_NUMBER = IN_CHECK_SERIAL_NUMBER
       AND PICKED_BY_1099_ON_DATE IS NULL;
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END UPDATE_PICKED_BY_1099_ON_DATE;

PROCEDURE UPDATE_FNCL_SRVCS_SENT_DATE(
/*****************************************************************************
This procedure will update FNCL_SRVCS_SENT_DATE in all tables  

created : 08/28/2015 jxc517 CCN Project....
changed : 
*****************************************************************************/
IN_CHECK_SERIAL_NUMBER  IN     VARCHAR2,
IN_DATE                 IN     DATE)
IS
BEGIN
    UPDATE STORE_DRAFTS_ODR
       SET FNCL_SRVCS_SENT_DATE = IN_DATE
     WHERE CHECK_SERIAL_NUMBER = IN_CHECK_SERIAL_NUMBER
       AND FNCL_SRVCS_SENT_DATE IS NULL;
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END UPDATE_FNCL_SRVCS_SENT_DATE;

PROCEDURE UPDT_1099_FILE(IN_DATE IN DATE,
IN_MID_MNTHLY_IND IN VARCHAR2 DEFAULT 'N')
IS
  
    CURSOR cur IS
        SELECT NULL AS FILE_NUMBER
               ,SUBSTR(COST_CENTER_CODE,3,4) AS STORE_NUMBER
               ,DRAFT_NUMBER AS CHECK_NUMBER
               ,sd_common_tools.GET_HEX_VALUE_FOR_TRNSCTN_TYP('10',NVL(DECODE(AMOUNT_CHANGE_DATE, NULL,ORIGINAL_NET_AMOUNT,NET_AMOUNT), 0) *100) AS CHECK_AMOUNT
               ,TO_CHAR(TRANSACTION_DATE,'MMDDYY') AS CHECK_DATE
               ,NULL AS JV_NUMBER
               ,NULL AS FILLER
               ,'00' AS TRANSACTION_CODE
               ,ccn_common_tools.DecryptSQL((SELECT TAXID FROM CUSTOMER_TAXID_VW WHERE CUSTNUM = CUSTOMER_ACCOUNT_NUMBER)) AS TAX_ID
               ,CHECK_SERIAL_NUMBER
               ,PICKED_BY_1099_ON_DATE
          FROM STORE_DRAFTS_ODR
         WHERE (POS_TRANSACTION_CODE = '13' OR (POS_TRANSACTION_CODE = '91' AND REASON_CODE = '04'))
           AND TO_CHAR(ISSUE_DATE,'YYYYMM') = TO_CHAR(IN_DATE,'YYYYMM')
           AND LOAD_DATE <= DECODE(IN_MID_MNTHLY_IND, 'N', LAST_DAY(IN_DATE) + 1, LAST_DAY(IN_DATE) + 15)
           AND (VOID_DATE IS NULL OR VOID_DATE > DECODE(IN_MID_MNTHLY_IND, 'N', LAST_DAY(IN_DATE) + 1, LAST_DAY(IN_DATE) + 15))
           AND (STOP_PAY_DATE IS NULL OR STOP_PAY_DATE > DECODE(IN_MID_MNTHLY_IND, 'N', LAST_DAY(IN_DATE) + 1, LAST_DAY(IN_DATE) + 15))
         ORDER BY SUBSTR(COST_CENTER_CODE,3,4), CHECK_NUMBER;

    V_DATE          DATE;
BEGIN
    IF IN_MID_MNTHLY_IND = 'Y' THEN
        V_DATE := TRUNC(IN_DATE,'month') + 14;
    ELSE
        V_DATE := TRUNC(IN_DATE,'month');
    END IF;
    FOR rec IN cur LOOP
        IF rec.PICKED_BY_1099_ON_DATE IS NULL THEN --No need to perform update if that value is already updated
            UPDATE_PICKED_BY_1099_ON_DATE(rec.CHECK_SERIAL_NUMBER, V_DATE);
        END IF;
    END LOOP;
    COMMIT;
    LOAD_VENDOR_INFORMATION();
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END UPDT_1099_FILE;

PROCEDURE UPDT_1099_FILE_FOR_FSS(IN_DATE           IN DATE)
IS
    CURSOR cur IS
        SELECT *
          FROM (SELECT COST_CENTER_CODE,
                       CHECK_SERIAL_NUMBER,
                       NET_AMOUNT,
                       ISSUE_DATE,
                       DRAFT_NUMBER,
                       SD_FILE_BUILD_PKG.GET_CUSTOMER_VENDOR_NO(CUSTOMER_ACCOUNT_NUMBER) VENDOR_NO
                  FROM STORE_DRAFTS_ODR
                 WHERE FNCL_SRVCS_SENT_DATE IS NULL
                   AND PICKED_BY_1099_ON_DATE IS NOT NULL
                )
          WHERE VENDOR_NO IS NOT NULL
          ORDER BY SUBSTR(COST_CENTER_CODE, 3), VENDOR_NO, DRAFT_NUMBER;
BEGIN
    FOR rec IN cur LOOP
        UPDATE_FNCL_SRVCS_SENT_DATE(rec.CHECK_SERIAL_NUMBER, TRUNC(SYSDATE)); --ADD_MONTHS(IN_DATE, 1));
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END UPDT_1099_FILE_FOR_FSS;

PROCEDURE SD_1099_NO_MTCHD_VENDOR_RPRT(IN_DATE      IN     DATE)
IS 
    OUT_TYPE_REF_CUR            SD_TABLE_IU_PKG.REF_CURSOR;
    V_CLOB                      CLOB;
    V_STORE_NUMBER              VARCHAR2(50);
    V_DRAFT_NUMBER              VARCHAR2(50);
    V_AMOUNT                    VARCHAR2(50);
    V_TAX_ID                    VARCHAR2(50);
    V_TRANSACTION_DATE          DATE;
    V_CUSTOMER_ACCOUNT_NUMBER   VARCHAR2(500);
    V_CUSTOMER_ACCOUNT_NAME     VARCHAR2(500);
BEGIN
    V_CLOB := 'STORE_NUMBER,DRAFT_NUMBER,TRANSACTION_DATE,AMOUNT,TAX_ID,CUSTOMER_ACCOUNT_NUMBER,CUSTOMER_ACCOUNT_NAME,VENDOR_INFO_FLAG' || CHR(10) ;
    OPEN OUT_TYPE_REF_CUR FOR
        SELECT SUBSTR(SD.COST_CENTER_CODE, 3) STORE_NUMBER,
               SD.DRAFT_NUMBER,
               SD.TRANSACTION_DATE,
               NVL(DECODE(SD.AMOUNT_CHANGE_DATE, NULL,SD.ORIGINAL_NET_AMOUNT,SD.NET_AMOUNT), 0) AMOUNT,
               SD.TAX_ID,
               SD.CUSTOMER_ACCOUNT_NUMBER,
               SD.CUSTOMER_ACCOUNT_NAME
          FROM (SELECT S.COST_CENTER_CODE,
                       S.DRAFT_NUMBER,
                       S.TRANSACTION_DATE,
                       S.AMOUNT_CHANGE_DATE,
                       S.ORIGINAL_NET_AMOUNT,
                       S.NET_AMOUNT,
                       ccn_common_tools.DecryptSQL((SELECT TAXID
                                                      FROM CUSTOMER_TAXID_VW
                                                     WHERE CUSTNUM = CUSTOMER_ACCOUNT_NUMBER)) TAX_ID,
                       CUSTOMER_ACCOUNT_NUMBER,
                       (SELECT CUSTNAME
                          FROM CUSTOMER_TAXID_VW
                         WHERE CUSTNUM = CUSTOMER_ACCOUNT_NUMBER) CUSTOMER_ACCOUNT_NAME
                  FROM STORE_DRAFTS_ODR S,
                       COST_CENTER CC
                 WHERE FNCL_SRVCS_SENT_DATE IS NULL
                   AND PICKED_BY_1099_ON_DATE IS NOT NULL
                   AND CC.COST_CENTER_CODE = S.COST_CENTER_CODE
                   AND CC.STATEMENT_TYPE NOT IN ('AC','DC','GC','CN')) SD
          ORDER BY 1,2;
    LOOP
        FETCH OUT_TYPE_REF_CUR INTO V_STORE_NUMBER,
                                    V_DRAFT_NUMBER,
                                    V_TRANSACTION_DATE,
                                    V_AMOUNT, V_TAX_ID,
                                    V_CUSTOMER_ACCOUNT_NUMBER,
                                    V_CUSTOMER_ACCOUNT_NAME;
        EXIT WHEN OUT_TYPE_REF_CUR%NOTFOUND;
        DBMS_LOB.APPEND(V_CLOB, V_STORE_NUMBER || ',' || 
                                V_DRAFT_NUMBER || ',' || 
                                V_TRANSACTION_DATE || ',' || 
                                V_AMOUNT || ',' || 
                                V_TAX_ID || ',' || 
                                V_CUSTOMER_ACCOUNT_NUMBER || ',' || 
                                REPLACE(V_CUSTOMER_ACCOUNT_NAME, ',', '') || ',' ||
                                'N' ||
                                CHR(10));
    END LOOP;
    CLOSE OUT_TYPE_REF_CUR;
    IF V_CLOB <> EMPTY_CLOB() THEN
        MAIL_PKG.SEND_MAIL('SD_1099_NO_MTCHD_VENDOR_RPRT', NULL, NULL, V_CLOB);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END SD_1099_NO_MTCHD_VENDOR_RPRT;

PROCEDURE SD_1099_MTCHD_PRCSNG_RPRT(IN_DATE      IN     DATE)
IS
    OUT_TYPE_REF_CUR            SD_TABLE_IU_PKG.REF_CURSOR;
    V_CLOB                      CLOB;
    V_STORE_NUMBER              VARCHAR2(50);
    V_DRAFT_NUMBER              VARCHAR2(50);
    V_AMOUNT                    VARCHAR2(50);
    V_VENDOR_NO                 VARCHAR2(50);
    V_VENDOR_NAME               VARCHAR2(500);
    V_TAX_ID                    VARCHAR2(50);
    V_TRANSACTION_DATE          DATE;
    V_CUSTOMER_ACCOUNT_NUMBER   VARCHAR2(500);
    V_CUSTOMER_ACCOUNT_NAME     VARCHAR2(500);
BEGIN
    V_CLOB := 'STORE_NUMBER,DRAFT_NUMBER,TRANSACTION_DATE,AMOUNT,VENDOR_NO,VENDOR_NAME,TAX_ID,CUSTOMER_ACCOUNT_NUMBER,CUSTOMER_ACCOUNT_NAME,VENDOR_INFO_FLAG' || CHR(10) ;
    OPEN OUT_TYPE_REF_CUR FOR
        SELECT SUBSTR(SD.COST_CENTER_CODE, 3) STORE_NUMBER,
               SD.DRAFT_NUMBER,
               SD.TRANSACTION_DATE,
               NVL(DECODE(SD.AMOUNT_CHANGE_DATE, NULL,SD.ORIGINAL_NET_AMOUNT,SD.NET_AMOUNT), 0) AMOUNT,
               (SELECT VENDOR_NO FROM VENDOR_INFO WHERE TAX_ID = SD.TAX_ID AND ROWNUM < 2) VENDOR_NO,
               (SELECT VENDOR_NAME FROM VENDOR_INFO WHERE TAX_ID = SD.TAX_ID AND ROWNUM < 2) VENDOR_NAME,
               SD.TAX_ID,
               SD.CUSTOMER_ACCOUNT_NUMBER,
               SD.CUSTOMER_ACCOUNT_NAME
          FROM (SELECT S.COST_CENTER_CODE,
                       S.DRAFT_NUMBER,
                       S.TRANSACTION_DATE,
                       S.AMOUNT_CHANGE_DATE,
                       S.ORIGINAL_NET_AMOUNT,
                       S.NET_AMOUNT,
                       ccn_common_tools.DecryptSQL((SELECT TAXID
                                                      FROM CUSTOMER_TAXID_VW
                                                     WHERE CUSTNUM = CUSTOMER_ACCOUNT_NUMBER)) TAX_ID,
                       CUSTOMER_ACCOUNT_NUMBER,
                       (SELECT CUSTNAME
                          FROM CUSTOMER_TAXID_VW
                         WHERE CUSTNUM = CUSTOMER_ACCOUNT_NUMBER) CUSTOMER_ACCOUNT_NAME
                  FROM STORE_DRAFTS_ODR S,
                       COST_CENTER CC
                 WHERE TO_CHAR(FNCL_SRVCS_SENT_DATE,'MMYYYY') = TO_CHAR(IN_DATE,'MMYYYY')
                   AND CC.COST_CENTER_CODE = S.COST_CENTER_CODE
                   AND CC.STATEMENT_TYPE NOT IN ('AC','DC','GC','CN')) SD
          ORDER BY 1,2;
    LOOP
        FETCH OUT_TYPE_REF_CUR INTO V_STORE_NUMBER,
                                    V_DRAFT_NUMBER,
                                    V_TRANSACTION_DATE,
                                    V_AMOUNT,
                                    V_VENDOR_NO,
                                    V_VENDOR_NAME,
                                    V_TAX_ID,
                                    V_CUSTOMER_ACCOUNT_NUMBER,
                                    V_CUSTOMER_ACCOUNT_NAME;
        EXIT WHEN OUT_TYPE_REF_CUR%NOTFOUND;
        DBMS_LOB.APPEND(V_CLOB, V_STORE_NUMBER || ',' ||
                                V_DRAFT_NUMBER || ',' || 
                                V_TRANSACTION_DATE || ',' || 
                                V_AMOUNT || ',' || 
                                V_VENDOR_NO|| ',' || 
                                REPLACE(V_VENDOR_NAME, ',', '') || ','||
                                V_TAX_ID || ','||
                                V_CUSTOMER_ACCOUNT_NUMBER || ','||
                                REPLACE(V_CUSTOMER_ACCOUNT_NAME, ',', '') || ','||
                                'Y' ||
                                CHR(10));
    END LOOP;
    IF V_CLOB <> EMPTY_CLOB() THEN
        MAIL_PKG.SEND_MAIL('SD_1099_MTCHD_PRCSNG_RPRT', NULL, NULL, V_CLOB);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END SD_1099_MTCHD_PRCSNG_RPRT;

PROCEDURE SD_1099_NO_VNDR_ON_BNK_TP_RPRT(IN_DATE      IN     DATE)
IS
    OUT_TYPE_REF_CUR            SD_TABLE_IU_PKG.REF_CURSOR;
    V_CLOB                      CLOB;
    V_STORE_NUMBER              VARCHAR2(50);
    V_DRAFT_NUMBER              VARCHAR2(50);
    V_AMOUNT                    VARCHAR2(50);
    V_VENDOR_NO                 VARCHAR2(50);
    V_VENDOR_NAME               VARCHAR2(50);
    V_TAX_ID                    VARCHAR2(50);
    V_TRANSACTION_DATE          DATE;
    V_CUSTOMER_ACCOUNT_NUMBER   VARCHAR2(500);
    V_CUSTOMER_ACCOUNT_NAME     VARCHAR2(500);
BEGIN
    V_CLOB := 'STORE_NUMBER,DRAFT_NUMBER,TRANSACTION_DATE,AMOUNT,TAX_ID,CUSTOMER_ACCOUNT_NUMBER,CUSTOMER_ACCOUNT_NAME' || CHR(10) ;
    OPEN OUT_TYPE_REF_CUR FOR
        SELECT SUBSTR(SD.COST_CENTER_CODE, 3) STORE_NUMBER,
               SD.DRAFT_NUMBER,
               SD.TRANSACTION_DATE,
               NVL(DECODE(SD.AMOUNT_CHANGE_DATE, NULL,SD.ORIGINAL_NET_AMOUNT,SD.NET_AMOUNT), 0) AMOUNT,
               SD.TAX_ID,
               SD.CUSTOMER_ACCOUNT_NUMBER,
               SD.CUSTOMER_ACCOUNT_NAME
          FROM (SELECT S.COST_CENTER_CODE,
                       S.DRAFT_NUMBER,
                       S.TRANSACTION_DATE,
                       S.AMOUNT_CHANGE_DATE,
                       S.ORIGINAL_NET_AMOUNT,
                       S.NET_AMOUNT,
                       ccn_common_tools.DecryptSQL((SELECT TAXID
                                                      FROM CUSTOMER_TAXID_VW
                                                     WHERE CUSTNUM = CUSTOMER_ACCOUNT_NUMBER)) TAX_ID,
                       CUSTOMER_ACCOUNT_NUMBER,
                       (SELECT CUSTNAME
                          FROM CUSTOMER_TAXID_VW
                         WHERE CUSTNUM = CUSTOMER_ACCOUNT_NUMBER) CUSTOMER_ACCOUNT_NAME
                  FROM STORE_DRAFTS_ODR S,
                       COST_CENTER CC                 
                 WHERE FNCL_SRVCS_SENT_DATE IS NULL
                   AND PICKED_BY_1099_ON_DATE IS NOT NULL
                   AND CC.COST_CENTER_CODE = S.COST_CENTER_CODE
                   AND CC.STATEMENT_TYPE NOT IN ('AC','DC','GC','CN')) SD
                   --TO_CHAR(PICKED_BY_1099_ON_DATE,'MMYYYY') = TO_CHAR(IN_DATE,'MMYYYY')) SD
          WHERE SD.TAX_ID IS NULL
          ORDER BY 1,2;
    LOOP
        FETCH OUT_TYPE_REF_CUR INTO V_STORE_NUMBER,
                                    V_DRAFT_NUMBER,
                                    V_TRANSACTION_DATE,
                                    V_AMOUNT,
                                    V_TAX_ID,
                                    V_CUSTOMER_ACCOUNT_NUMBER,
                                    V_CUSTOMER_ACCOUNT_NAME;
        EXIT WHEN OUT_TYPE_REF_CUR%NOTFOUND;
        DBMS_LOB.APPEND(V_CLOB, V_STORE_NUMBER || ',' ||
                                V_DRAFT_NUMBER || ',' ||
                                V_TRANSACTION_DATE || ',' ||
                                V_AMOUNT || ',' ||
                                V_TAX_ID || ',' ||
                                V_CUSTOMER_ACCOUNT_NUMBER || ',' ||
                                V_CUSTOMER_ACCOUNT_NAME ||
                                CHR(10));
    END LOOP;
    IF V_CLOB <> EMPTY_CLOB() THEN
        MAIL_PKG.SEND_MAIL('SD_1099_NO_VNDR_ON_BNK_TP_RPRT', NULL, NULL, V_CLOB);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;  
END SD_1099_NO_VNDR_ON_BNK_TP_RPRT;

PROCEDURE SD_1099_TXPYR_ID_AP_TRNS_CRT(IN_DATE      IN     DATE)
IS
    V_CLOB             CLOB;
    V_COUNT            NUMBER := 0;
    V_AMOUNT           NUMBER;
BEGIN
    SELECT COUNT(*),
           SUM(NVL(DECODE(SD.AMOUNT_CHANGE_DATE, NULL,SD.ORIGINAL_NET_AMOUNT,SD.NET_AMOUNT), 0)) AMOUNT
      INTO V_COUNT,
           V_AMOUNT
      FROM STORE_DRAFTS_ODR SD,
           COST_CENTER CC
     WHERE TO_CHAR(PICKED_BY_1099_ON_DATE,'MMYYYY') = TO_CHAR(IN_DATE,'MMYYYY')
       AND SD.COST_CENTER_CODE = CC.COST_CENTER_CODE
       AND CC.STATEMENT_TYPE NOT IN ('AC','DC','GC','CN');
    V_CLOB := V_CLOB ||
             'RECORDS READ,'||V_COUNT||CHR(13)||
             '496419 BYPASSED, 0'||CHR(13)||
             'A/P AMOUNT IN,'||V_AMOUNT||CHR(13)||
             'IA RECORDS OUT,'||V_COUNT||CHR(13)||
             'IA AMOUNT OUT,'||V_AMOUNT||CHR(13)||
             'IK RECORDS OUT,'||V_COUNT||CHR(13)||
             'IK AMOUNT OUT,'||V_AMOUNT||CHR(13)||
             'BH AMOUNT OUT,'||V_AMOUNT||CHR(13);
    IF V_CLOB <> EMPTY_CLOB() THEN
        MAIL_PKG.SEND_MAIL('SD_1099_TXPYR_ID_AP_TRNS_CRT', NULL, NULL, V_CLOB);
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;  
END SD_1099_TXPYR_ID_AP_TRNS_CRT;

BEGIN
    BEGIN
        INSERT INTO STORE_DRAFTS_ODR
            --input month issued drafts
            SELECT *
              FROM STORE_DRAFTS
             WHERE (POS_TRANSACTION_CODE = '13' OR (POS_TRANSACTION_CODE = '91' AND REASON_CODE = '04'))
                   AND TO_CHAR(ISSUE_DATE,'YYYYMM') = TO_CHAR(IN_DATE,'YYYYMM')
             UNION
            --drafts that are never sent to FSS
            SELECT *
              FROM STORE_DRAFTS
             WHERE PICKED_BY_1099_ON_DATE IS NOT NULL AND FNCL_SRVCS_SENT_DATE IS NULL
             UNION
            --drafts that are already sent for FSS
            SELECT *
              FROM STORE_DRAFTS
             WHERE FNCL_SRVCS_SENT_DATE = ADD_MONTHS(IN_DATE, 1);
    EXCEPTION
        WHEN OTHERS THEN NULL;
    END;
    UPDT_1099_FILE(IN_DATE);
    UPDT_1099_FILE_FOR_FSS(IN_DATE);
    SD_1099_NO_MTCHD_VENDOR_RPRT(ADD_MONTHS(IN_DATE, 1));
    SD_1099_MTCHD_PRCSNG_RPRT(ADD_MONTHS(IN_DATE, 1));
    SD_1099_NO_VNDR_ON_BNK_TP_RPRT(ADD_MONTHS(IN_DATE, 1));
    SD_1099_TXPYR_ID_AP_TRNS_CRT(IN_DATE);
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;

DROP TABLE STORE_DRAFTS_ODR;
