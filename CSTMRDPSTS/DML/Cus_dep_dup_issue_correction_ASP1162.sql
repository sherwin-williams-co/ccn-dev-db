/*
Below script will resolve the duplciates issue that happened due to 0 run cycles

Created : 11/12/2018 jxc517 CCN Project Team....
Changed :
*/

DECLARE
    CURSOR CUST_DEPOSITS_ACCT IS
        SELECT DISTINCT CUSTOMER_ACCOUNT_NUMBER
          FROM CUSTOMER_DEPOSIT_HEADER
         WHERE CUSTOMER_ACCOUNT_NUMBER IN (
          '301148623','302632096','304005135','423860329','572460111','575028493'
          );

    CURSOR CUST_DEPOSITS(IN_ACOUNT     VARCHAR2) IS
       SELECT A.*,
              rowid row_id
         FROM CUSTOMER_DEPOSIT_DETAILS A
        WHERE /*TRANSACTION_TYPE = 'REDEMPTION'
         AND */TRANSACTION_DATE BETWEEN '01-OCT-2017' AND '31-AUG-2018'
         AND CUSTOMER_ACCOUNT_NUMBER     = IN_ACOUNT
         AND CSTMR_DPST_SALES_LN_ITM_AMT <> (SELECT SUM(EXTENDED_PRICE)
                                               FROM CCN_SALES_LINES_T
                                              WHERE NON_MERCH_CODE = '05'
                                                AND RLS_RUN_CYCLE  = A.RLS_RUN_CYCLE
                                                AND TRAN_GUID      = A.TRANSACTION_GUID);
                                                
   --variable declaration
   V_CREDIT_ROW     CUST_DEP_CREDIT_DETAILS%ROWTYPE;
   V_REDEMPTION_ROW CUST_DEP_REDEMPTION_DETAILS%ROWTYPE;
   V_RUNNING_TOTAL  NUMBER := 0;
   V_ORIG_DEP_NBR   CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_NUMBER%TYPE;
   V_ORIG_TERM_NBR  CUSTOMER_DEPOSIT_DETAILS.TERMINAL_NUMBER%TYPE;
   V_ORIG_TRAN_DATE CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_DATE%TYPE;
BEGIN
    FOR rec in CUST_DEPOSITS_ACCT LOOP
        FOR rec2 in CUST_DEPOSITS(rec.CUSTOMER_ACCOUNT_NUMBER) LOOP
            UPDATE CUSTOMER_DEPOSIT_DETAILS D
               SET D.CSTMR_DPST_SALES_LN_ITM_AMT = (rec2.CSTMR_DPST_SALES_LN_ITM_AMT/2)
             WHERE rowid = rec2.row_id;  
        END LOOP;

        DELETE FROM CUST_DEP_CREDIT_DETAILS C     WHERE C.CUSTOMER_ACCOUNT_NUMBER = rec.CUSTOMER_ACCOUNT_NUMBER;
        DELETE FROM CUST_DEP_REDEMPTION_DETAILS R WHERE R.CUSTOMER_ACCOUNT_NUMBER = rec.CUSTOMER_ACCOUNT_NUMBER;
        V_RUNNING_TOTAL := 0;

        FOR rec1 in (SELECT * FROM CUSTOMER_DEPOSIT_DETAILS WHERE CUSTOMER_ACCOUNT_NUMBER = rec.CUSTOMER_ACCOUNT_NUMBER ORDER BY TRAN_TIMESTAMP) LOOP
            BEGIN
                V_RUNNING_TOTAL := V_RUNNING_TOTAL + rec1.CSTMR_DPST_SALES_LN_ITM_AMT;
                UPDATE CUSTOMER_DEPOSIT_DETAILS
                   SET CUSTOMER_NET_BALANCE = V_RUNNING_TOTAL
                 WHERE TRANSACTION_GUID     = rec1.TRANSACTION_GUID
                   AND CUSTOMER_NET_BALANCE <> V_RUNNING_TOTAL;

                 IF rec1.TRANSACTION_TYPE = 'DEPOSIT' THEN
                    V_CREDIT_ROW.CREDIT_ID                := SEQ_CREDIT_ID.nextval;
                    V_CREDIT_ROW.COST_CENTER_CODE         := rec1.COST_CENTER_CODE;
                    V_CREDIT_ROW.CUSTOMER_ACCOUNT_NUMBER  := rec1.CUSTOMER_ACCOUNT_NUMBER;
                    V_CREDIT_ROW.TRANSACTION_NUMBER       := rec1.TRANSACTION_NUMBER;
                    V_CREDIT_ROW.TRANSACTION_DATE         := rec1.TRANSACTION_DATE;
                    V_CREDIT_ROW.TERMINAL_NUMBER          := rec1.TERMINAL_NUMBER;           
                    V_CREDIT_ROW.DEPOSIT_REMAINING_BAL    := rec1.CSTMR_DPST_SALES_LN_ITM_AMT;
                    V_CREDIT_ROW.TRAN_TIMESTAMP           := rec1.TRAN_TIMESTAMP;
                    V_CREDIT_ROW.LOAD_DATE                := rec1.LOAD_DATE;

                    TABLE_IU_PKG.CUST_DEPOSIT_CREDIT_I_SP(V_CREDIT_ROW);
                 ELSIF rec1.TRANSACTION_TYPE = 'REDEMPTION' THEN
                    CUSTOMER_DEPOSIT_MAINT_PKG.ORIG_DEP_REM_BAL_UPD( rec1.CSTMR_DPST_SALES_LN_ITM_AMT, rec1.CUSTOMER_ACCOUNT_NUMBER, rec1.TRANSACTION_DATE, V_ORIG_DEP_NBR, V_ORIG_TERM_NBR, V_ORIG_TRAN_DATE);
                    V_REDEMPTION_ROW.REDEMPTION_ID                  := SEQ_REDEMPTION_ID.nextval;
                    V_REDEMPTION_ROW.COST_CENTER_CODE               := rec1.COST_CENTER_CODE;
                    V_REDEMPTION_ROW.CUSTOMER_ACCOUNT_NUMBER        := rec1.CUSTOMER_ACCOUNT_NUMBER;
                    V_REDEMPTION_ROW.TRANSACTION_NUMBER             := rec1.TRANSACTION_NUMBER;
                    V_REDEMPTION_ROW.TRANSACTION_DATE               := rec1.TRANSACTION_DATE;
                    V_REDEMPTION_ROW.TERMINAL_NUMBER                := rec1.TERMINAL_NUMBER;
                    V_REDEMPTION_ROW.ORIGINAL_DEP_TRANS_NBR         := V_ORIG_DEP_NBR;  
                    V_REDEMPTION_ROW.ORIGINAL_DEP_TERM_NBR          := V_ORIG_TERM_NBR;
                    V_REDEMPTION_ROW.ORIGINAL_DEP_TRAN_DATE         := V_ORIG_TRAN_DATE;
                    V_REDEMPTION_ROW.TRAN_TIMESTAMP                 := rec1.TRAN_TIMESTAMP;
                    V_REDEMPTION_ROW.LOAD_DATE                      := rec1.LOAD_DATE;

                    TABLE_IU_PKG.CUST_DEPOSIT_REDEMPTION_I_SP(V_REDEMPTION_ROW);
                 ELSE
                   NULL;
                 END IF;
              EXCEPTION
                 WHEN OTHERS THEN
                      ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'LOAD_CUSTOMER_DEPOSIT_DETAILS', SQLERRM, rec1.COST_CENTER_CODE, rec1.CUSTOMER_ACCOUNT_NUMBER, 'CUSTOMER_DEPOSIT_DETAILS');
              END;
        END LOOP;
        COMMIT;
    END LOOP;
EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'LOAD_CUSTOMER_DEPOSIT_DETAILS', SQLERRM, '000000', '000000000', '000000000');
END;