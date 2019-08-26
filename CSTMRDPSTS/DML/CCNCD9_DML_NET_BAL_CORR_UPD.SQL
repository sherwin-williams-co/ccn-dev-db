/*--------------------------------------------------------------------------------
Below script will update net balance amount in CUSTOMER_DEPOSIT_TRANSACTION_DTL
as they were not calculated correctly.

Created: 08/26/2019 akj899 CCNCD-9 CCN Project....
---------------------------------------------------------------------------------*/
DECLARE
    CURSOR Account_det IS
    SELECT D.*, ROWID
      FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL D
     WHERE D.CUSTOMER_ACCOUNT_NUMBER  IN ('1', '220025142', '237658026', '348353137', '579460817', '798077749', '798473641', '799031869')
  ORDER BY D.TRAN_TIMESTAMP;
           
   V_NET_BAL         NUMBER:=0;
BEGIN
    FOR rec1 IN Account_det LOOP
        V_NET_BAL  := V_NET_BAL + rec1.CSTMR_DPST_SALES_LN_ITM_AMT;
        UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL
           SET CUSTOMER_NET_BALANCE = V_NET_BAL
         WHERE ROWID = rec1.ROWID
           AND CUSTOMER_NET_BALANCE <> V_NET_BAL;
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