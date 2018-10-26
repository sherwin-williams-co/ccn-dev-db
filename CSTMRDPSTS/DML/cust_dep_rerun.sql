--create temp table and index on Transaction_date for
--CUST_DEP_CREDIT_DETAILS, CUST_DEP_REDEMPTION_DETAILS and CUSTOMER_DEPOSIT_DETAILS
--sxh487 10/25/2018

CREATE TABLE OPEN_BAL_ACCTS 
   (	CUSTOMER_NUMBER NUMBER(11,0), 
	STORE NUMBER(6,0), 
	TRAN_TYPE VARCHAR2(10 BYTE), 
	TRANS_NBR NUMBER(5,0), 
	TERMINAL_NUMBER NUMBER(5,0), 
	POS_TRANSACTION_CODE NUMBER(2,0), 
	TRAN_DATE DATE, 
	TRAN_TIMESTAMP VARCHAR2(31 BYTE), 
	CSTMR_DPST_SALES_LN_ITM_AMT NUMBER(7,2), 
	NEW_AMOUNT NUMBER(7,2), 
	DIFFERENCE NUMBER(18,13), 
	CUST_REM_BALANCE NUMBER(8,2), 
	ORIGINAL_DEP_TRANS_NBR NUMBER(5,0), 
	ORIGINAL_DEP_TERM_NBR NUMBER(5,0), 
	ORIGINAL_DEP_TRAN_DATE DATE, 
	REFERENCE_NUMBER VARCHAR2(1 BYTE), 
	CLEARED_REASON VARCHAR2(1 BYTE), 
	NOTES VARCHAR2(1 BYTE), 
	CLOSED_DATE VARCHAR2(1 BYTE), 
	GL_DIVISION VARCHAR2(4 BYTE)
   );

CREATE INDEX CUST_DEP_CREDIT_DETAILS_INDEX1 ON CUST_DEP_CREDIT_DETAILS (TRANSACTION_DATE);
CREATE INDEX CUST_DEP_REDEMPTION_DETAILS_I ON CUST_DEP_REDEMPTION_DETAILS (TRANSACTION_DATE);
CREATE INDEX CUSTOMER_DEPOSIT_DETAILS_INDE1 ON CUSTOMER_DEPOSIT_DETAILS (TRANSACTION_DATE);
/
/**************************************************
Created : sxh487 10/25/2018
          back up data and deleting the data before 01-SEP-2018
****************************************************/
create table CREDIT_DETAILS_BEFORE_01SEP AS select * from CUST_DEP_CREDIT_DETAILS;
create table REDEMPTION_DETAILS_BEFORE_01SEP AS select * from CUST_DEP_REDEMPTION_DETAILS;
create table CUST_DEP_DET_BEFORE_01SEP AS select * from CUSTOMER_DEPOSIT_DETAILS;
 
--Delete process
DELETE FROM CUST_DEP_CREDIT_DETAILS     WHERE TRUNC(TRANSACTION_DATE) < '01-SEP-2017';
DELETE FROM CUST_DEP_REDEMPTION_DETAILS WHERE TRUNC(TRANSACTION_DATE) < '01-SEP-2017';
DELETE FROM CUSTOMER_DEPOSIT_DETAILS    WHERE TRUNC(TRANSACTION_DATE) < '01-SEP-2017';
COMMIT;
/

DECLARE
--variable declaration
   CURSOR TEMP_CUR(IN_ACT_NBR VARCHAR2) IS
      SELECT STORE_NO  AS COST_CENTER_CODE,
             TRAN_DATE AS TRANSACTION_DATE,
             TERMNBR   AS TERMINAL_NUMBER,
             TRANNBR   AS TRANSACTION_NUMBER,
             TRAN_GUID AS TRANSACTION_GUID,
             ACCTNBR   AS CUSTOMER_ACCOUNT_NUMBER,
             TRANID    AS POS_TRANSACTION_CODE,
             TRAN_TIMESTAMP,
             RLS_RUN_CYCLE,
             ROW_NUMBER() OVER (PARTITION BY ACCTNBR ORDER BY  TRAN_TIMESTAMP, TERMNBR) AS RNUM
        FROM CCN_HEADERS_T H
       WHERE ACCTNBR = IN_ACT_NBR
         AND EXISTS (SELECT 1
                       FROM OPEN_BAL_ACCTS S
                      WHERE CUSTOMER_NUMBER  = ACCTNBR
                        AND SUBSTR(STORE, 3) = STORE_NO
                        AND TRANS_NBR        = TRANNBR
                        AND TERMINAL_NUMBER  = TERMNBR
                        AND TRAN_DATE        = H.TRAN_DATE);

   --variable declaration
   V_TEMP_ROW       CUSTOMER_DEPOSIT_DETAILS%ROWTYPE;
   V_CREDIT_ROW     CUST_DEP_CREDIT_DETAILS%ROWTYPE;
   V_REDEMPTION_ROW CUST_DEP_REDEMPTION_DETAILS%ROWTYPE;

   V_ORIG_DEP_NBR   CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_NUMBER%TYPE;
   V_ORIG_TERM_NBR  CUSTOMER_DEPOSIT_DETAILS.TERMINAL_NUMBER%TYPE;
   V_ORIG_TRAN_DATE CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_DATE%TYPE;
   V_LOAD_DATE      DATE := SYSDATE;
   
   V_RUNNING_TOTAL   NUMBER;

FUNCTION GET_NEW_AMOUNT(
/************************************************
Function to get the new amount from Marissa's file
*************************************************/
IN_CUSTOMER_ACCOUNT_NUMBER  IN CUSTOMER_DEPOSIT_DETAILS.CUSTOMER_ACCOUNT_NUMBER%TYPE,
IN_COST_CENTER_CODE         IN CUSTOMER_DEPOSIT_DETAILS.COST_CENTER_CODE%TYPE,
IN_TRANSACTION_NUMBER       IN CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_NUMBER%TYPE,
IN_TERMINAL_NUMBER          IN CUSTOMER_DEPOSIT_DETAILS.TERMINAL_NUMBER%TYPE,
IN_TRANSACTION_DATE         IN CUSTOMER_DEPOSIT_DETAILS.TRANSACTION_DATE%TYPE)
RETURN NUMBER IS

V_CSTMR_DPST_SALES_LN_ITM_AMT CUSTOMER_DEPOSIT_DETAILS.CSTMR_DPST_SALES_LN_ITM_AMT%TYPE;
BEGIN
    SELECT NEW_AMOUNT
      INTO V_CSTMR_DPST_SALES_LN_ITM_AMT
      FROM OPEN_BAL_ACCTS S
     WHERE CUSTOMER_NUMBER  = IN_CUSTOMER_ACCOUNT_NUMBER
       AND SUBSTR(STORE, 3) = IN_COST_CENTER_CODE
       AND TRANS_NBR        = IN_TRANSACTION_NUMBER
       AND TERMINAL_NUMBER  = IN_TERMINAL_NUMBER
       AND TRAN_DATE        = IN_TRANSACTION_DATE;
       
    RETURN V_CSTMR_DPST_SALES_LN_ITM_AMT;
EXCEPTION
    WHEN OTHERS THEN
         RETURN V_CSTMR_DPST_SALES_LN_ITM_AMT; 
END GET_NEW_AMOUNT;

BEGIN
FOR rec1 IN (SELECT DISTINCT CUSTOMER_NUMBER FROM OPEN_BAL_ACCTS ORDER BY 1 ) LOOP --test using individual accounts here
   FOR REC IN TEMP_CUR(rec1.CUSTOMER_NUMBER) LOOP
      BEGIN
--         V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT :=   COMMON_TOOLS.GET_SALES_LINE_AMOUNT(REC.TRANSACTION_GUID);
         V_TEMP_ROW.CSTMR_DPST_SALES_LN_ITM_AMT :=   GET_NEW_AMOUNT(REC.CUSTOMER_ACCOUNT_NUMBER, REC.COST_CENTER_CODE, REC.TRANSACTION_NUMBER, REC.TERMINAL_NUMBER, REC.TRANSACTION_DATE);
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
         V_TEMP_ROW.CUSTOMER_NET_BALANCE        :=  0;
         V_TEMP_ROW.GL_DIVISION                 :=  COMMON_TOOLS.GET_GL_DIVISION(V_TEMP_ROW.COST_CENTER_CODE);
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
      EXCEPTION
         WHEN OTHERS THEN
              ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'MANUAL_CORECTION', SQLERRM, V_TEMP_ROW.COST_CENTER_CODE, V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER, 'CUSTOMER_DEPOSIT_DETAILS');
      END;
   END LOOP;

   V_RUNNING_TOTAL := 0;
   FOR rec IN (SELECT * FROM CUSTOMER_DEPOSIT_DETAILS WHERE CUSTOMER_ACCOUNT_NUMBER = rec1.CUSTOMER_NUMBER ORDER BY TRAN_TIMESTAMP) LOOP
       V_RUNNING_TOTAL := V_RUNNING_TOTAL + rec.CSTMR_DPST_SALES_LN_ITM_AMT;
       UPDATE CUSTOMER_DEPOSIT_DETAILS
          SET CUSTOMER_NET_BALANCE = V_RUNNING_TOTAL
        WHERE TRANSACTION_GUID = rec.TRANSACTION_GUID
          AND CUSTOMER_NET_BALANCE <> V_RUNNING_TOTAL;

       IF rec.TRANSACTION_TYPE = 'REDEMPTION' AND rec.TRANSACTION_DATE >= '01-SEP-2017' THEN
               CUSTOMER_DEPOSIT_MAINT_PKG.ORIG_DEP_REM_BAL_UPD(rec.CSTMR_DPST_SALES_LN_ITM_AMT, rec.CUSTOMER_ACCOUNT_NUMBER, rec.TRANSACTION_DATE, V_ORIG_DEP_NBR, V_ORIG_TERM_NBR, V_ORIG_TRAN_DATE);
               
               V_REDEMPTION_ROW.REDEMPTION_ID            := SEQ_REDEMPTION_ID.nextval;
               V_REDEMPTION_ROW.COST_CENTER_CODE         := rec.COST_CENTER_CODE;
               V_REDEMPTION_ROW.CUSTOMER_ACCOUNT_NUMBER  := rec.CUSTOMER_ACCOUNT_NUMBER;
               V_REDEMPTION_ROW.TRANSACTION_NUMBER       := rec.TRANSACTION_NUMBER;
               V_REDEMPTION_ROW.TRANSACTION_DATE         := rec.TRANSACTION_DATE;
               V_REDEMPTION_ROW.TERMINAL_NUMBER          := rec.TERMINAL_NUMBER;           
               V_REDEMPTION_ROW.ORIGINAL_DEP_TRANS_NBR   := V_ORIG_DEP_NBR;  
               V_REDEMPTION_ROW.ORIGINAL_DEP_TERM_NBR    := V_ORIG_TERM_NBR;
               V_REDEMPTION_ROW.ORIGINAL_DEP_TRAN_DATE   := V_ORIG_TRAN_DATE;
               V_REDEMPTION_ROW.TRAN_TIMESTAMP           := rec.TRAN_TIMESTAMP;
               V_REDEMPTION_ROW.LOAD_DATE                := V_LOAD_DATE;
               
               TABLE_IU_PKG.CUST_DEPOSIT_REDEMPTION_I_SP(V_REDEMPTION_ROW);
       END IF;
   END LOOP;

   COMMIT;
END LOOP;
EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'MANUAL_CORECTION', SQLERRM, '000000', '000000000', '000000000');
END;
/