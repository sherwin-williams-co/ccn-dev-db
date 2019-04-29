/*
This script will Manually insert the CUSTOMER_DEPOSIT_TRANSACTION_HDR/CUSTOMER_DEPOSIT_TRANSACTION_DTL as per requested accounts.
Created  : 04/26/2019 : sxh487/sxg151 CCN Team.
         : ASP -1251  : Customer deposits Manual corrections
 */
DECLARE

CURSOR ALL_ACCOUNTS IS
      SELECT DISTINCT CUSTOMER_ACCOUNT_NUMBER
        FROM CUST_DEP_CORRECTIONS;

CURSOR ALL_TRANS(p_acct_nbr CUSTOMER_DEPOSIT_TRANSACTION_DTL.CUSTOMER_ACCOUNT_NUMBER%TYPE) IS
      SELECT *
        FROM CUST_DEP_CORRECTIONS
       WHERE CUSTOMER_ACCOUNT_NUMBER = p_acct_nbr;
        
    V_NET_BAL                   CUSTOMER_DEPOSIT_TRANSACTION_DTL.CUSTOMER_NET_BALANCE%TYPE;
    V_CUST_DEP_DET_rec          CUSTOMER_DEPOSIT_TRANSACTION_DTL%ROWTYPE;
    V_CUST_DEP_HDR_REC          CUSTOMER_DEPOSIT_TRANSACTION_HDR%ROWTYPE;
    
BEGIN
    FOR each_acct IN ALL_ACCOUNTS LOOP
        -- Get the Last Net Balance 
        V_NET_BAL := CUSTOMER_DEPOSIT_MAINT_PKG.GET_LAST_VALUE_NET_BAL(each_acct.CUSTOMER_ACCOUNT_NUMBER);
        FOR each_tran IN ALL_TRANS (each_acct.CUSTOMER_ACCOUNT_NUMBER) LOOP
               V_NET_BAL := V_NET_BAL + each_tran.CSTMR_DPST_SALES_LN_ITM_MT;
               V_CUST_DEP_DET_rec.CUSTOMER_NET_BALANCE        := V_NET_BAL;
               V_CUST_DEP_DET_rec.CSTMR_DPST_SALES_LN_ITM_AMT := each_tran.CSTMR_DPST_SALES_LN_ITM_MT;
               V_CUST_DEP_DET_rec.LOAD_DATE                   := SYSDATE;
               V_CUST_DEP_DET_rec.TRAN_TIMESTAMP              := SYSTIMESTAMP;
               V_CUST_DEP_DET_rec.CUST_DEP_TRANS_DETAIL_SEQ   := CUST_DEP_DETAIL_ID.NEXTVAL;
               V_CUST_DEP_DET_rec.TRANSACTION_TYPE            := 'MANUAL';
               V_CUST_DEP_DET_rec.CUSTOMER_ACCOUNT_NUMBER     := each_tran.CUSTOMER_ACCOUNT_NUMBER;
               V_CUST_DEP_DET_rec.COST_CENTER_CODE            := each_tran.COST_CENTER_CODE;
               V_CUST_DEP_DET_rec.TERMINAL_NUMBER             := each_tran.TERMINAL_NUMBER;
               V_CUST_DEP_DET_rec.TRANSACTION_NUMBER          := each_tran.TRANSACTION_NUMBER;
               V_CUST_DEP_DET_rec.TRANSACTION_DATE            := SYSDATE;
               V_CUST_DEP_DET_rec.USER_ID                     := 'lxn782';
               V_CUST_DEP_HDR_REC.CUSTOMER_ACCOUNT_NUMBER     := each_tran.CUSTOMER_ACCOUNT_NUMBER;
               V_CUST_DEP_HDR_REC.COST_CENTER_CODE            := each_tran.COST_CENTER_CODE;
               V_CUST_DEP_HDR_REC.TERMINAL_NUMBER             := each_tran.TERMINAL_NUMBER;
               
               -- Insert into CUSTOMER_DEPOSIT_TRANSACTION_HDR Table
               TABLE_IU_PKG.CUST_DEP_TRANS_HDR_I_SP(V_CUST_DEP_HDR_REC);
               -- Insert into CUSTOMER_DEPOSIT_TRANSACTION_DTL Table
               TABLE_IU_PKG.CUST_DEPOSIT_TRAN_DTLS_I_SP(V_CUST_DEP_DET_rec);
        END LOOP; 
        COMMIT;
    END LOOP;
    COMMIT;
END;    
