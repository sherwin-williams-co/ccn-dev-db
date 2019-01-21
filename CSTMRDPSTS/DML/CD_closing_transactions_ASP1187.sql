/*********************************************************************************
   This script is for inserting data provided by Marissa
   1) We ended up having data model changes in lower environments because of which
      we are providing solution that work in QA and Production to clear off Marissas transactions first

   2) To tie back properly and to not hinder existing data model
      2.1) We are inserting records marissa sent in excel exactly like that except for transaction date being added with +1 second (Constraint Support)
      2.2) We insert the transaction time stamp as is first to support redemptions tie back
      2.3) We are reverting the transaction time stamp to sys time stamp after tie backs
           to make sure our logic to get recent net balance works same like before
      2.4) We wrote separate procedure for off set records for proper tie redemption/deposit back
           and this getting invoked for regular transactions shouldn't have any impact as the
           regular transactions should never have same transaction time stamp
All these things need to be corrected as part of new data model that gets implemented soon in lower environments.

   created : 01/04/2019  pxa852 CCN Project
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
        AND a.TRANSACTION_NUMBER      = b.TRANSACTION_NUMBER
      ORDER BY a.CUSTOMER_ACCOUNT_NUMBER, a.TRAN_TIMESTAMP ;

   --variable declaration
   V_TEMP_ROW       CUSTOMER_DEPOSIT_DETAILS%ROWTYPE;
   V_COMMIT         NUMBER := 0;
   V_CUM_AMT        NUMBER := 0;
   V_LOAD_DATE      DATE := SYSDATE;
BEGIN
   FOR REC IN TEMP_CUR LOOP
      BEGIN
         V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT :=   -1 * REC.CSTMR_DPST_SALES_LN_ITM_AMT;
         V_TEMP_ROW.COST_CENTER_CODE            :=   REC.COST_CENTER_CODE;
         V_TEMP_ROW.TRANSACTION_DATE            :=   REC.TRANSACTION_DATE + INTERVAL '1' SECOND;
         V_TEMP_ROW.TERMINAL_NUMBER             :=   REC.TERMINAL_NUMBER;
         V_TEMP_ROW.TRANSACTION_NUMBER          :=   REC.TRANSACTION_NUMBER;
         V_TEMP_ROW.TRANSACTION_GUID            :=   REC.TRANSACTION_GUID;
         V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER     :=   REC.CUSTOMER_ACCOUNT_NUMBER;
         V_TEMP_ROW.POS_TRANSACTION_CODE        :=   REC.POS_TRANSACTION_CODE;
         V_TEMP_ROW.TRAN_TIMESTAMP              :=   REC.TRAN_TIMESTAMP;
         V_TEMP_ROW.TRANSACTION_TYPE            :=   'MANUAL';
         V_CUM_AMT                             :=  (CASE WHEN REC.RNUM = 1 THEN
                                                       COMMON_TOOLS.FNC_GET_LATEST_CUM_AMT(REC.CUSTOMER_ACCOUNT_NUMBER)
                                                    ELSE
                                                        V_CUM_AMT
                                                    END)  + V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT;
         V_TEMP_ROW.CUSTOMER_NET_BALANCE        :=  V_CUM_AMT;
         V_TEMP_ROW.GL_DIVISION                 :=  REC.GL_DIVISION;
         V_TEMP_ROW.RLS_RUN_CYCLE               :=  REC.RLS_RUN_CYCLE;
         V_TEMP_ROW.LOAD_DATE                   :=  V_LOAD_DATE;
         V_TEMP_ROW.NOTES                       := 'Offset of original transaction number';

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