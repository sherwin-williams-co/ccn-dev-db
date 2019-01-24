/*********************************************************************************
   This script will insert and update the net balance amount for account '293860144'
   created : 01/24/2019  pxa852 CCN Project
*********************************************************************************/
-- Insert record into customer deposit details table for account '293860144'.
INSERT INTO CUSTOMER_DEPOSIT_DETAILS VALUES ('792758', to_date('07-APR-16','DD-MON-RR'),'18664','3593','FFBBAAB9043E22B7E6117E31582497DB','293860144','10',to_timestamp('07-APR-16 01.00.00.000000000 AM','DD-MON-RR HH.MI.SSXFF AM'),'MANUAL',NULL,10971.9,TRUNC(SYSDATE),'858',NULL,NULL,NULL,'C400',NULL,NULL,10971.9);

--Update Net Balance for '293860144'.
DECLARE                                           
    CURSOR TEMP_CUR IS
           SELECT D.*, ROWID 
             FROM CUSTOMER_DEPOSIT_DETAILS D 
            WHERE D.CUSTOMER_ACCOUNT_NUMBER = '293860144'
            ORDER BY D.CUSTOMER_ACCOUNT_NUMBER, D.TRAN_TIMESTAMP;
            
   V_NET_BAL         NUMBER := 0;  
BEGIN
    FOR REC IN TEMP_CUR LOOP
        V_NET_BAL  := V_NET_BAL + REC.CSTMR_DPST_SALES_LN_ITM_AMT;
        UPDATE CUSTOMER_DEPOSIT_DETAILS
           SET CUSTOMER_NET_BALANCE    = V_NET_BAL
        WHERE ROWID = REC.ROWID;
    END LOOP;
    COMMIT;
END;