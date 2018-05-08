/*
 This block will update the original references 
 CUST_DEP_REDEMPTION_DETAILS and deposit remaining bal
 for CUST_DEP_CREDIT_DETAILS
*/

DECLARE
    CURSOR ALL_ACCS IS
        SELECT a.*, ROWID
          FROM CUSTOMER_DEPOSIT_DETAILS a
         WHERE TRANSACTION_TYPE    = 'REDEMPTION'
           AND CUSTOMER_ACCOUNT_NUMBER NOT IN('0','1') 
          ORDER BY a.CUSTOMER_ACCOUNT_NUMBER, a.TRAN_TIMESTAMP;

    V_COUNT INTEGER := 0;
    V_ORIG_DEP_NBR   CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_NUMBER%TYPE;
    V_ORIG_TERM_NBR  CUSTOMER_DEPOSIT_DETAILS.TERMINAL_NUMBER%TYPE;
    V_ORIG_TRAN_DATE CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_DATE%TYPE;
BEGIN        
    FOR each_acc IN ALL_ACCS LOOP
        IF each_acc.TOTAL_SALES < 0 THEN
           CUSTOMER_DEPOSIT_MAINT_PKG.ORIG_DEP_REM_BAL_UPD( each_acc.TOTAL_SALES, 
                                                            each_acc.CUSTOMER_ACCOUNT_NUMBER, 
                                                            each_acc.TRANSACTION_DATE, 
                                                            V_ORIG_DEP_NBR, 
                                                            V_ORIG_TERM_NBR, 
                                                            V_ORIG_TRAN_DATE);
                                              
            UPDATE CUST_DEP_REDEMPTION_DETAILS
               SET ORIGINAL_DEP_TRANS_NBR = V_ORIG_DEP_NBR,
                   ORIGINAL_DEP_TERM_NBR  = V_ORIG_TERM_NBR,
                   ORIGINAL_DEP_TRAN_DATE = V_ORIG_TRAN_DATE
             WHERE CUSTOMER_ACCOUNT_NUMBER = each_acc.CUSTOMER_ACCOUNT_NUMBER
               AND TRANSACTION_NUMBER = each_acc.TRANSACTION_NUMBER
               AND TERMINAL_NUMBER = each_acc.TERMINAL_NUMBER
               AND TRANSACTION_DATE =each_acc.TRANSACTION_DATE
               AND COST_CENTER_CODE =each_acc.COST_CENTER_CODE;
        END IF;
         
         IF V_COUNT > 1000 THEN
            COMMIT;
            V_COUNT := 0;
         ELSE
            V_COUNT := V_COUNT + 1;
         END IF;
    END LOOP;
    COMMIT;
END;
/