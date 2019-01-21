/*********************************************************************************
   This script is for inserting data into credit and redemption detail tables
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

NOTE: For reruns, make a note that we need to update the transaction time stamp for off set transactions with their actual transactions
     and tie back and revert the transaction time stamp same like before.This is utmost important going forward until things are streamlined.
   
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
             TRANSACTION_GUID,
             RLS_RUN_CYCLE,
             TRAN_TIMESTAMP,
             CSTMR_DPST_SALES_LN_ITM_AMT,
             ROW_NUMBER() OVER (PARTITION BY CUSTOMER_ACCOUNT_NUMBER ORDER BY  TRAN_TIMESTAMP, TERMINAL_NUMBER) AS RNUM
        FROM CUSTOMER_DEPOSIT_DETAILS
        ORDER BY CUSTOMER_ACCOUNT_NUMBER, TRANSACTION_DATE;

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

PROCEDURE OFFSET_ORIG_DEP_REM_BAL_UPD(
/**********************************************************
This function updates the original references for a Redemption
and updates the Deposit with remaining balance

Created :
Changed :
**********************************************************/
    IN_CSTMR_DPST_SALES_LN_ITM_AMT IN      CUSTOMER_DEPOSIT_DETAILS.CSTMR_DPST_SALES_LN_ITM_AMT%TYPE,
    IN_CUSTOMER_ACCOUNT_NUMBER     IN      CUSTOMER_DEPOSIT_DETAILS.CUSTOMER_ACCOUNT_NUMBER%TYPE,
    IN_TRANSACTION_DATE            IN      CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_DATE%TYPE,
    IN_TRAN_TIMESTAMP              IN      CUSTOMER_DEPOSIT_DETAILS.TRAN_TIMESTAMP%TYPE,
    OUT_TRANSACTION_NUMBER            OUT  CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_NUMBER%TYPE,
    OUT_TERMINAL_NUMBER               OUT  CUSTOMER_DEPOSIT_DETAILS.TERMINAL_NUMBER%TYPE,
    OUT_TRANSACTION_DATE              OUT  CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_DATE%TYPE
)
IS
    CURSOR ALL_DEPS IS
        SELECT a.*, rowid, count(*) over () TOT_DEP_CNT
          FROM CUST_DEP_CREDIT_DETAILS a
         WHERE CUSTOMER_ACCOUNT_NUMBER = IN_CUSTOMER_ACCOUNT_NUMBER
           AND TRANSACTION_DATE <= IN_TRANSACTION_DATE
           AND DEPOSIT_REMAINING_BAL > 0
           AND TRAN_TIMESTAMP   = IN_TRAN_TIMESTAMP
           AND ROWNUM < 2;
BEGIN
    FOR each_dep IN ALL_DEPS LOOP
        OUT_TRANSACTION_NUMBER := each_dep.TRANSACTION_NUMBER;
        OUT_TERMINAL_NUMBER    := each_dep.TERMINAL_NUMBER;
        OUT_TRANSACTION_DATE   := each_dep.TRANSACTION_DATE;
        UPDATE CUST_DEP_CREDIT_DETAILS
           SET DEPOSIT_REMAINING_BAL = 0
          WHERE ROWID = each_dep.rowid;
    END LOOP;
END OFFSET_ORIG_DEP_REM_BAL_UPD;
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
               OFFSET_ORIG_DEP_REM_BAL_UPD(V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT,
                                                                rec.CUSTOMER_ACCOUNT_NUMBER,
                                                                REC.TRANSACTION_DATE,
                                                                REC.TRAN_TIMESTAMP,
                                                                V_ORIG_DEP_NBR,
                                                                V_ORIG_TERM_NBR,
                                                                V_ORIG_TRAN_DATE);

               IF V_ORIG_DEP_NBR IS NULL THEN
                   CUSTOMER_DEPOSIT_MAINT_PKG.ORIG_DEP_REM_BAL_UPD(COMMON_TOOLS.GET_CSTMR_DPST_SALES_LN_ITM_AMT(rec.CUSTOMER_ACCOUNT_NUMBER, rec.COST_CENTER_CODE,rec.TRANSACTION_NUMBER,rec.TERMINAL_NUMBER,rec.TRANSACTION_DATE),
                                                                rec.CUSTOMER_ACCOUNT_NUMBER,
                                                                rec.TRANSACTION_DATE,
                                                                V_ORIG_DEP_NBR,
                                                                V_ORIG_TERM_NBR,
                                                                V_ORIG_TRAN_DATE);
               END IF;
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