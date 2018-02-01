/*********************************************************************************
   This script is for updating CUSTOMER_DEPOSIT_DETAILS net balance 
   
   created : 02/01/2018  SXH487 CCN Project
*********************************************************************************/
DECLARE
    CURSOR main_cur IS
        SELECT CUSTOMER_ACCOUNT_NUMBER,
               TRAN_TIMESTAMP, 
               TERMINAL_NUMBER,
               TOTAL_SALES,
               ROW_NUMBER() OVER (PARTITION BY CUSTOMER_ACCOUNT_NUMBER ORDER BY TRAN_TIMESTAMP, TERMINAL_NUMBER) AS RNUM,
               ROWID
        FROM CUSTOMER_DEPOSIT_DETAILS
       WHERE CUSTOMER_NET_BALANCE IS NULL
       ORDER BY CUSTOMER_ACCOUNT_NUMBER, TRAN_TIMESTAMP, TERMINAL_NUMBER;
   V_CUM_AMT        NUMBER := 0;
BEGIN
    FOR rec IN main_cur LOOP
        V_CUM_AMT := (CASE WHEN rec.RNUM = 1 THEN
                         0
                      ELSE
                         V_CUM_AMT
                      END) + rec.TOTAL_SALES;
        UPDATE CUSTOMER_DEPOSIT_DETAILS SET CUSTOMER_NET_BALANCE = V_CUM_AMT WHERE ROWID = rec.ROWID;
    END LOOP;
    COMMIT;
END;
/