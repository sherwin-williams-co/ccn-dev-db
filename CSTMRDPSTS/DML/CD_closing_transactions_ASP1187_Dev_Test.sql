/*********************************************************************************
   This script is for inserting data provided by Marissa
   
   created : 01/04/2019  sxg151 CCN Project
*********************************************************************************/
DECLARE
--variable declaration
   CURSOR TEMP_CUR IS
      SELECT b.COST_CENTER_CODE,
             b.TRANSACTION_DATE,
             b.TERMINAL_NUMBER,
             b.TRANSACTION_NUMBER,
             b.CUSTOMER_ACCOUNT_NUMBER,
             b.POS_TRANSACTION_CODE,
             b.TRAN_TIMESTAMP,
             b.CSTMR_DPST_SALES_LN_ITM_AMT,
             b.GL_DIVISION,
             a.TRANSACTION_GUID,
             a.RLS_RUN_CYCLE,
             ROW_NUMBER() OVER (PARTITION BY b.CUSTOMER_ACCOUNT_NUMBER ORDER BY  b.TRAN_TIMESTAMP, b.TRANSACTION_NUMBER) AS RNUM
        FROM CUSTOMER_DEPOSIT_DETAILS a,
             CD_MARY_04JAN2019 b 
      WHERE a.CUSTOMER_ACCOUNT_NUMBER = b.CUSTOMER_ACCOUNT_NUMBER
        AND a.COST_CENTER_CODE        = b.COST_CENTER_CODE
        AND a.TRANSACTION_DATE        = b.TRANSACTION_DATE
        AND a.TERMINAL_NUMBER         = b.TERMINAL_NUMBER
        AND a.TRANSACTION_NUMBER      = b.TRANSACTION_NUMBER;

   --variable declaration
   V_TEMP_ROW       CUSTOMER_DEPOSIT_DETAILS%ROWTYPE;
   V_CREDIT_ROW     CUST_DEP_CREDIT_DETAILS%ROWTYPE;
   V_REDEMPTION_ROW CUST_DEP_REDEMPTION_DETAILS%ROWTYPE;
   V_COMMIT         NUMBER := 0;
   V_CUM_AMT        NUMBER := 0;
   V_ORIG_DEP_NBR   CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_NUMBER%TYPE;
   V_ORIG_TERM_NBR  CUSTOMER_DEPOSIT_DETAILS.TERMINAL_NUMBER%TYPE;
   V_ORIG_TRAN_DATE CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_DATE%TYPE;
   V_LOAD_DATE      DATE := SYSDATE;
BEGIN
   FOR REC IN TEMP_CUR LOOP
      BEGIN
         V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT :=   -1 * REC.CSTMR_DPST_SALES_LN_ITM_AMT;
         DBMS_OUTPUT.PUT_LINE(V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT);
         V_TEMP_ROW.COST_CENTER_CODE            :=   REC.COST_CENTER_CODE;
         V_TEMP_ROW.TRANSACTION_DATE            :=   TRUNC(SYSDATE);
         V_TEMP_ROW.TERMINAL_NUMBER             :=   REC.TERMINAL_NUMBER;
         V_TEMP_ROW.TRANSACTION_NUMBER          :=   REC.TRANSACTION_NUMBER;
         V_TEMP_ROW.TRANSACTION_GUID            :=   REC.TRANSACTION_GUID;
         V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER     :=   REC.CUSTOMER_ACCOUNT_NUMBER;
         V_TEMP_ROW.POS_TRANSACTION_CODE        :=   REC.POS_TRANSACTION_CODE;
         V_TEMP_ROW.TRAN_TIMESTAMP              :=   SYSTIMESTAMP;
         V_TEMP_ROW.TRANSACTION_TYPE            :=   'MANUAL';
         V_CUM_AMT                             :=  (CASE WHEN REC.RNUM = 1 THEN
                                                       COMMON_TOOLS.FNC_GET_LATEST_CUM_AMT(REC.CUSTOMER_ACCOUNT_NUMBER)
                                                    ELSE
                                                        V_CUM_AMT
                                                    END)  + V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT;
        DBMS_OUTPUT.PUT_LINE(V_CUM_AMT);
         V_TEMP_ROW.CUSTOMER_NET_BALANCE        :=  V_CUM_AMT;
         V_TEMP_ROW.GL_DIVISION                 :=  REC.GL_DIVISION;
         V_TEMP_ROW.RLS_RUN_CYCLE               :=  REC.RLS_RUN_CYCLE;
         V_TEMP_ROW.LOAD_DATE                   :=  V_LOAD_DATE;
         V_TEMP_ROW.TRANSACTION_SQ_ID           := TRANSACTION_SQ_ID.NEXTVAL;

         TABLE_IU_PKG.CUST_DEP_DET_I_SP(V_TEMP_ROW);

         V_TEMP_ROW := NULL;
         V_COMMIT := V_COMMIT + 1;
         IF V_COMMIT > 500 THEN
            COMMIT;
            V_COMMIT := 0;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
              ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'Manual Correction - ' || TRUNC(SYSDATE), SQLERRM, '000000', '000000000', '000000000');
      END;
   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'Manual Correction - ' || TRUNC(SYSDATE), SQLERRM, '000000', '000000000', '000000000');
END;