/*------------------------------------------------------------------------------------------------------------
Below script will do customer deposit account corrections which were closed as part of CCNCCD-14 initially
account closure activity and update net balance amount in CUSTOMER_DEPOSIT_TRANSACTION_DTL
as well.
Account list are taken from TEMP_CD_ACC_CLOSE_LIST which was built from
CD_ACC_CLOSE_LIST.csv files.

Created: 09/10/2019 akj899 CCNAS-32 CCN Project....
------------------------------------------------------------------------------------------------------------------*/
DECLARE
    CURSOR ALL_ACCOUNTS IS
    SELECT DISTINCT CUSTOMER_ACCOUNT_NUMBER
      FROM CUSTOMER_DEPOSIT_TRANSACTION_HDR 
     WHERE CUSTOMER_ACCOUNT_NUMBER  IN (SELECT CUSTOMER_NUMBER FROM TEMP_CD_ACC_CLOSE_LIST);

    CURSOR Account_det(IN_CUS_ACC  CUSTOMER_DEPOSIT_TRANSACTION_DTL.CUSTOMER_ACCOUNT_NUMBER%TYPE) IS
    SELECT D.*, ROWID
      FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL D
     WHERE D.CUSTOMER_ACCOUNT_NUMBER  = IN_CUS_ACC
  ORDER BY D.TRAN_TIMESTAMP; 
          
   V_NET_BAL         NUMBER:=0;
BEGIN
   FOR rec IN ALL_ACCOUNTS LOOP
      V_NET_BAL := 0;
      FOR rec1 IN Account_det(rec.CUSTOMER_ACCOUNT_NUMBER) LOOP
          V_NET_BAL  := V_NET_BAL + rec1.CSTMR_DPST_SALES_LN_ITM_AMT;
          UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL
             SET CLOSED_DATE          = NULL,
                 CLEARED_REASON       = NULL
           WHERE ROWID          = rec1.ROWID
             AND CLEARED_REASON = 'Aged Deposit'
             AND CLOSED_DATE IS NOT NULL;

          UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL
             SET CUSTOMER_NET_BALANCE = V_NET_BAL
           WHERE ROWID                = rec1.ROWID
             AND CUSTOMER_NET_BALANCE <> V_NET_BAL;

      END LOOP;
   END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                    'NET_BAL_CORRECTION_08262019',
                                    SQLERRM,
                                    '000000',
                                    '000000000',
                                    '000000000');
END;
/