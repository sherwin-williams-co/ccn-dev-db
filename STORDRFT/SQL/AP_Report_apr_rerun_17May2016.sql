/*
URGENT : Rerunning as modified queries didn't work

created : 05/17/2016 jxc517 CCN Project Team....
*/
DECLARE
PROCEDURE SD_1099_NO_MTCHD_VENDOR_RPRT
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
                  FROM STORE_DRAFTS S, COST_CENTER CC
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

PROCEDURE SD_1099_NO_VNDR_ON_BNK_TP_RPRT
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
                  FROM STORE_DRAFTS S, COST_CENTER CC                 
                 WHERE FNCL_SRVCS_SENT_DATE IS NULL
                   AND PICKED_BY_1099_ON_DATE IS NOT NULL
                   AND CC.COST_CENTER_CODE = S.COST_CENTER_CODE
                   AND CC.STATEMENT_TYPE NOT IN ('AC','DC','GC','CN')) SD
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

PROCEDURE SD_1099_TXPYR_ID_AP_TRNS_CRT(IN_DATE   IN     DATE)
IS
    OUT_TYPE_REF_CUR   SD_TABLE_IU_PKG.REF_CURSOR;
    V_CLOB             CLOB;
    V_COUNT            NUMBER := 0;
    V_AMOUNT           NUMBER;
BEGIN
    SELECT COUNT(*),
           SUM(NVL(DECODE(SD.AMOUNT_CHANGE_DATE, NULL,SD.ORIGINAL_NET_AMOUNT,SD.NET_AMOUNT), 0)) AMOUNT
      INTO V_COUNT,
           V_AMOUNT
      FROM STORE_DRAFTS SD, COST_CENTER CC
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
    SD_1099_NO_MTCHD_VENDOR_RPRT();
    SD_1099_NO_VNDR_ON_BNK_TP_RPRT();
    SD_1099_TXPYR_ID_AP_TRNS_CRT('01-APR-2016');
END;