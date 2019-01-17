/*********************************************************************************
   This script is for inserting data into credit and redemption detail tables
   
   created : 01/04/2019  pxa852 CCN Project
*********************************************************************************/
DECLARE
--variable declaration
   CURSOR TEMP_CUR IS
      SELECT COST_CENTER_CODE,
             TRANSACTION_DATE,
             TERMINAL_NUMBER,
             TRANSACTION_NUMBER,
             CUSTOMER_ACCOUNT_NUMBER,
             TRAN_TIMESTAMP,
             CSTMR_DPST_SALES_LN_ITM_AMT,
             ROW_NUMBER() OVER (PARTITION BY CUSTOMER_ACCOUNT_NUMBER ORDER BY  TRAN_TIMESTAMP, TERMINAL_NUMBER) AS RNUM
        FROM CUSTOMER_DEPOSIT_DETAILS
          ORDER BY CUSTOMER_ACCOUNT_NUMBER,TRAN_TIMESTAMP;

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
         V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT :=   REC.CSTMR_DPST_SALES_LN_ITM_AMT;
         V_TEMP_ROW.COST_CENTER_CODE            :=   REC.COST_CENTER_CODE;
         V_TEMP_ROW.TRANSACTION_DATE            :=   REC.TRANSACTION_DATE;
         V_TEMP_ROW.TERMINAL_NUMBER             :=   REC.TERMINAL_NUMBER;
         V_TEMP_ROW.TRANSACTION_NUMBER          :=   REC.TRANSACTION_NUMBER;
         V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER     :=   REC.CUSTOMER_ACCOUNT_NUMBER;
         V_TEMP_ROW.TRAN_TIMESTAMP              :=   REC.TRAN_TIMESTAMP;
         V_TEMP_ROW.TRANSACTION_TYPE            :=   CASE WHEN V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT > 0 THEN
                                                            'DEPOSIT'
                                                       WHEN V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT < 0 THEN
                                                            'REDEMPTION'
                                                       ELSE 'NA'
                                                  END;

         IF V_TEMP_ROW.TRANSACTION_TYPE = 'DEPOSIT'  THEN
            V_CREDIT_ROW.CREDIT_ID                := SEQ_CREDIT_ID.nextval;
            V_CREDIT_ROW.COST_CENTER_CODE         := V_TEMP_ROW.COST_CENTER_CODE;
            V_CREDIT_ROW.CUSTOMER_ACCOUNT_NUMBER  := V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER;
            V_CREDIT_ROW.TRANSACTION_NUMBER       := V_TEMP_ROW.TRANSACTION_NUMBER;
            V_CREDIT_ROW.TRANSACTION_DATE         := V_TEMP_ROW.TRANSACTION_DATE;
            V_CREDIT_ROW.TERMINAL_NUMBER          := V_TEMP_ROW.TERMINAL_NUMBER;
            V_CREDIT_ROW.DEPOSIT_REMAINING_BAL    := V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT;
            V_CREDIT_ROW.TRAN_TIMESTAMP           := V_TEMP_ROW.TRAN_TIMESTAMP;
            V_CREDIT_ROW.LOAD_DATE                := V_LOAD_DATE;

            TABLE_IU_PKG.CUST_DEPOSIT_CREDIT_I_SP(V_CREDIT_ROW);
            FOR rec1 IN (SELECT *
                           FROM CUST_DEP_REDEMPTION_DETAILS
                          WHERE CUSTOMER_ACCOUNT_NUMBER = V_CREDIT_ROW.CUSTOMER_ACCOUNT_NUMBER
                            AND TRANSACTION_DATE <= V_CREDIT_ROW.TRANSACTION_DATE
                            AND ORGNL_DEPOSIT_TERMINAL_NBR IS NULL
                          ORDER BY TRAN_TIMESTAMP) LOOP
                CUSTOMER_DEPOSIT_MAINT_PKG.ORIG_DEP_REM_BAL_UPD(COMMON_TOOLS.GET_CSTMR_DPST_SALES_LN_ITM_AMT(rec1.CUSTOMER_ACCOUNT_NUMBER, rec1.COST_CENTER_CODE,rec1.TRANSACTION_NUMBER,rec1.TERMINAL_NUMBER,rec1.TRANSACTION_DATE),
                                                                rec1.CUSTOMER_ACCOUNT_NUMBER,
                                                                V_CREDIT_ROW.TRANSACTION_DATE,
                                                                V_ORIG_DEP_NBR,
                                                                V_ORIG_TERM_NBR,
                                                                V_ORIG_TRAN_DATE);
                rec1.ORGNL_DEPOSIT_TRANSACTION_NBR    := V_ORIG_DEP_NBR;
                rec1.ORGNL_DEPOSIT_TERMINAL_NBR       := V_ORIG_TERM_NBR;
                rec1.ORGNL_DEPOSIT_TRANSACTION_DATE   := V_ORIG_TRAN_DATE;
                TABLE_IU_PKG.CUST_DEPOSIT_REDEMPTION_I_SP(rec1);
            END LOOP;

         ELSIF V_TEMP_ROW.TRANSACTION_TYPE = 'REDEMPTION' THEN
               CUSTOMER_DEPOSIT_MAINT_PKG.ORIG_DEP_REM_BAL_UPD( V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT, REC.CUSTOMER_ACCOUNT_NUMBER, REC.TRANSACTION_DATE, V_ORIG_DEP_NBR, V_ORIG_TERM_NBR, V_ORIG_TRAN_DATE);
               V_REDEMPTION_ROW.REDEMPTION_ID                  := SEQ_REDEMPTION_ID.nextval;
               V_REDEMPTION_ROW.COST_CENTER_CODE               := V_TEMP_ROW.COST_CENTER_CODE;
               V_REDEMPTION_ROW.CUSTOMER_ACCOUNT_NUMBER        := V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER;
               V_REDEMPTION_ROW.TRANSACTION_NUMBER             := V_TEMP_ROW.TRANSACTION_NUMBER;
               V_REDEMPTION_ROW.TRANSACTION_DATE               := V_TEMP_ROW.TRANSACTION_DATE;
               V_REDEMPTION_ROW.TERMINAL_NUMBER                := V_TEMP_ROW.TERMINAL_NUMBER;
               V_REDEMPTION_ROW.ORIGINAL_DEP_TRANS_NBR         := V_ORIG_DEP_NBR;
               V_REDEMPTION_ROW.ORIGINAL_DEP_TERM_NBR          := V_ORIG_TERM_NBR;
               V_REDEMPTION_ROW.ORIGINAL_DEP_TRAN_DATE         := V_ORIG_TRAN_DATE;
               V_REDEMPTION_ROW.TRAN_TIMESTAMP                 := V_TEMP_ROW.TRAN_TIMESTAMP;
               V_REDEMPTION_ROW.LOAD_DATE                      := V_LOAD_DATE;

               TABLE_IU_PKG.CUST_DEPOSIT_REDEMPTION_I_SP(V_REDEMPTION_ROW);
         ELSE
           NULL;
         END IF;
         
         V_TEMP_ROW := NULL;
         V_COMMIT := V_COMMIT + 1;
         IF V_COMMIT > 500 THEN
            COMMIT;
            V_COMMIT := 0;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
              ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                          'LOAD_CUSTOMER_DEPOSIT_DETAILS',
                                          SQLERRM,
                                          V_TEMP_ROW.COST_CENTER_CODE,
                                          V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER,
                                          'CUSTOMER_DEPOSIT_DETAILS');
      END;
   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                    'LOAD_CUSTOMER_DEPOSIT_DETAILS',
                                    SQLERRM,
                                    '000000',
                                    '000000000',
                                    '000000000');
END;
