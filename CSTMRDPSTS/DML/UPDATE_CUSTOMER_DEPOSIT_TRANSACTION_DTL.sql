/*******************************************************************************
This script will update the deposit remaining balance of a deposit and originals for redemption records in CUSTOMER_DEPOSIT_TRANSACTION_DTL table
CREATED : 02/12/2019 pxa852 CCN Project...
*******************************************************************************/
DECLARE
    CURSOR ACCT_CUR IS
          SELECT DISTINCT CUSTOMER_ACCOUNT_NUMBER
             FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL
            ORDER BY CUSTOMER_ACCOUNT_NUMBER;
    CURSOR DTL_CUR (P_ACCOUNT_NUMBER VARCHAR2) IS
          SELECT *
             FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL
            WHERE CUSTOMER_ACCOUNT_NUMBER = P_ACCOUNT_NUMBER
            ORDER BY CUSTOMER_ACCOUNT_NUMBER, TRAN_TIMESTAMP;

   V_COMMIT                NUMBER := 0;
   V_ORIG_DEP_NBR          CUSTOMER_DEPOSIT_TRANSACTION_DTL.ORGNL_DEPOSIT_TRANSACTION_NBR%TYPE;
   V_ORIG_TERM_NBR         CUSTOMER_DEPOSIT_TRANSACTION_DTL.ORGNL_DEPOSIT_TERMINAL_NBR%TYPE;
   V_ORIG_TRAN_DATE        CUSTOMER_DEPOSIT_TRANSACTION_DTL.ORGNL_DEPOSIT_TRANSACTION_DATE%TYPE;
   V_DEPOSIT_REMAINING_BAL CUSTOMER_DEPOSIT_TRANSACTION_DTL.DEPOSIT_REMAINING_BAL%TYPE;
BEGIN
    FOR REC1 IN ACCT_CUR LOOP
        FOR REC IN DTL_CUR (REC1.CUSTOMER_ACCOUNT_NUMBER) LOOP
            IF REC.CSTMR_DPST_SALES_LN_ITM_AMT > 0 THEN
               BEGIN
                   SELECT DEPOSIT_REMAINING_BAL
                          INTO V_DEPOSIT_REMAINING_BAL
                     FROM CUST_DEP_CREDIT_DETAILS C
                    WHERE C.CUSTOMER_ACCOUNT_NUMBER = REC.CUSTOMER_ACCOUNT_NUMBER
                      AND C.COST_CENTER_CODE        = REC.COST_CENTER_CODE
                      AND C.TRANSACTION_DATE        = REC.TRANSACTION_DATE
                      AND C.TERMINAL_NUMBER         = REC.TERMINAL_NUMBER
                      AND C.TRANSACTION_NUMBER      = REC.TRANSACTION_NUMBER;
               EXCEPTION
                  WHEN OTHERS THEN
                       ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                        'ONE_TIME_SCRIPT_DEPOSIT_UPDATE',
                                        SQLERRM,
                                        REC.COST_CENTER_CODE,
                                        REC.CUSTOMER_ACCOUNT_NUMBER,
                                        'ONE_TIME_SCRIPT_DEPOSIT_UPDATE');
               END;
               UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL
                  SET DEPOSIT_REMAINING_BAL = V_DEPOSIT_REMAINING_BAL
                 WHERE CUST_DEP_TRANS_DETAIL_SEQ = REC.CUST_DEP_TRANS_DETAIL_SEQ;
            ELSIF REC.CSTMR_DPST_SALES_LN_ITM_AMT < 0 THEN
               BEGIN
                   SELECT R.ORGNL_DEPOSIT_TERMINAL_NBR,
                          R.ORGNL_DEPOSIT_TRANSACTION_NBR,
                          R.ORGNL_DEPOSIT_TRANSACTION_DATE
                          INTO V_ORIG_TERM_NBR,
                               V_ORIG_DEP_NBR,
                               V_ORIG_TRAN_DATE
                     FROM CUST_DEP_REDEMPTION_DETAILS R
                    WHERE R.CUSTOMER_ACCOUNT_NUMBER = REC.CUSTOMER_ACCOUNT_NUMBER
                      AND R.COST_CENTER_CODE        = REC.COST_CENTER_CODE
                      AND R.TRANSACTION_DATE        = REC.TRANSACTION_DATE
                      AND R.TERMINAL_NUMBER         = REC.TERMINAL_NUMBER
                      AND R.TRANSACTION_NUMBER      = REC.TRANSACTION_NUMBER;
               EXCEPTION
                  WHEN OTHERS THEN
                       ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                        'ONE_TIME_SCRIPT_RED_UPDATE',
                                        SQLERRM,
                                        REC.COST_CENTER_CODE,
                                        REC.CUSTOMER_ACCOUNT_NUMBER,
                                        'ONE_TIME_SCRIPT_RED_UPDATE');
               END;
               UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL
                  SET ORGNL_DEPOSIT_TERMINAL_NBR     = V_ORIG_TERM_NBR,
                      ORGNL_DEPOSIT_TRANSACTION_NBR  = V_ORIG_DEP_NBR,
                      ORGNL_DEPOSIT_TRANSACTION_DATE = V_ORIG_TRAN_DATE
                  WHERE CUST_DEP_TRANS_DETAIL_SEQ = REC.CUST_DEP_TRANS_DETAIL_SEQ;
            END IF;
             V_COMMIT := V_COMMIT + 1;
             IF V_COMMIT > 500 THEN
                COMMIT;
                V_COMMIT := 0;
             END IF;
        END LOOP;
        COMMIT;
    END LOOP;
EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                    'LOAD_CUSTOMER_DEPOSIT_TRANS_DTLS',
                                    SQLERRM,
                                    '000000',
                                    '000000000',
                                    '000000000');
END;