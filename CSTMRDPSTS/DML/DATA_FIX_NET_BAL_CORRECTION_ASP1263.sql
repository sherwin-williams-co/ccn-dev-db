/*
Below script will update net balance amount for CUSTOMER_DEPOSIT_TRANSACTION_DTL
as they were not calculated correctly due to incorrect 

Created : 05/21/2019 sxs484 CCN Project Team....
*/

DECLARE
    CURSOR main_cur IS
        SELECT DISTINCT CUSTOMER_ACCOUNT_NUMBER
          FROM TEMP_FIX_NET_BAL;
                                              
    CURSOR Account_det (IN_CUST_ACCOUNT_NBR VARCHAR2) IS
           SELECT D.*, ROWID 
             FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL D 
            WHERE D.CUSTOMER_ACCOUNT_NUMBER = IN_CUST_ACCOUNT_NBR
            ORDER BY D.CUSTOMER_ACCOUNT_NUMBER, D.TRAN_TIMESTAMP;
            
   V_NET_BAL         NUMBER;  
   V_COMMIT          NUMBER := 0;
BEGIN
    FOR rec IN main_cur LOOP
        V_NET_BAL :=0;
        FOR rec1 IN Account_det(rec.CUSTOMER_ACCOUNT_NUMBER) LOOP
            V_NET_BAL  := V_NET_BAL + rec1.CSTMR_DPST_SALES_LN_ITM_AMT;
            UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL
               SET CUSTOMER_NET_BALANCE = V_NET_BAL
             WHERE ROWID = rec1.ROWID
               AND CUSTOMER_NET_BALANCE <> V_NET_BAL;
        END LOOP;
        V_COMMIT := V_COMMIT + 1;
        IF V_COMMIT > 500 THEN
           COMMIT;
           V_COMMIT := 0;
        END IF;
    END LOOP;
    COMMIT;
EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                    'NET_BAL_CORRECTION_052019',
                                    SQLERRM,
                                    '000000',
                                    '000000000',
                                    '000000000'); 
END;
/