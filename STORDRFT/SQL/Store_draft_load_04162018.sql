/*
Created : nxk927 04/16/2018
          This script will load the drafts that errored out on Friday/Saturday.
          Checked the paid details as well from friday's file.
          If this script won't be run today(04/16/2018), then we have to check the paid files from monday as well.

SELECT * 
  FROM (
SELECT CCN_COMMON_TOOLS.GET_DATE_VALUE('1'||PAID_DATE, 'YYMMDD') PAID_DATE,
       CCN_COMMON_TOOLS.RETURN_NUMBER(AMOUNT,11,2) AMOUNT,
       CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(FILLER||CHECK_NUMBER_CC||CHECK_NUMBER_SQ||CHECK_NUMBER_CK) CHECK_SERIAL_NUMBER
  FROM TEMP_PAID_DETAILS_ROYAL)
 WHERE CHECK_SERIAL_NUMBER IN ('0820010015','0820010023','0820010122','0820010114','0820010015','0820010031','0820010098','0820010148','0820010023',
'0820010080','0820010155','0820010049','0820010064','0820010072','0820010130','0820010163','0820010056','0820010106');

SELECT * 
  FROM (
 SELECT CCN_COMMON_TOOLS.GET_DATE_VALUE('1'||PAID_DATE_PAID, 'MMDDYY') PAID_DATE,
        CCN_COMMON_TOOLS.RETURN_NUMBER(PAID_AMONUT_ITEMS,10,2) AMOUNT,
        CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(PAID_CHECK_SERIAL_NUMBER) CHECK_SERIAL_NUMBER
   FROM TEMP_PAID_DETAILS_SUNTRUST)
 WHERE CHECK_SERIAL_NUMBER IN ('0820010015','0820010023','0820010122','0820010114','0820010015','0820010031','0820010098','0820010148','0820010023',
'0820010080','0820010155','0820010049','0820010064','0820010072','0820010130','0820010163','0820010056','0820010106');

*/


DECLARE
IN_DATE DATE :=TRUNC(SYSDATE)-4;
    CURSOR STOREDRAFT_TEMP_CUR is
        SELECT ICD.*, (SELECT COST_CENTER_CODE 
                         FROM COST_CENTER 
                        WHERE SUBSTR(COST_CENTER_CODE,3) = TRIM(ICD.COST_CENTER_CODE)) CC_CODE
          FROM DLY_POS_ISSUE_CHANGE_DATA ICD
         WHERE CHECK_SERIAL_NUMBER IN ('0820010122','0820010114','0820010015','0820010031','0820010098','0820010148','0820010023','0820010080',
                                       '0820010155','0820010049','0820010064','0820010072','0820010130','0820010163','0820010056','0820010106');


    V_COMMIT                      NUMBER := 0;
    V_COUNT                       NUMBER := 0;
    V_STOREDRAFT_TEMP_ROW         STORE_DRAFTS%ROWTYPE;
    V_COST_CENTER_CODE            STORE_DRAFTS.COST_CENTER_CODE%TYPE;

BEGIN

    FOR rec IN STOREDRAFT_TEMP_CUR LOOP
        BEGIN
            V_STOREDRAFT_TEMP_ROW.COST_CENTER_CODE        := REC.CC_CODE;
            V_STOREDRAFT_TEMP_ROW.CHECK_SERIAL_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CHECK_SERIAL_NUMBER);
            V_STOREDRAFT_TEMP_ROW.DRAFT_NUMBER            := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.DRAFT_NUMBER);
            V_STOREDRAFT_TEMP_ROW.TRANSACTION_DATE        := CCN_COMMON_TOOLS.GET_DATE_VALUE(rec.TRANSACTION_DATE,'YYMMDD');
            V_STOREDRAFT_TEMP_ROW.TERMINAL_NUMBER         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.TERMINAL_NUMBER);
            V_STOREDRAFT_TEMP_ROW.TRANSACTION_NUMBER      := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.TRANSACTION_NUMBER);
            V_STOREDRAFT_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CUSTOMER_ACCOUNT_NUMBER);
            V_STOREDRAFT_TEMP_ROW.CUSTOMER_JOB_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CUSTOMER_JOB_NUMBER);
            V_STOREDRAFT_TEMP_ROW.POS_TRANSACTION_CODE    := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.POS_TRANSACTION_CODE);
            V_STOREDRAFT_TEMP_ROW.POS_TRANSACTION_TIME    := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.TRANSACTION_TIME);
            V_STOREDRAFT_TEMP_ROW.PAYEE_NAME              := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.PAYEE_NAME);
            V_STOREDRAFT_TEMP_ROW.ADDRESS_LINE_1          := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ADDRESS_LINE_1);
            V_STOREDRAFT_TEMP_ROW.ADDRESS_LINE_2          := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ADDRESS_LINE_2);
            V_STOREDRAFT_TEMP_ROW.CITY                    := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CITY);
            V_STOREDRAFT_TEMP_ROW.STATE_CODE              := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.STATE_CODE);
            V_STOREDRAFT_TEMP_ROW.ZIP_CODE_PREFIX         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(SUBSTR(rec.ZIP_CODE,1,6));
            V_STOREDRAFT_TEMP_ROW.ZIP_CODE_SUFFIX         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(SUBSTR(rec.ZIP_CODE,7));
            V_STOREDRAFT_TEMP_ROW.PHONE_AREA_CODE         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(SUBSTR(rec.PHONE_NUMBER,1,3));
            V_STOREDRAFT_TEMP_ROW.PHONE_NUMBER            := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(SUBSTR(rec.PHONE_NUMBER,4));
            V_STOREDRAFT_TEMP_ROW.EMPLOYEE_NUMBER         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.EMPLOYEE_NUMBER);
            V_STOREDRAFT_TEMP_ROW.ISSUE_DATE              := CCN_COMMON_TOOLS.GET_DATE_VALUE(rec.ISSUE_DATE,'YYMMDD');
            V_STOREDRAFT_TEMP_ROW.GROSS_AMOUNT            := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.GROSS_AMOUNT,9,2);
            V_STOREDRAFT_TEMP_ROW.GROSS_AMOUNT            := CASE rec.GROSS_AMOUNT_SIGN WHEN '-' THEN -1 * V_STOREDRAFT_TEMP_ROW.GROSS_AMOUNT ELSE V_STOREDRAFT_TEMP_ROW.GROSS_AMOUNT END;
            V_STOREDRAFT_TEMP_ROW.RETAIN_AMOUNT           := rec.RETAINAGE_AMOUNT/100;
            V_STOREDRAFT_TEMP_ROW.RETAIN_AMOUNT           := CASE rec.RETAINAGE_AMOUNT_SIGN WHEN '-' THEN -1 * V_STOREDRAFT_TEMP_ROW.RETAIN_AMOUNT ELSE V_STOREDRAFT_TEMP_ROW.RETAIN_AMOUNT END;
            V_STOREDRAFT_TEMP_ROW.NET_AMOUNT              := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.NET_AMOUNT,9,2); 
            V_STOREDRAFT_TEMP_ROW.NET_AMOUNT              := CASE rec.NET_AMOUNT_SIGN WHEN '-' THEN -1 * V_STOREDRAFT_TEMP_ROW.NET_AMOUNT ELSE V_STOREDRAFT_TEMP_ROW.NET_AMOUNT END;
            V_STOREDRAFT_TEMP_ROW.ORIGINAL_NET_AMOUNT     := NVL(CCN_COMMON_TOOLS.RETURN_NUMBER(rec.GROSS_AMOUNT,9,2),0) - 
                                                             NVL(CCN_COMMON_TOOLS.RETURN_NUMBER(rec.RETAINAGE_AMOUNT,9,2),0);
            V_STOREDRAFT_TEMP_ROW.TRANSACTION_SOURCE      := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.TRANSACTION_SOURCE);
            V_STOREDRAFT_TEMP_ROW.SLS_BOOK_DATE           := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.BOOK_DATE);
            V_STOREDRAFT_TEMP_ROW.CYCLE_RUN_NUMBER        := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CYCLE_RUN_NUMBER);
            V_STOREDRAFT_TEMP_ROW.REASON_CODE             := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.REASON_CODE);
            
			      FOR rec1 IN (SELECT *
                           FROM DLY_POS_BANK_PAID_DATA
                           WHERE COST_CENTER_CODE    = rec.COST_CENTER_CODE
                             AND CHECK_SERIAL_NUMBER = REC.CHECK_SERIAL_NUMBER
                             AND LOAD_DATE >= IN_DATE) LOOP
                V_STOREDRAFT_TEMP_ROW.BANK_NUMBER             := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec1.BANK_NUMBER);
                V_STOREDRAFT_TEMP_ROW.BANK_ACCOUNT_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(REC1.BANK_ACCOUNT_NUMBER);
                V_STOREDRAFT_TEMP_ROW.BANK_PAID_AMOUNT        := CCN_COMMON_TOOLS.RETURN_NUMBER(REC1.BANK_PAID_AMOUNT,9,2);
                V_STOREDRAFT_TEMP_ROW.PAID_DATE               := CCN_COMMON_TOOLS.GET_DATE_VALUE(rec1.PAID_DATE,'YYMMDD');
                V_STOREDRAFT_TEMP_ROW.STOP_PAY_DATE           := CCN_COMMON_TOOLS.GET_DATE_VALUE(rec1.STOP_PAY_DATE,'YYMMDD');
                V_STOREDRAFT_TEMP_ROW.STOP_PAY_REMOVE_DATE    := CCN_COMMON_TOOLS.GET_DATE_VALUE(rec1.STOP_PAY_REMOVE_DATE,'YYMMDD');
                V_STOREDRAFT_TEMP_ROW.VOID_DATE               := CCN_COMMON_TOOLS.GET_DATE_VALUE(rec1.VOID_DATE,'YYMMDD');
            END LOOP;
            
            SD_BUSINESS_RULES_PKG.SET_STORE_DRAFT_FLAGS(V_STOREDRAFT_TEMP_ROW);

            V_STOREDRAFT_TEMP_ROW.LOAD_DATE      := TO_DATE('17-APR-2018 06:30:00','DD-MON-YYYY HH24:MI:SS');
                 
                   
            IF SD_BUSINESS_RULES_PKG.IS_UNATTACHED_STORE_DRAFT(V_STOREDRAFT_TEMP_ROW) THEN
                INSERT INTO UNATTACHED_MNL_DRFT_DTL VALUES V_STOREDRAFT_TEMP_ROW;
            ELSE
                IF V_STOREDRAFT_TEMP_ROW.TRANSACTION_DATE <= ADD_MONTHS(TRUNC(SYSDATE),-1 * SD_BUSINESS_RULES_PKG.G_HISTORY_MONTHS) THEN
                    INSERT INTO HST_STORE_DRAFTS VALUES V_STOREDRAFT_TEMP_ROW;
                ELSE
                    SELECT COUNT(*)
                      INTO V_COUNT
                      FROM STORE_DRAFTS
                     WHERE COST_CENTER_CODE    = V_STOREDRAFT_TEMP_ROW.COST_CENTER_CODE
                       AND CHECK_SERIAL_NUMBER = V_STOREDRAFT_TEMP_ROW.CHECK_SERIAL_NUMBER;
                    IF V_COUNT = 0 THEN
                        INSERT INTO STORE_DRAFTS VALUES V_STOREDRAFT_TEMP_ROW;
                    ELSE
                        SELECT BANK_PAID_AMOUNT,
                               PAID_DATE
                          INTO V_STOREDRAFT_TEMP_ROW.BANK_PAID_AMOUNT,
                               V_STOREDRAFT_TEMP_ROW.PAID_DATE
                          FROM STORE_DRAFTS
                         WHERE CHECK_SERIAL_NUMBER = REC.CHECK_SERIAL_NUMBER;
				   
                        UPDATE STORE_DRAFTS
                           SET ROW = V_STOREDRAFT_TEMP_ROW
                         WHERE COST_CENTER_CODE    = V_STOREDRAFT_TEMP_ROW.COST_CENTER_CODE
                            AND CHECK_SERIAL_NUMBER = V_STOREDRAFT_TEMP_ROW.CHECK_SERIAL_NUMBER;
                       ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                                  'LOAD_DLY_STORE_DRAFTS',
                                                  'DUPLICATE_SERIAL_NUMBER',
                                                  NVL(V_COST_CENTER_CODE,rec.COST_CENTER_CODE),
                                                  NVL(rec.CHECK_SERIAL_NUMBER,'')||':'||
                                                  NVL(rec.TRANSACTION_DATE,'')||':'||
                                                  NVL(rec.TERMINAL_NUMBER,'')||':'||
                                                  NVL(rec.TRANSACTION_NUMBER,''));
                    END IF;
                END IF;
            END IF;

            V_STOREDRAFT_TEMP_ROW := NULL ;
            V_COMMIT := V_COMMIT + 1;
            IF V_COMMIT > 500 THEN
                COMMIT;
                V_COMMIT := 0;
            END IF;   
        EXCEPTION
            WHEN OTHERS THEN 
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_DLY_STORE_DRAFTS',
                                           SQLERRM,
                                           NVL(V_COST_CENTER_CODE,rec.COST_CENTER_CODE),
                                           NVL(rec.CHECK_SERIAL_NUMBER,'')||':'||
                                           NVL(rec.TRANSACTION_DATE,'')||':'||
                                           NVL(rec.TERMINAL_NUMBER,'')||':'||
                                           NVL(rec.TRANSACTION_NUMBER,''));
                                           
                                           
        END;
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN  
         ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_DLY_STORE_DRAFTS',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
END;
/
--STORE DRAFT DETAIL TABLE LOAD
DECLARE
IN_DATE DATE := TRUNC(SYSDATE)-4;
 CURSOR STOREDRAFT_DETAIL_CUR IS   
        SELECT ROW_NUMBER( ) OVER (PARTITION BY A.COST_CENTER_CODE,B.TRANSACTION_DATE,A.CHECK_SERIAL_NUMBER ORDER BY B.TRANSACTION_DATE) SRLNO,
               B.TRANSACTION_DATE,
               (SELECT COST_CENTER_CODE
                 FROM COST_CENTER
                WHERE A.COST_CENTER_CODE    = SUBSTR(COST_CENTER_CODE,3)
                  AND CATEGORY = 'S') CC_CODE,
               A.*
          FROM DLY_POS_ISSUE_CHANGE_DATA B,
               (SELECT TRANGUID,
                       TRANSACTION_SOURCE,
                       TRANSACTION_TYPE,
                       COST_CENTER_CODE,
                       CHECK_SERIAL_NUMBER,
                       PROCESS_DATE,
                       TRANSACTION_SEGMENT_TYPE,
                       ITEM_EXT_AMOUNT,
                       NULL ORGNL_CUSTOMER_ACCOUNT_NUMBER,
                       NULL ORGNL_JOB_NUMBER,
                       GL_PRIME_ACCOUNT_NUMBER,
                       GL_SUB_ACCOUNT_NUMBER,
                       NULL ORGNL_TERMINAL_NUMBER,
                       NULL ORGNL_TRANSACTION_NUMBER,
                       NULL ITEM_QUANTITY,
                       NULL ITEM_PRICE,
                       ITEM_EXT_AMOUNT_SIGN,
                       NULL ITEM_QUANTITY_SIGN,
                       NULL ITEM_PRICE_SIGN,
                       RUNCYCLE,
                       LOAD_DATE
                  FROM DLY_POS_DSBRSMNT_LN_ITM_DATA
                 WHERE LOAD_DATE > IN_DATE
                   AND CHECK_SERIAL_NUMBER IN ('0820010122','0820010114','0820010015','0820010031','0820010098','0820010148','0820010023','0820010080',
                                               '0820010155','0820010049','0820010064','0820010072','0820010130','0820010163','0820010056','0820010106')
                 UNION ALL
                SELECT TRANGUID,
                       TRANSACTION_SOURCE,
                       TRANSACTION_TYPE,
                       COST_CENTER_CODE,
                       CHECK_SERIAL_NUMBER,
                       PROCESS_DATE,
                       TRANSACTION_SEGMENT_TYPE,
                       ITEM_EXT_AMOUNT,
                       ORGNL_CUSTOMER_ACCOUNT_NUMBER,
                       ORGNL_JOB_NUMBER,
                       NULL GL_PRIME_ACCOUNT_NUMBER,
                       NULL GL_SUB_ACCOUNT_NUMBER,
                       NULL ORGNL_TERMINAL_NUMBER,
                       NULL ORGNL_TRANSACTION_NUMBER,
                       NULL ITEM_QUANTITY,
                       NULL ITEM_PRICE,
                       ITEM_EXT_AMOUNT_SIGN,
                       NULL ITEM_QUANTITY_SIGN,
                       NULL ITEM_PRICE_SIGN,
                       RUNCYCLE,
                       LOAD_DATE
                  FROM DLY_POS_CSTMR_LINE_ITEM_DATA
                 WHERE LOAD_DATE > IN_DATE
                   AND CHECK_SERIAL_NUMBER IN ('0820010122','0820010114','0820010015','0820010031','0820010098','0820010148','0820010023','0820010080',
                                               '0820010155','0820010049','0820010064','0820010072','0820010130','0820010163','0820010056','0820010106')
                 UNION ALL
                SELECT TRANGUID,
                       TRANSACTION_SOURCE,
                       TRANSACTION_TYPE,
                       COST_CENTER_CODE,
                       CHECK_SERIAL_NUMBER,
                       PROCESS_DATE,
                       TRANSACTION_SEGMENT_TYPE,
                       ITEM_EXT_AMOUNT,
                       NULL ORGNL_CUSTOMER_ACCOUNT_NUMBER,
                       NULL ORGNL_JOB_NUMBER,
                       GL_PRIME_ACCOUNT_NUMBER,
                       GL_SUB_ACCOUNT_NUMBER,
                       ORGNL_TERMINAL_NUMBER,
                       ORGNL_TRANSACTION_NUMBER,
                       ITEM_QUANTITY,
                       ITEM_PRICE,
                       ITEM_EXT_AMOUNT_SIGN,
                       ITEM_QUANTITY_SIGN,
                       ITEM_PRICE_SIGN,
                       RUNCYCLE,
                       LOAD_DATE
                  FROM DLY_POS_INSTLLR_LN_ITM_DATA
                 WHERE LOAD_DATE > IN_DATE
                   AND CHECK_SERIAL_NUMBER IN ('0820010122','0820010114','0820010015','0820010031','0820010098','0820010148','0820010023','0820010080',
                                               '0820010155','0820010049','0820010064','0820010072','0820010130','0820010163','0820010056','0820010106')) A
         WHERE A.COST_CENTER_CODE    = B.COST_CENTER_CODE(+)
           AND A.CHECK_SERIAL_NUMBER = B.CHECK_SERIAL_NUMBER(+);

    V_COMMIT                      INTEGER := 0;
    V_STOREDRAFT_DETAIL_ROW       STORE_DRAFTS_DETAIL%ROWTYPE;
    V_UNMTCHED_STOREDRAFT_DTL_ROW UNATTACHED_MNL_DRFT_DTL%ROWTYPE;
BEGIN

    FOR rec IN STOREDRAFT_DETAIL_CUR LOOP
        BEGIN
            V_STOREDRAFT_DETAIL_ROW.STORE_DRAFTS_DETAIL_ID  := rec.SRLNO;
            V_STOREDRAFT_DETAIL_ROW.COST_CENTER_CODE        := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CC_CODE);
            V_STOREDRAFT_DETAIL_ROW.CHECK_SERIAL_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CHECK_SERIAL_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.TRANSACTION_DATE        := CCN_COMMON_TOOLS.GET_DATE_VALUE(rec.TRANSACTION_DATE,'YYMMDD');
            V_STOREDRAFT_DETAIL_ROW.TERMINAL_NUMBER         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ORGNL_TERMINAL_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.TRANSACTION_NUMBER      := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ORGNL_TRANSACTION_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.CUSTOMER_ACCOUNT_NUMBER := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ORGNL_CUSTOMER_ACCOUNT_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.CUSTOMER_JOB_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ORGNL_JOB_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.GL_PRIME_ACCOUNT_NUMBER := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.GL_PRIME_ACCOUNT_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.GL_SUB_ACCOUNT_NUMBER   := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.GL_SUB_ACCOUNT_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.ITEM_QUANTITY           := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_QUANTITY,7,2);
            V_STOREDRAFT_DETAIL_ROW.ITEM_QUANTITY           := CASE rec.ITEM_QUANTITY_SIGN WHEN '-' THEN -1 * V_STOREDRAFT_DETAIL_ROW.ITEM_QUANTITY ELSE V_STOREDRAFT_DETAIL_ROW.ITEM_QUANTITY END; 
            V_STOREDRAFT_DETAIL_ROW.ITEM_PRICE              := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_PRICE,7,2);
            V_STOREDRAFT_DETAIL_ROW.ITEM_PRICE              := CASE rec.ITEM_PRICE_SIGN WHEN '-' THEN -1 * V_STOREDRAFT_DETAIL_ROW.ITEM_PRICE ELSE V_STOREDRAFT_DETAIL_ROW.ITEM_PRICE END;
            V_STOREDRAFT_DETAIL_ROW.ITEM_EXT_AMOUNT         := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_EXT_AMOUNT,9,2); --actual table has 7,2
            V_STOREDRAFT_DETAIL_ROW.ITEM_EXT_AMOUNT         := CASE rec.ITEM_EXT_AMOUNT_SIGN WHEN '-' THEN -1 * V_STOREDRAFT_DETAIL_ROW.ITEM_EXT_AMOUNT ELSE V_STOREDRAFT_DETAIL_ROW.ITEM_EXT_AMOUNT END;
            
            IF V_STOREDRAFT_DETAIL_ROW.TRANSACTION_DATE <= ADD_MONTHS(TRUNC(SYSDATE),-1 * SD_BUSINESS_RULES_PKG.G_HISTORY_MONTHS) THEN
                INSERT INTO HST_STORE_DRAFTS_DETAIL VALUES V_STOREDRAFT_DETAIL_ROW;
            ELSE
                INSERT INTO STORE_DRAFTS_DETAIL VALUES V_STOREDRAFT_DETAIL_ROW;
            END IF;

            V_STOREDRAFT_DETAIL_ROW := NULL ;
            V_COMMIT := V_COMMIT + 1;
            IF V_COMMIT > 500 THEN
                COMMIT;
                V_COMMIT := 0;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                BEGIN
                    SELECT *
                      INTO V_UNMTCHED_STOREDRAFT_DTL_ROW
                      FROM UNATTACHED_MNL_DRFT_DTL
                     WHERE COST_CENTER_CODE    = rec.COST_CENTER_CODE
                       AND CHECK_SERIAL_NUMBER = rec.CHECK_SERIAL_NUMBER
                       AND ROWNUM < 2;
                      
                    INSERT INTO STORE_DRAFTS VALUES V_UNMTCHED_STOREDRAFT_DTL_ROW;
                    INSERT INTO UNATTACHED_MNL_DRFT_DTL_HST VALUES V_UNMTCHED_STOREDRAFT_DTL_ROW;
                    DELETE
                      FROM UNATTACHED_MNL_DRFT_DTL
                     WHERE COST_CENTER_CODE    = V_UNMTCHED_STOREDRAFT_DTL_ROW.COST_CENTER_CODE
                       AND CHECK_SERIAL_NUMBER = V_UNMTCHED_STOREDRAFT_DTL_ROW.CHECK_SERIAL_NUMBER
                       AND TRANSACTION_DATE    = V_UNMTCHED_STOREDRAFT_DTL_ROW.TRANSACTION_DATE;
                    INSERT INTO STORE_DRAFTS_DETAIL VALUES V_STOREDRAFT_DETAIL_ROW;
                EXCEPTION
                    WHEN OTHERS THEN
                        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                                   'LOAD_DLY_STORE_DRAFTS_DETAIL',
                                                   SQLERRM,
                                                   NVL(rec.CC_CODE,rec.COST_CENTER_CODE),
                                                   NVL(rec.CHECK_SERIAL_NUMBER,'')||':'||
                                                   NVL(rec.TRANSACTION_DATE,'') ||':'||
                                                   NVL(rec.ORGNL_TERMINAL_NUMBER,'')||':'||
                                                   NVL(rec.ORGNL_TRANSACTION_NUMBER,'')
                                                   );
                END;
        END;
    END LOOP;  
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
         ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_DLY_STORE_DRAFTS_DETAIL',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
END;

/