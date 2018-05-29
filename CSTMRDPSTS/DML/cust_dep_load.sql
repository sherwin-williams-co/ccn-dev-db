/*
Script to re-load the customer deposit header and details
sxh487 05/29/2018
*/
DECLARE
G_NON_MERCH_CODE VARCHAR2(2) := '05';
PROCEDURE LOAD_CUSTOMER_DEPOSIT_HDR(
/*****************************************************************************
LOAD_CUSTOMER_DEPOSIT_HDR

This procedure will load the customer_deposit_header table from pnp legacy idms database.

created : 03/05/2018 sxh487 ccn project....
changed : 05/29/2018 sxh487 Added NON_MERCH_CODE ='05' for line item amount
******************************************************************************/
IN_RLS_RUN_CYCLE POS_CSTMR_DEP_LOAD_STATUS.RLS_RUN_CYCLE%TYPE)
IS

--variable declaration
V_DATE                       DATE := TRUNC(SYSDATE);

   CURSOR TEMP_CUR IS
      SELECT DISTINCT 
             ACCTNBR AS CUSTOMER_ACCOUNT_NUMBER,
             CUSTOMER_NAME,
             BILLNM,
             BILLCONTACT,
             BILLADDR1,
             BILLADDR2,
             BILLCITY,
             BILLZIP,
             BILLPHONE,
             RLS_RUN_CYCLE
        FROM CCN_HEADERS_T H
       WHERE H.RLS_RUN_CYCLE = IN_RLS_RUN_CYCLE
         AND EXISTS (SELECT 1
                       FROM CCN_SALES_LINES_T S
                      WHERE H.TRAN_GUID = S.TRAN_GUID
                        AND H.RLS_RUN_CYCLE = S.RLS_RUN_CYCLE
                        AND H.RLS_RUN_CYCLE = IN_RLS_RUN_CYCLE
                        AND S.NON_MERCH_CODE = G_NON_MERCH_CODE);

   --variable declaration
   V_COMMIT         NUMBER := 0;
   V_TEMP_ROW       CUSTOMER_DEPOSIT_HEADER%ROWTYPE;
   V_HDR_REC        CUSTOMER_DEPOSIT_HEADER%ROWTYPE;
BEGIN
   FOR REC IN TEMP_CUR LOOP
        V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER  := REC.CUSTOMER_ACCOUNT_NUMBER;
        V_TEMP_ROW.CUSTOMER_NAME            := REC.CUSTOMER_NAME; 
        V_TEMP_ROW.BILLCONTACT              := REC.BILLCONTACT;
        V_TEMP_ROW.BILLNM                   := REC.BILLNM;
        V_TEMP_ROW.BILLADDR1                := REC.BILLADDR1;
        V_TEMP_ROW.BILLADDR2                := REC.BILLADDR2;
        V_TEMP_ROW.BILLCITY                 := REC.BILLCITY;
        V_TEMP_ROW.BILLZIP                  := REC.BILLZIP;
        V_TEMP_ROW.BILLPHONE                := REC.BILLPHONE;
        V_TEMP_ROW.RLS_RUN_CYCLE            := REC.RLS_RUN_CYCLE;
        V_TEMP_ROW.LOAD_DATE                := V_DATE;
        
        TABLE_IU_PKG.CUST_DEPOSIT_HEADER_I_SP(V_TEMP_ROW);    
        V_TEMP_ROW := NULL;
        V_COMMIT := V_COMMIT + 1;
        IF V_COMMIT > 500 THEN
           COMMIT;
           V_COMMIT := 0;
        END IF;
   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                    'LOAD_CUSTOMER_DEPOSIT_HDR',
                                    SQLERRM,
                                    '000000',
                                    '000000000',
                                    '000000000');
END LOAD_CUSTOMER_DEPOSIT_HDR;

PROCEDURE LOAD_CUSTOMER_DEPOSIT_DETAILS(
/*****************************************************************************
LOAD_CUSTOMER_DEPOSIT_DETAILS

This procedure will load the customer_deposit_details table from pnp legacy idms database.

created : 09/08/2017 sxh487 ccn project....
changed : 01/26/2018 sxh487 Added logic to get the last cumulative total for calculating the 
          net balance
        : 03/20/2018 sxh487 Added logic to add records in CUST_DEP_CREDIT_DETAILS and CUST_DEP_REDEMPTION_DETAILS 
        : 05/29/2018 sxh487 Added NON_MERCH_CODE ='05' for line item amount
******************************************************************************/
IN_RLS_RUN_CYCLE POS_CSTMR_DEP_LOAD_STATUS.RLS_RUN_CYCLE%TYPE)
IS

--variable declaration
C_NET_NON_MERCH_ID           VARCHAR2(5) := '91';
C_NET_DISCOUNT               VARCHAR2(5) := '92';
C_NET_SALES_ID               VARCHAR2(5) := '93';
C_NET_TAX_ID                 VARCHAR2(5) := '94';

   CURSOR TEMP_CUR IS
      SELECT STORE_NO  AS COST_CENTER_CODE,
             TRAN_DATE AS TRANSACTION_DATE,
             TERMNBR   AS TERMINAL_NUMBER,
             TRANNBR   AS TRANSACTION_NUMBER,
             TRAN_GUID AS TRANSACTION_GUID,
             ACCTNBR   AS CUSTOMER_ACCOUNT_NUMBER,
             TRANID    AS POS_TRANSACTION_CODE,
             TRAN_TIMESTAMP,
             RLS_RUN_CYCLE,
             (SELECT DIVISION FROM HIERARCHY_DETAIL_VIEW B WHERE HRCHY_HDR_NAME = 'FACTS_DIVISION' and H.STORE_NO = SUBSTR(B.COST_CENTER_CODE,3)) AS GL_DIVISION,
             ROW_NUMBER() OVER (PARTITION BY ACCTNBR ORDER BY  TRAN_TIMESTAMP, TERMNBR) AS RNUM
        FROM CCN_HEADERS_T H
       WHERE H.RLS_RUN_CYCLE = IN_RLS_RUN_CYCLE
         AND EXISTS (SELECT 1
                       FROM CCN_SALES_LINES_T S
                      WHERE H.TRAN_GUID = S.TRAN_GUID
                        AND H.RLS_RUN_CYCLE = S.RLS_RUN_CYCLE
                        AND H.RLS_RUN_CYCLE = IN_RLS_RUN_CYCLE
                        AND S.NON_MERCH_CODE = G_NON_MERCH_CODE);
       
   --variable declaration
   V_TEMP_ROW       CUSTOMER_DEPOSIT_DETAILS%ROWTYPE;
   V_CREDIT_ROW     CUST_DEP_CREDIT_DETAILS%ROWTYPE;
   V_REDEMPTION_ROW CUST_DEP_REDEMPTION_DETAILS%ROWTYPE;
   V_COMMIT         NUMBER := 0;
   V_TOTAL_SALES    NUMBER := 0;
   V_NET_SALES      NUMBER := 0;
   V_NET_TAX        NUMBER := 0;
   V_NET_NON_MERCH  NUMBER := 0;
   V_CUM_AMT        NUMBER := 0;
   V_ORIG_DEP_NBR   CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_NUMBER%TYPE;
   V_ORIG_TERM_NBR  CUSTOMER_DEPOSIT_DETAILS.TERMINAL_NUMBER%TYPE;
   V_ORIG_TRAN_DATE CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_DATE%TYPE;
   V_LOAD_DATE      DATE := SYSDATE;
BEGIN
   FOR REC IN TEMP_CUR LOOP
      BEGIN
          V_TOTAL_SALES                       :=  CASE WHEN REC.POS_TRANSACTION_CODE ='31'  THEN  
                                                      ((ABS(V_NET_SALES) + ABS(V_NET_TAX))*-1)
                                                  ELSE
                                                     V_NET_NON_MERCH + V_NET_SALES + V_NET_TAX
                                                  END;
         V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT :=   COMMON_TOOLS.GET_SALES_LINE_AMOUNT(REC.TRANSACTION_GUID);
         V_TEMP_ROW.COST_CENTER_CODE            :=   COMMON_TOOLS.COST_CENTER_LOOK_UP_FNC(REC.COST_CENTER_CODE);
         V_TEMP_ROW.TRANSACTION_DATE            :=   REC.TRANSACTION_DATE;
         V_TEMP_ROW.TERMINAL_NUMBER             :=   REC.TERMINAL_NUMBER;
         V_TEMP_ROW.TRANSACTION_NUMBER          :=   REC.TRANSACTION_NUMBER;
         V_TEMP_ROW.TRANSACTION_GUID            :=   REC.TRANSACTION_GUID;
         V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER     :=   REC.CUSTOMER_ACCOUNT_NUMBER;
         V_TEMP_ROW.POS_TRANSACTION_CODE        :=   REC.POS_TRANSACTION_CODE;
         V_TEMP_ROW.TRAN_TIMESTAMP              :=   REC.TRAN_TIMESTAMP;
         V_TEMP_ROW.TRANSACTION_TYPE            :=   CASE WHEN V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT > 0 THEN 
                                                            'DEPOSIT'
                                                       WHEN V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT < 0 THEN 
                                                            'REDEMPTION'
                                                       ELSE 'NA'
                                                  END;
         V_CUM_AMT                            :=  (CASE WHEN REC.RNUM = 1 THEN
                                                       COMMON_TOOLS.FNC_GET_LATEST_CUM_AMT(REC.CUSTOMER_ACCOUNT_NUMBER)
                                                  ELSE
                                                        V_CUM_AMT
                                                  END)  + V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT;
         V_TEMP_ROW.CUSTOMER_NET_BALANCE        :=  V_CUM_AMT;
         V_TEMP_ROW.GL_DIVISION                 :=  REC.GL_DIVISION;
         V_TEMP_ROW.RLS_RUN_CYCLE               :=  REC.RLS_RUN_CYCLE;
         V_TEMP_ROW.LOAD_DATE                   :=  V_LOAD_DATE;

         TABLE_IU_PKG.CUST_DEP_DET_I_SP(V_TEMP_ROW);
         IF V_TEMP_ROW.TRANSACTION_TYPE = 'DEPOSIT' THEN
            V_CREDIT_ROW.CREDIT_ID                := SEQ_CREDIT_ID.nextval;
            V_CREDIT_ROW.COST_CENTER_CODE         := V_TEMP_ROW.COST_CENTER_CODE;
            V_CREDIT_ROW.CUSTOMER_ACCOUNT_NUMBER  := V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER;
            V_CREDIT_ROW.TRANSACTION_NUMBER       := V_TEMP_ROW.TRANSACTION_NUMBER;
            V_CREDIT_ROW.TRANSACTION_DATE         := V_TEMP_ROW.TRANSACTION_DATE;
            V_CREDIT_ROW.TERMINAL_NUMBER          := V_TEMP_ROW.TERMINAL_NUMBER;           
            V_CREDIT_ROW.DEPOSIT_REMAINING_BAL    := V_TOTAL_SALES;
            V_CREDIT_ROW.DEPOSIT_REMAINING_BAL    := V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT;
            V_CREDIT_ROW.TRAN_TIMESTAMP           := V_TEMP_ROW.TRAN_TIMESTAMP;
            V_CREDIT_ROW.LOAD_DATE                := V_LOAD_DATE;
            
            TABLE_IU_PKG.CUST_DEPOSIT_CREDIT_I_SP(V_CREDIT_ROW);
         ELSIF V_TEMP_ROW.TRANSACTION_TYPE = 'REDEMPTION' THEN
               CUSTOMER_DEPOSIT_MAINT_PKG.ORIG_DEP_REM_BAL_UPD( V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT, REC.CUSTOMER_ACCOUNT_NUMBER, REC.TRANSACTION_DATE, V_ORIG_DEP_NBR, V_ORIG_TERM_NBR, V_ORIG_TRAN_DATE);
               V_REDEMPTION_ROW.REDEMPTION_ID            := SEQ_REDEMPTION_ID.nextval;
               V_REDEMPTION_ROW.COST_CENTER_CODE         := V_TEMP_ROW.COST_CENTER_CODE;
               V_REDEMPTION_ROW.CUSTOMER_ACCOUNT_NUMBER  := V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER;
               V_REDEMPTION_ROW.TRANSACTION_NUMBER       := V_TEMP_ROW.TRANSACTION_NUMBER;
               V_REDEMPTION_ROW.TRANSACTION_DATE         := V_TEMP_ROW.TRANSACTION_DATE;
               V_REDEMPTION_ROW.TERMINAL_NUMBER          := V_TEMP_ROW.TERMINAL_NUMBER;           
               V_REDEMPTION_ROW.ORIGINAL_DEP_TRANS_NBR   := V_ORIG_DEP_NBR;  
               V_REDEMPTION_ROW.ORIGINAL_DEP_TERM_NBR    := V_ORIG_TERM_NBR;
               V_REDEMPTION_ROW.ORIGINAL_DEP_TRAN_DATE   := V_ORIG_TRAN_DATE;
               V_REDEMPTION_ROW.TRAN_TIMESTAMP           := V_TEMP_ROW.TRAN_TIMESTAMP;
               V_REDEMPTION_ROW.LOAD_DATE                := V_LOAD_DATE;
               
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
END LOAD_CUSTOMER_DEPOSIT_DETAILS;

----reload the header and details
BEGIN
    FOR each_cycle IN( SELECT * FROM POS_CSTMR_DEP_LOAD_STATUS ORDER BY RLS_RUN_CYCLE) LOOP
        CUSTOMER_DEPOSITS_DAILY_LOAD.LOAD_CUSTOMER_DEPOSIT_HDR( each_cycle.RLS_RUN_CYCLE);
        CUSTOMER_DEPOSITS_DAILY_LOAD.LOAD_CUSTOMER_DEPOSIT_DETAILS(each_cycle.RLS_RUN_CYCLE);
    END LOOP;
END;
/