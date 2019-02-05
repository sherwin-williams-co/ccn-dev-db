/**********************************************************************************
This script is used to delete data from credit details table for the account number provided by Marissa
Created : 02/05/2019 sxh487 CCN Project Team....
Modified:
**********************************************************************************/
--Delete data from Credit and redemption details table
DELETE FROM CUST_DEP_CREDIT_DETAILS WHERE CUSTOMER_ACCOUNT_NUMBER = '273678557';

COMMIT;
/*********************************************************************************
Adding an offset to Account - 273678557

created : 02/05/2019 sxh487 CCN Project
*********************************************************************************/
DECLARE
--variable declaration
   CURSOR TEMP_CUR IS
      SELECT a.COST_CENTER_CODE,
             a.TRANSACTION_DATE,
             a.TERMINAL_NUMBER,
             a.TRANSACTION_NUMBER,
             a.CUSTOMER_ACCOUNT_NUMBER,
             a.POS_TRANSACTION_CODE,
             a.TRAN_TIMESTAMP,
             a.CSTMR_DPST_SALES_LN_ITM_AMT,
             a.GL_DIVISION,
             a.TRANSACTION_GUID,
             a.RLS_RUN_CYCLE,
             ROW_NUMBER() OVER (PARTITION BY a.CUSTOMER_ACCOUNT_NUMBER ORDER BY  a.TRAN_TIMESTAMP, a.TRANSACTION_NUMBER) AS RNUM
        FROM CUSTOMER_DEPOSIT_DETAILS a
      WHERE a.CUSTOMER_ACCOUNT_NUMBER = '273678557' 
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
         V_TEMP_ROW.TRANSACTION_DATE            :=   CASE WHEN REC.CSTMR_DPST_SALES_LN_ITM_AMT > 0 THEN
                                                            REC.TRANSACTION_DATE + INTERVAL '1' SECOND
                                                       WHEN REC.CSTMR_DPST_SALES_LN_ITM_AMT < 0 THEN
                                                            REC.TRANSACTION_DATE - INTERVAL '1' SECOND
                                                       ELSE REC.TRANSACTION_DATE
                                                     END;
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
/
/*********************************************************************************
   This script is for inserting data into credit and redemption detail tables only 
   for account number 273678557
   created : 02/05/2019  sxh487 CCN Project
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
       WHERE CUSTOMER_ACCOUNT_NUMBER  = '273678557' 
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
                            AND ORIGINAL_DEP_TERM_NBR IS NULL
                          ORDER BY TRAN_TIMESTAMP) LOOP
                CUSTOMER_DEPOSIT_MAINT_PKG.ORIG_DEP_REM_BAL_UPD(COMMON_TOOLS.GET_CSTMR_DPST_SALES_LN_ITM_AMT(rec1.CUSTOMER_ACCOUNT_NUMBER, rec1.COST_CENTER_CODE,rec1.TRANSACTION_NUMBER,rec1.TERMINAL_NUMBER,rec1.TRANSACTION_DATE),
                                                                rec1.CUSTOMER_ACCOUNT_NUMBER,
                                                                V_CREDIT_ROW.TRANSACTION_DATE,
                                                                V_ORIG_DEP_NBR,
                                                                V_ORIG_TERM_NBR,
                                                                V_ORIG_TRAN_DATE);
                rec1.ORIGINAL_DEP_TRANS_NBR   := V_ORIG_DEP_NBR;
                rec1.ORIGINAL_DEP_TERM_NBR    := V_ORIG_TERM_NBR;
                rec1.ORIGINAL_DEP_TRAN_DATE   := V_ORIG_TRAN_DATE;
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
/
/*********************************************************************************
   This script is for updating the transaction timestamp in customer 
   deposit details table for manual entries

   created : 02/05/2019 sxh487 CCN Project
*********************************************************************************/
DECLARE
--variable declaration
   CURSOR TEMP_CUR IS
      SELECT a.*, rowid
        FROM CUSTOMER_DEPOSIT_DETAILS a
       WHERE a.TRANSACTION_TYPE='MANUAL'
         AND a.NOTES  = 'Offset of original transaction number'
         AND a.CUSTOMER_ACCOUNT_NUMBER  = '273678557' 
        ORDER BY CUSTOMER_ACCOUNT_NUMBER, TRAN_TIMESTAMP;

   --variable declaration
   V_COMMIT         NUMBER := 0;
   V_CUM_AMT        NUMBER := 0;
BEGIN
   FOR REC IN TEMP_CUR LOOP
      BEGIN
             UPDATE CUSTOMER_DEPOSIT_DETAILS
                SET TRAN_TIMESTAMP = SYSTIMESTAMP,
                    CLOSED_DATE = TRUNC(SYSDATE) --Added this to close the Account as requested
               WHERE ROWID = REC.rowid;

         V_COMMIT := V_COMMIT + 1;
         IF V_COMMIT > 500 THEN
            COMMIT;
            V_COMMIT := 0;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
              ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'Manuals timestamp update - ' || TRUNC(SYSDATE), SQLERRM, '000000', '000000000', '000000000');
      END;
   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'Manuals timestamp Update - ' || TRUNC(SYSDATE), SQLERRM, '000000', '000000000', '000000000');
END;
/
/*********************************************************************************
   This script is for updating the transaction timestamp  in credit and redemption details table
   for manual entries
   
   created : 02/05/2019 sxh487 CCN Project
*********************************************************************************/
DECLARE
--variable declaration
   CURSOR TEMP_CUR IS
      SELECT *
        FROM CUSTOMER_DEPOSIT_DETAILS
       WHERE TRANSACTION_TYPE='MANUAL'
         AND NOTES  = 'Offset of original transaction number'
         AND CUSTOMER_ACCOUNT_NUMBER = '273678557' 
        ORDER BY CUSTOMER_ACCOUNT_NUMBER, TRAN_TIMESTAMP;

   --variable declaration
   V_COMMIT         NUMBER := 0;
   V_CUM_AMT        NUMBER := 0;
BEGIN
   FOR REC IN TEMP_CUR LOOP
      BEGIN
          IF REC.CSTMR_DPST_SALES_LN_ITM_AMT > 0 THEN
             UPDATE CUST_DEP_CREDIT_DETAILS
                SET TRAN_TIMESTAMP = REC.TRAN_TIMESTAMP
               WHERE CUSTOMER_ACCOUNT_NUMBER = REC.CUSTOMER_ACCOUNT_NUMBER
                 AND COST_CENTER_CODE        = REC.COST_CENTER_CODE
                 AND TRANSACTION_DATE        = REC.TRANSACTION_DATE
                 AND TERMINAL_NUMBER         = REC.TERMINAL_NUMBER
                 AND TRANSACTION_NUMBER      = REC.TRANSACTION_NUMBER;
          ELSE
              UPDATE CUST_DEP_REDEMPTION_DETAILS
                SET TRAN_TIMESTAMP = REC.TRAN_TIMESTAMP
               WHERE CUSTOMER_ACCOUNT_NUMBER = REC.CUSTOMER_ACCOUNT_NUMBER
                 AND COST_CENTER_CODE        = REC.COST_CENTER_CODE
                 AND TRANSACTION_DATE        = REC.TRANSACTION_DATE
                 AND TERMINAL_NUMBER         = REC.TERMINAL_NUMBER
                 AND TRANSACTION_NUMBER      = REC.TRANSACTION_NUMBER;
          END IF;
         V_COMMIT := V_COMMIT + 1;
         IF V_COMMIT > 500 THEN
            COMMIT;
            V_COMMIT := 0;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
              ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'Manuals timestamp update - ' || TRUNC(SYSDATE), SQLERRM, '000000', '000000000', '000000000');
      END;
   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'Manuals timestamp Update - ' || TRUNC(SYSDATE), SQLERRM, '000000', '000000000', '000000000');
END;
/