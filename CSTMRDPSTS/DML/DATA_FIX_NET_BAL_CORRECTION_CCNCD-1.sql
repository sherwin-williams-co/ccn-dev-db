/*
CCNCD-1
Below script will update net balance amount for CUSTOMER_DEPOSIT_TRANSACTION_DTL
as they were not calculated correctly.
*/

DECLARE
    CURSOR Account_det IS
		   SELECT D.*, ROWID 
             FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL D 
            WHERE D.CUSTOMER_ACCOUNT_NUMBER IN ('421621384','539446930','599366663','991809237','527084974')
            ORDER BY D.CUSTOMER_ACCOUNT_NUMBER, D.TRAN_TIMESTAMP;
            
   V_NET_BAL         NUMBER;  
   V_ACCT_NBR 		 CUSTOMER_DEPOSIT_TRANSACTION_DTL.CUSTOMER_ACCOUNT_NUMBER%TYPE ;
BEGIN
        FOR rec1 IN Account_det LOOP
			IF NVL(V_ACCT_NBR,'XXXX') <> rec1.CUSTOMER_ACCOUNT_NUMBER THEN
			   V_NET_BAL := 0;
			END IF;
            V_NET_BAL  := V_NET_BAL + rec1.CSTMR_DPST_SALES_LN_ITM_AMT;			
            UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL
               SET CUSTOMER_NET_BALANCE = V_NET_BAL
             WHERE ROWID = rec1.ROWID
               AND CUSTOMER_NET_BALANCE <> V_NET_BAL;
			V_ACCT_NBR := rec1.CUSTOMER_ACCOUNT_NUMBER;			   
        END LOOP;
           COMMIT;
EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                    'NET_BAL_CORRECTION_06262019',
                                    SQLERRM,
                                    '000000',
                                    '000000000',
                                    '000000000'); 
END;
/
